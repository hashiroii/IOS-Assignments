import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!

    let tracks = TrackLibrary.tracks
    var currentIndex = 0
    var isPlaying = false
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        loadTrack()
        updateUI()
    }

    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = player else {
            showError("Can't play \"\(tracks[currentIndex].title)\". The audio file is missing or broken.")
            return
        }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
        updateUI()
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        changeTrack(to: currentIndex + 1)
    }

    @IBAction func previousTapped(_ sender: UIButton) {
        changeTrack(to: currentIndex - 1)
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        changeTrack(to: currentIndex + 1)
    }

    func changeTrack(to index: Int) {
        currentIndex = (index + tracks.count) % tracks.count
        loadTrack()
        if isPlaying {
            player?.play()
        }
        updateUI()
    }

    func loadTrack() {
        player?.stop()
        player = nil
        let track = tracks[currentIndex]

        guard let url = Bundle.main.url(forResource: track.fileName, withExtension: "m4a") else {
            print("File not found: \(track.fileName).m4a")
            isPlaying = false
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
        } catch {
            print("Could not load \(track.fileName).m4a: \(error)")
            isPlaying = false
        }
    }

    func updateUI() {
        let track = tracks[currentIndex]
        coverImageView.image = UIImage(named: track.coverImageName)
        titleLabel.text = track.title
        artistLabel.text = track.artist
        let iconName = isPlaying ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: iconName), for: .normal)
    }

    func showError(_ message: String) {
        print(message)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
