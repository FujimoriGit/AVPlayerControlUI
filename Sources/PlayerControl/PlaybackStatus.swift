//
//  PlaybackStatus.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

import Foundation

public enum PlaybackStatus: Sendable {

    case idle
    case loading
    case playing
    case paused
    case ended
    case failed(any Error & Sendable)
}

extension PlaybackStatus: Equatable {

    public static func == (lhs: PlaybackStatus, rhs: PlaybackStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.playing, .playing),
             (.paused, .paused), (.ended, .ended):
            return true
        case let (.failed(l), .failed(r)):
            return (l as NSError).isEqual(r as NSError)
        default:
            return false
        }
    }
}
