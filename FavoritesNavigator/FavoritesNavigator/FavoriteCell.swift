import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func configure(with item: FavoriteItem) {
        flagImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
    }
}
