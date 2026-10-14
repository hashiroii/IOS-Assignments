import Foundation

struct Favorite {
    let title: String
    let subtitle: String
    let description: String
    let imageName: String
}

extension Favorite {
    static let all: [Favorite] = [
        Favorite(title: "Breaking Bad",
                 subtitle: "TV series · 2008–2013",
                 description: "A chemistry teacher starts cooking meth to secure his family's future and slowly becomes Heisenberg.",
                 imageName: "breaking_bad"),
        Favorite(title: "Better Call Saul",
                 subtitle: "TV series · 2015–2022",
                 description: "Small-time lawyer Jimmy McGill bends every rule on his way to becoming Saul Goodman.",
                 imageName: "better_call_saul"),
        Favorite(title: "Spider-Man: No Way Home",
                 subtitle: "Movie · 2021",
                 description: "Peter Parker's identity is exposed, and a spell gone wrong brings villains from other universes.",
                 imageName: "spider_man"),
        Favorite(title: "Supernatural",
                 subtitle: "TV series · 2005–2020",
                 description: "Brothers Sam and Dean Winchester drive across America hunting demons, ghosts and monsters.",
                 imageName: "supernatural"),
        Favorite(title: "Game of Thrones",
                 subtitle: "TV series · 2011–2019",
                 description: "Noble houses fight for the Iron Throne while an ancient threat gathers beyond the Wall.",
                 imageName: "game_of_thrones"),
        Favorite(title: "Interstellar",
                 subtitle: "Movie · 2014",
                 description: "Astronauts travel through a wormhole to find humanity a new home among the stars.",
                 imageName: "interstellar"),
        Favorite(title: "The Dark Knight",
                 subtitle: "Movie · 2008",
                 description: "Batman faces the Joker, a criminal mastermind who just wants to watch Gotham burn.",
                 imageName: "the_dark_knight"),
        Favorite(title: "Inception",
                 subtitle: "Movie · 2010",
                 description: "A thief who steals secrets from dreams is hired to plant an idea in someone's mind.",
                 imageName: "inception"),
        Favorite(title: "Peaky Blinders",
                 subtitle: "TV series · 2013–2022",
                 description: "After World War I, Thomas Shelby turns a Birmingham street gang into an empire.",
                 imageName: "peaky_blinders"),
        Favorite(title: "Stranger Things",
                 subtitle: "TV series · 2016–2025",
                 description: "A boy vanishes in Hawkins, and his friends uncover secret experiments and a terrifying world below.",
                 imageName: "stranger_things")
    ]
}
