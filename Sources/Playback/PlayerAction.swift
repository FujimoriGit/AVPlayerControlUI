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
