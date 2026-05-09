//
//  SubtitleTrack.swift
//  PlayerControl
//
//  Created by Daiki Fujimori on 2026/05/09
//

import Foundation

public struct SubtitleTrack: Identifiable, Equatable, Sendable {

    public let id: String
    public let displayName: String
    public let languageCode: String?

    public init(id: String, displayName: String, languageCode: String?) {
        self.id = id
        self.displayName = displayName
        self.languageCode = languageCode
    }
}
