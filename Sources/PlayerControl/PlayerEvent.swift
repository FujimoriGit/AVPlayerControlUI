//
//  PlayerEvent.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

public enum PlayerEvent: Sendable {

    case closeRequested
    case fullscreenRequested(Bool)
    case settingsRequested
}
