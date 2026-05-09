//
//  PlayerAction.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

import CoreMedia

public enum PlayerAction: Sendable {

    case play
    case pause
    case seek(CMTime)
    case selectSubtitle(SubtitleTrack?)
    case setControlsVisible(Bool)
    case requestFullscreen(Bool)
    case requestClose
}
