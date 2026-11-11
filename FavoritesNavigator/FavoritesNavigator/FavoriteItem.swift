import Foundation

struct FavoriteItem {
    let title: String
    let subtitle: String
    let imageName: String
    let rating: Int
    let description: String
}

enum FavoritesData {
    static let items = [
        FavoriteItem(title: "Japan", subtitle: "Tokyo · Asia", imageName: "japan", rating: 5,
                     description: "Japan mixes neon cities with quiet temples and gardens. I want to ride the Shinkansen from Tokyo to Kyoto and see the cherry blossoms in spring. The food alone, from ramen to sushi, is a reason to go."),
        FavoriteItem(title: "Italy", subtitle: "Rome · Europe", imageName: "italy", rating: 5,
                     description: "Italy has more history per square kilometre than almost anywhere else. I want to walk through the Colosseum, eat real pizza in Naples and see the canals of Venice. The Amalfi Coast is at the top of my list."),
        FavoriteItem(title: "Switzerland", subtitle: "Bern · Europe", imageName: "switzerland", rating: 5,
                     description: "Switzerland is the place for mountains and clean lakes. I would like to take the Glacier Express and see the Matterhorn up close. Swiss chocolate and fondue are a must."),
        FavoriteItem(title: "Norway", subtitle: "Oslo · Europe", imageName: "norway", rating: 5,
                     description: "Norway is famous for its deep fjords and the northern lights. I dream of a cruise through Geirangerfjord and a winter trip to Tromsø. The nature there looks unreal in every photo."),
        FavoriteItem(title: "France", subtitle: "Paris · Europe", imageName: "france", rating: 4,
                     description: "France is more than just Paris and the Eiffel Tower. I want to see the lavender fields of Provence and the castles of the Loire Valley. Fresh croissants every morning sound perfect."),
        FavoriteItem(title: "Federal Republic of Germany", subtitle: "Berlin · Europe", imageName: "germany", rating: 4,
                     description: "Germany has big modern cities and fairy-tale castles. I want to visit Berlin, Munich and Neuschwanstein Castle. Christmas markets in December would be the best time to go."),
        FavoriteItem(title: "Kingdom of Thailand", subtitle: "Bangkok · Asia", imageName: "thailand", rating: 4,
                     description: "Thailand is known for its beaches, islands and street food. I want to explore the temples of Bangkok and Chiang Mai. Island hopping around Phuket and Krabi is also on my plan."),
        FavoriteItem(title: "Sweden", subtitle: "Stockholm · Europe", imageName: "sweden", rating: 4,
                     description: "Sweden combines modern design with wild nature. Stockholm is built on fourteen islands, which makes it great for walking. In the north you can stay in the famous Ice Hotel."),
        FavoriteItem(title: "Austria", subtitle: "Vienna · Europe", imageName: "austria", rating: 4,
                     description: "Austria is the home of classical music and the Alps. I want to visit the palaces of Vienna and the old town of Salzburg. Hallstatt by the lake looks like a postcard."),
        FavoriteItem(title: "Kingdom of the Netherlands", subtitle: "Amsterdam · Europe", imageName: "netherlands", rating: 4,
                     description: "The Netherlands is flat, green and full of bicycles. I want to ride along the canals of Amsterdam and see the tulip fields in April. The windmills of Kinderdijk are also worth a visit."),
        FavoriteItem(title: "Denmark", subtitle: "Copenhagen · Europe", imageName: "denmark", rating: 3,
                     description: "Denmark is small but very cosy. Copenhagen has the colourful Nyhavn harbour and the Tivoli Gardens. It is also the birthplace of LEGO, so Billund is on my list."),
        FavoriteItem(title: "Finland", subtitle: "Helsinki · Europe", imageName: "finland", rating: 3,
                     description: "Finland is called the land of a thousand lakes. I want to try a real Finnish sauna and visit Lapland in winter. Seeing the northern lights from a glass igloo would be amazing."),
        FavoriteItem(title: "Ireland", subtitle: "Dublin · Europe", imageName: "ireland", rating: 3,
                     description: "Ireland is green, rainy and very friendly. I want to see the Cliffs of Moher and drive the Ring of Kerry. Live music in a Dublin pub is a must."),
        FavoriteItem(title: "Hungary", subtitle: "Budapest · Europe", imageName: "hungary", rating: 3,
                     description: "Hungary is best known for its beautiful capital, Budapest. The Parliament building on the Danube looks great at night. I also want to relax in the Széchenyi thermal baths."),
        FavoriteItem(title: "Poland", subtitle: "Warsaw · Europe", imageName: "poland", rating: 3,
                     description: "Poland has rich history and cheap, tasty food. I want to walk through the old town of Kraków and visit the Wieliczka Salt Mine. Pierogi are something I have to try there."),
        FavoriteItem(title: "Belgium", subtitle: "Brussels · Europe", imageName: "belgium", rating: 2,
                     description: "Belgium is famous for waffles, chocolate and fries. Bruges has medieval streets and canals that look like a movie set. Brussels has the Grand Place and the Atomium."),
        FavoriteItem(title: "Ukraine", subtitle: "Kyiv · Europe", imageName: "ukraine", rating: 2,
                     description: "Ukraine has old churches, wide fields and the Carpathian Mountains. Kyiv is known for its golden domes and the Kyiv Pechersk Lavra. Lviv has a charming old town and great coffee."),
        FavoriteItem(title: "Estonia", subtitle: "Tallinn · Europe", imageName: "estonia", rating: 2,
                     description: "Estonia is a small Baltic country with a big digital life. Tallinn has one of the best preserved medieval old towns in Europe. The islands of Saaremaa are quiet and green."),
        FavoriteItem(title: "Lithuania", subtitle: "Vilnius · Europe", imageName: "lithuania", rating: 1,
                     description: "Lithuania is known for its baroque capital, Vilnius. The Hill of Crosses is one of the most unusual places in the region. The Curonian Spit has huge sand dunes by the sea."),
        FavoriteItem(title: "People's Republic of Bangladesh", subtitle: "Dhaka · Asia", imageName: "bangladesh", rating: 0,
                     description: "Bangladesh is a country of rivers and green delta land. The Sundarbans is the largest mangrove forest in the world and the home of the Bengal tiger. Cox's Bazar has one of the longest natural beaches.")
    ]
}
