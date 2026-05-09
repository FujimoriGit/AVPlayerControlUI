//
//  PlaybackAdapter.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

import CoreMedia

@MainActor
public protocol PlaybackAdapter {

    var stateStream: AsyncStream<PlaybackEngineState> { get }

    func play()
    func pause()
    func seek(to time: CMTime) async
    func selectSubtitle(_ track: SubtitleTrack?) async
}
