//
//  PlaybackStore.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

import Combine
import CoreMedia
import Foundation

@MainActor
public final class PlaybackStore: ObservableObject {

    @Published public private(set) var state: PlayerState

    public var events: AnyPublisher<PlayerEvent, Never> {
        eventsSubject.eraseToAnyPublisher()
    }

    private let adapter: any PlaybackAdapter
    private let eventsSubject = PassthroughSubject<PlayerEvent, Never>()
    private var observerTask: Task<Void, Never>?

    public init(adapter: any PlaybackAdapter) {
        self.adapter = adapter
        self.state = PlayerState()
        startObserving()
    }

    deinit {
        observerTask?.cancel()
    }

    public func dispatch(_ action: PlayerAction) {
        switch action {
        case .play:
            adapter.play()
        case .pause:
            adapter.pause()
        case .seek(let time):
            Task { @MainActor [adapter] in
                await adapter.seek(to: time)
            }
        case .selectSubtitle(let track):
            Task { @MainActor [adapter] in
                await adapter.selectSubtitle(track)
            }
        case .setControlsVisible(let visible):
            state.areControlsVisible = visible
        case .requestFullscreen(let on):
            state.isFullscreen = on
            eventsSubject.send(.fullscreenRequested(on))
        case .requestClose:
            eventsSubject.send(.closeRequested)
        }
    }

    private func startObserving() {
        let stream = adapter.stateStream
        observerTask = Task { @MainActor [weak self] in
            for await engineState in stream {
                guard let self else { return }
                self.applyEngineState(engineState)
            }
        }
    }

    private func applyEngineState(_ engineState: PlaybackEngineState) {
        state.status = engineState.status
        state.currentTime = engineState.currentTime
        state.duration = engineState.duration
        state.rate = engineState.rate
        state.bufferedSeconds = engineState.bufferedSeconds
        state.subtitleTracks = engineState.subtitleTracks
        state.selectedSubtitleTrackID = engineState.selectedSubtitleTrackID
    }
}
