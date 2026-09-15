import Foundation

var firstName: String = "Magzhan"
var lastName: String = "Mubarakuly"
var age: Int = 20
var birthYear: Int = 2006
var isStudent: Bool = true
var height: Double = 1.79

var city: String = "Almaty"
var favoriteFood: String = "Tofu"

let currentYear: Int = 2025
var calculatedAge: Int = currentYear - birthYear

var hobby: String = "break dance"
var numberOfHobbies: Int = 12
var favoriteNumber: Int = 7
var isHobbyCreative: Bool = true

var lifeStory: String = "My name is \(firstName) \(lastName). I am \(age) years old, i was born in \(birthYear). I am a student at the moment. About my hobbies, my favorite one is \(hobby)ing, which is a creative hobby. I have \(numberOfHobbies) hobbies in total, and my favorite number \(favoriteNumber)."

print(lifeStory)

var futureGoals: String = "In the future, I want to become a TeamLead"
var mood: String = "happy"

lifeStory += " \(futureGoals) Now I feel \(mood) "
print(lifeStory)
