import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var starImageViews: [UIImageView]!

    var item: FavoriteItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item else { return }
        title = item.title
        flagImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        descriptionLabel.text = item.description
        for (index, starImageView) in starImageViews.enumerated() {
            starImageView.image = UIImage(systemName: index < item.rating ? "star.fill" : "star")
        }
    }
}
