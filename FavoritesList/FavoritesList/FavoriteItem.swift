import Foundation

struct FavoriteItem {
    let title: String
    let subtitle: String
    let imageName: String
    let rating: Int
}

enum FavoritesData {
    static let items = [
        FavoriteItem(title: "Japan", subtitle: "Tokyo · Asia", imageName: "japan", rating: 5),
        FavoriteItem(title: "Italy", subtitle: "Rome · Europe", imageName: "italy", rating: 5),
        FavoriteItem(title: "Switzerland", subtitle: "Bern · Europe", imageName: "switzerland", rating: 5),
        FavoriteItem(title: "Norway", subtitle: "Oslo · Europe", imageName: "norway", rating: 5),
        FavoriteItem(title: "France", subtitle: "Paris · Europe", imageName: "france", rating: 4),
        FavoriteItem(title: "Federal Republic of Germany", subtitle: "Berlin · Europe", imageName: "germany", rating: 4),
        FavoriteItem(title: "Kingdom of Thailand", subtitle: "Bangkok · Asia", imageName: "thailand", rating: 4),
        FavoriteItem(title: "Sweden", subtitle: "Stockholm · Europe", imageName: "sweden", rating: 4),
        FavoriteItem(title: "Austria", subtitle: "Vienna · Europe", imageName: "austria", rating: 4),
        FavoriteItem(title: "Kingdom of the Netherlands", subtitle: "Amsterdam · Europe", imageName: "netherlands", rating: 4),
        FavoriteItem(title: "Denmark", subtitle: "Copenhagen · Europe", imageName: "denmark", rating: 3),
        FavoriteItem(title: "Finland", subtitle: "Helsinki · Europe", imageName: "finland", rating: 3),
        FavoriteItem(title: "Ireland", subtitle: "Dublin · Europe", imageName: "ireland", rating: 3),
        FavoriteItem(title: "Hungary", subtitle: "Budapest · Europe", imageName: "hungary", rating: 3),
        FavoriteItem(title: "Poland", subtitle: "Warsaw · Europe", imageName: "poland", rating: 3),
        FavoriteItem(title: "Belgium", subtitle: "Brussels · Europe", imageName: "belgium", rating: 2),
        FavoriteItem(title: "Ukraine", subtitle: "Kyiv · Europe", imageName: "ukraine", rating: 2),
        FavoriteItem(title: "Estonia", subtitle: "Tallinn · Europe", imageName: "estonia", rating: 2),
        FavoriteItem(title: "Lithuania", subtitle: "Vilnius · Europe", imageName: "lithuania", rating: 1),
        FavoriteItem(title: "People's Republic of Bangladesh", subtitle: "Dhaka · Asia", imageName: "bangladesh", rating: 0)
    ]
}
