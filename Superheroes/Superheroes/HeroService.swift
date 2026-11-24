import Foundation

final class HeroService {

    static let shared = HeroService()

    private let allHeroesURL = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json")!

    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        URLSession.shared.dataTask(with: allHeroesURL) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let data, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            do {
                completion(.success(try JSONDecoder().decode([Hero].self, from: data)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchImageData(from urlString: String?, completion: @escaping (Data?) -> Void) {
        guard let urlString, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data)
        }.resume()
    }
}
