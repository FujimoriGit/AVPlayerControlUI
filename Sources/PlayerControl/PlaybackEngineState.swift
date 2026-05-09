//
//  PlaybackEngineState.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

import CoreMedia

public struct PlaybackEngineState: Equatable, Sendable {

    public var status: PlaybackStatus
    public var currentTime: CMTime
    public var duration: CMTime
    public var rate: Float
    public var bufferedSeconds: Double
    public var subtitleTracks: [SubtitleTrack]
    public var selectedSubtitleTrackID: SubtitleTrack.ID?

    public init(
        status: PlaybackStatus = .idle,
        currentTime: CMTime = .zero,
        duration: CMTime = .zero,
        rate: Float = 0,
        bufferedSeconds: Double = 0,
        subtitleTracks: [SubtitleTrack] = [],
        selectedSubtitleTrackID: SubtitleTrack.ID? = nil
    ) {
        self.status = status
        self.currentTime = currentTime
        self.duration = duration
        self.rate = rate
        self.bufferedSeconds = bufferedSeconds
        self.subtitleTracks = subtitleTracks
        self.selectedSubtitleTrackID = selectedSubtitleTrackID
    }
}
