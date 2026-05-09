//
//  AVPlayerAdapter.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

import AVFoundation
import CoreMedia

@MainActor
public final class AVPlayerAdapter: PlaybackAdapter {

    public let player: AVPlayer
    public let stateStream: AsyncStream<PlaybackEngineState>

    private let continuation: AsyncStream<PlaybackEngineState>.Continuation
    private var currentState = PlaybackEngineState()
    private var observations: Set<NSKeyValueObservation> = []
    private var periodicTimeObserverToken: Any?

    public init(player: AVPlayer) {
        self.player = player

        var continuation: AsyncStream<PlaybackEngineState>.Continuation!
        let stream = AsyncStream<PlaybackEngineState> { c in
            continuation = c
        }
        self.stateStream = stream
        self.continuation = continuation

        startObserving()
    }

    public func play() {
        player.play()
    }

    public func pause() {
        player.pause()
    }

    public func seek(to time: CMTime) async {
        await withCheckedContinuation { continuation in
            player.seek(
                to: time,
                toleranceBefore: .zero,
                toleranceAfter: .zero
            ) { _ in
                continuation.resume()
            }
        }
    }

    public func selectSubtitle(_ track: SubtitleTrack?) async {
        // TODO: AVMediaSelectionGroup ベースの字幕切り替えを実装
    }

    /// 観測の停止と AsyncStream の終了を明示的に行う。
    /// MainActor 隔離下で呼ぶ必要があるため deinit からは呼べない。
    public func stop() {
        if let token = periodicTimeObserverToken {
            player.removeTimeObserver(token)
            periodicTimeObserverToken = nil
        }
        observations.removeAll()
        continuation.finish()
    }

    private func startObserving() {
        let timeControlObs = player.observe(
            \.timeControlStatus,
             options: [.initial, .new]
        ) { [weak self] player, _ in
            let timeControlStatus = player.timeControlStatus
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.currentState.status = Self.mapStatus(timeControlStatus)
                self.currentState.rate = self.player.rate
                self.publish()
            }
        }
        observations.insert(timeControlObs)

        let interval = CMTime(
            seconds: 0.5,
            preferredTimescale: CMTimeScale(NSEC_PER_SEC)
        )
        periodicTimeObserverToken = player.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.currentState.currentTime = time
                if let duration = self.player.currentItem?.duration,
                   duration.isNumeric {
                    self.currentState.duration = duration
                }
                self.publish()
            }
        }
    }

    private func publish() {
        continuation.yield(currentState)
    }

    nonisolated private static func mapStatus(
        _ status: AVPlayer.TimeControlStatus
    ) -> PlaybackStatus {
        switch status {
        case .playing:
            return .playing
        case .paused:
            return .paused
        case .waitingToPlayAtSpecifiedRate:
            return .loading
        @unknown default:
            return .idle
        }
    }
}
