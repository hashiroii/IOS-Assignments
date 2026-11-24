import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var heroes: [Hero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadHeroes()
    }

    private func loadHeroes() {
        activityIndicator.startAnimating()
        HeroService.shared.fetchHeroes { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.activityIndicator.stopAnimating()
                switch result {
                case .success(let heroes):
                    self.heroes = heroes
                    self.tableView.reloadData()
                case .failure:
                    self.showError()
                }
            }
        }
    }

    private func showError() {
        let alert = UIAlertController(title: "Couldn't load heroes", message: "Check your connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadHeroes()
        })
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroCell
        cell.configure(with: heroes[indexPath.row])
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetail",
              let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell),
              let detail = segue.destination as? DetailViewController else { return }
        detail.hero = heroes[indexPath.row]
    }
}
