import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private let favorites = Favorite.all
    private var currentIndex: Int?

    @IBAction func spinTapped(_ sender: UIButton) {
        guard favorites.isEmpty == false else { return }
        let index = nextRandomIndex()
        currentIndex = index
        show(favorites[index])
    }

    private func nextRandomIndex() -> Int {
        guard favorites.count > 1 else { return 0 }
        var index = Int.random(in: 0..<favorites.count)
        while index == currentIndex {
            index = Int.random(in: 0..<favorites.count)
        }
        return index
    }

    private func show(_ favorite: Favorite) {
        UIView.transition(with: cardView, duration: 0.3, options: .transitionCrossDissolve) {
            self.posterImageView.image = UIImage(named: favorite.imageName)
            self.titleLabel.text = favorite.title
            self.subtitleLabel.text = favorite.subtitle
            self.descriptionLabel.text = favorite.description
        }
    }
}
