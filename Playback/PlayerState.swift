import CoreMedia

public struct PlayerState: Equatable, Sendable {

    public var status: PlaybackStatus
    public var currentTime: CMTime
    public var duration: CMTime
    public var rate: Float
    public var bufferedSeconds: Double
    public var subtitleTracks: [SubtitleTrack]
    public var selectedSubtitleTrackID: SubtitleTrack.ID?
    public var isFullscreen: Bool
    public var areControlsVisible: Bool

    public init(
        status: PlaybackStatus = .idle,
        currentTime: CMTime = .zero,
        duration: CMTime = .zero,
        rate: Float = 0,
        bufferedSeconds: Double = 0,
        subtitleTracks: [SubtitleTrack] = [],
        selectedSubtitleTrackID: SubtitleTrack.ID? = nil,
        isFullscreen: Bool = false,
        areControlsVisible: Bool = true
    ) {
        self.status = status
        self.currentTime = currentTime
        self.duration = duration
        self.rate = rate
        self.bufferedSeconds = bufferedSeconds
        self.subtitleTracks = subtitleTracks
        self.selectedSubtitleTrackID = selectedSubtitleTrackID
        self.isFullscreen = isFullscreen
        self.areControlsVisible = areControlsVisible
    }
}
