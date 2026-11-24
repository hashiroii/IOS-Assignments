import UIKit

class HeroCell: UITableViewCell {

    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func configure(with hero: Hero) {
        nameLabel.text = hero.name
        switch hero.gender {
        case .male:
            genderImageView.image = UIImage(systemName: "figure.stand")
            genderImageView.tintColor = .systemBlue
        case .female:
            genderImageView.image = UIImage(systemName: "figure.stand.dress")
            genderImageView.tintColor = .systemPink
        case .unknown:
            genderImageView.image = UIImage(systemName: "questionmark.circle")
            genderImageView.tintColor = .systemGray
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.contentView.transform = highlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            self.contentView.alpha = highlighted ? 0.6 : 1
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.removeAllAnimations()
        contentView.transform = .identity
        contentView.alpha = 1
    }
}
