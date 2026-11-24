import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var sectionControl: UISegmentedControl!
    @IBOutlet weak var statsStack: UIStackView!
    @IBOutlet weak var appearanceStack: UIStackView!
    @IBOutlet weak var biographyStack: UIStackView!
    @IBOutlet var statBars: [UIProgressView]!
    @IBOutlet var statValueLabels: [UILabel]!
    @IBOutlet var infoValueLabels: [UILabel]!

    var hero: Hero!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero.name
        nameLabel.text = hero.name
        publisherLabel.text = hero.biography.publisher.orUnknown
        showPlaceholder()
        loadImage()
        fillStats()
        fillInfo()
        showSection(0, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateStats()
    }

    @IBAction func sectionChanged(_ sender: UISegmentedControl) {
        showSection(sender.selectedSegmentIndex, animated: true)
        if sender.selectedSegmentIndex == 0 {
            animateStats()
        }
    }

    private func showSection(_ index: Int, animated: Bool) {
        let stacks = [statsStack, appearanceStack, biographyStack]
        let changes = {
            for (i, stack) in stacks.enumerated() {
                stack?.isHidden = i != index
                stack?.alpha = i == index ? 1 : 0
            }
        }
        if animated {
            UIView.animate(withDuration: 0.25, animations: changes)
        } else {
            changes()
        }
    }

    private func showPlaceholder() {
        let config = UIImage.SymbolConfiguration(pointSize: 80)
        heroImageView.contentMode = .center
        heroImageView.tintColor = .tertiaryLabel
        heroImageView.image = UIImage(systemName: "person.fill", withConfiguration: config)
    }

    private func loadImage() {
        HeroService.shared.fetchImageData(from: hero.images.md) { [weak self] data in
            guard let data else { return }
            DispatchQueue.main.async {
                guard let self, let image = UIImage(data: data) else { return }
                UIView.transition(with: self.heroImageView, duration: 0.3, options: .transitionCrossDissolve) {
                    self.heroImageView.contentMode = .scaleAspectFit
                    self.heroImageView.image = image
                }
            }
        }
    }

    private func fillStats() {
        let values = hero.powerstats.values
        for label in statValueLabels {
            label.text = values[label.tag].map(String.init) ?? "Unknown"
        }
        for bar in statBars {
            bar.progressTintColor = color(forStat: values[bar.tag])
            bar.progress = 0
        }
    }

    private func animateStats() {
        let values = hero.powerstats.values
        for bar in statBars {
            bar.progress = 0
        }
        UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveEaseOut) {
            for bar in self.statBars {
                bar.setProgress(Float(values[bar.tag] ?? 0) / 100, animated: true)
            }
        }
    }

    private func color(forStat value: Int?) -> UIColor {
        switch value ?? 0 {
        case 70...: return .systemGreen
        case 40..<70: return .systemOrange
        default: return .systemRed
        }
    }

    private func fillInfo() {
        let appearance = hero.appearance
        let biography = hero.biography
        let values = [
            appearance.race.orUnknown,
            hero.heightText,
            hero.weightText,
            appearance.eyeColor.orUnknown,
            appearance.hairColor.orUnknown,
            biography.fullName.orUnknown,
            biography.placeOfBirth.orUnknown,
            biography.firstAppearance.orUnknown,
            biography.alignment.orUnknown.capitalized
        ]
        for label in infoValueLabels {
            label.text = values[label.tag]
            if label.tag == 8 {
                label.textColor = color(forAlignment: biography.alignment)
            }
        }
    }

    private func color(forAlignment alignment: String?) -> UIColor {
        switch alignment {
        case "good": return .systemGreen
        case "bad": return .systemRed
        default: return .label
        }
    }
}
