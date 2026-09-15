import UIKit

// EASY

// 1
let fruits = ["apple", "banana", "cherry", "lemon", "lime"]
var fruitsVariation: Array<String> = ["apple", "banana", "cherry", "lemon", "lime"]

print(fruits[2])

// 2
var uniqueNumbers = Set([1,2,3,4,5,6])
uniqueNumbers.insert(7)

print(uniqueNumbers)

// 3
let programLanguages = ["swift": 2014, "python": 1991, "javascript": 1995]

if let languageYear = programLanguages["swift"] {
    print("swift's year is \(languageYear)")
} else {
    print("There is no swift")
}

// MEDIUM

// 1
let firstNumberSet: Set = [1,2,3,4]
let secondNumberSet: Set = [3,4,5,6]

let intersectionSet = firstNumberSet.intersection(secondNumberSet)
print(intersectionSet)

// 2
var studentScores = ["Magzhan": 100, "Maraldym": 80, "Dante": 75]
studentScores["Dante"] = 77

print(studentScores)

// 3
let firstArray = ["apple", "banana"]
let secondArray = ["cherry", "date"]

let mergedArray = firstArray + secondArray

print(mergedArray)

// HARD

// 1
var countryPopulation = ["Kazakhstan": 20604819, "Russia": 146119928]

countryPopulation["China"] = 1412235514

print(countryPopulation)

// 2
let firstSet: Set = ["dog", "cat"]
let secondSet: Set = ["dog", "mouse"]

let unionSet = firstSet.union(secondSet)

let finalSet = unionSet.subtracting(secondSet)

print(finalSet)

// 3
let studentGrades: [String: [Int]] = [
    "Aktan": [90, 85, 92],
    "Diana": [78, 82, 88],
    "Nur": [95, 98, 91]
]

if let grades = studentGrades["Diana"], grades.count > 1 {
    let secondGrade = grades[1]
    print(grades[1])
} else {
    print("no student like that or he has no 2 subjects")
}
