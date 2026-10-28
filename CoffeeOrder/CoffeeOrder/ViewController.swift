import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet var sizeButtons: [UIButton]!

    let prices = [4.50, 5.25, 6.00]
    var selectedSize = 1
    var quantity = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Iced Caramel Oat Milk Latte"
        descriptionLabel.text = "Espresso with caramel syrup, creamy oat milk and lots of ice."
        updateUI()
    }

    @IBAction func sizeTapped(_ sender: UIButton) {
        selectedSize = sender.tag
        updateUI()
    }

    @IBAction func quantityChanged(_ sender: UIStepper) {
        quantity = Int(sender.value)
        updateUI()
    }

    @IBAction func orderTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Order placed", message: "Your coffee is on the way!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func updateUI() {
        let price = prices[selectedSize]
        priceLabel.text = String(format: "$%.2f", price)
        quantityLabel.text = "Quantity: \(quantity)"
        orderButton.setTitle(String(format: "Order · $%.2f", price * Double(quantity)), for: .normal)

        for button in sizeButtons {
            if button.tag == selectedSize {
                button.backgroundColor = UIColor(red: 0.44, green: 0.27, blue: 0.16, alpha: 1)
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.88, alpha: 1)
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
}
