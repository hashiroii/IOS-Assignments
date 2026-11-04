import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet var starImageViews: [UIImageView]!

    func configure(with item: FavoriteItem) {
        flagImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        for (index, starImageView) in starImageViews.enumerated() {
            starImageView.image = UIImage(systemName: index < item.rating ? "star.fill" : "star")
        }
    }
}
