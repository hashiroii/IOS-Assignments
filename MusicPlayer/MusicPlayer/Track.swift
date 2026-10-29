import Foundation

struct Track {
    let title: String
    let artist: String
    let fileName: String
    let coverImageName: String
}

enum TrackLibrary {
    static let tracks = [
        Track(title: "Neon Drive", artist: "Night Circuit", fileName: "neon_drive", coverImageName: "neon_drive"),
        Track(title: "Morning Coffee", artist: "Lo-Fi Kitchen", fileName: "morning_coffee", coverImageName: "morning_coffee"),
        Track(title: "City Lights", artist: "Metro Bloom", fileName: "city_lights", coverImageName: "city_lights"),
        Track(title: "Slow Waves", artist: "Blue Harbor", fileName: "slow_waves", coverImageName: "slow_waves"),
        Track(title: "Pixel Quest", artist: "8-Bit Heroes", fileName: "pixel_quest", coverImageName: "pixel_quest"),
        Track(title: "Midnight Rain", artist: "Quiet Streets", fileName: "midnight_rain", coverImageName: "midnight_rain"),
        Track(title: "Golden Hour", artist: "Sunset Tape", fileName: "golden_hour", coverImageName: "golden_hour"),
        Track(title: "Deep Space", artist: "Orbit Seven", fileName: "deep_space", coverImageName: "deep_space"),
        Track(title: "Summer Road", artist: "Coastline", fileName: "summer_road", coverImageName: "summer_road"),
        Track(title: "Last Train", artist: "Platform Nine", fileName: "last_train", coverImageName: "last_train")
    ]
}
