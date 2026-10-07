// =============================================================
//  Station ALMA-7, Part II: The Teleporter Incident
//  iOS Mobile Development · Module 4 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part2_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Default to struct. Use class only where the task says so.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Splits a line into fields.
/// fields("crate:101:120")            -> ["crate", "101", "120"]
/// fields("livestock:lab mice:12:2")  -> ["livestock", "lab mice", "12", "2"]
/// fields("junk")                     -> ["junk"]
func fields(_ line: String, separatedBy separator: Character = ":") -> [String] {
    var result: [String] = []
    var current = ""
    for character in line {
        if character == separator {
            result.append(current)
            current = ""
        } else {
            current.append(character)
        }
    }
    result.append(current)
    return result
}

/// Cargo manifest as recovered from the damaged recorder.
let rawManifest = [
    "crate:101:120",
    "container:KZ-ALM-7:340",
    "livestock:lab mice:12:2",
    "???-corrupted-line",
    "crate:102:75",
    "container:KZ-ALM-9:410",
    "livestock:ficus:3:5",
    "crate:103:260",
    "crate:104:abc",
    ""
]

/// Oxygen readings. One of these deck names is not a real deck.
let deckReadings: [(deck: String, oxygen: Int)] = [
    (deck: "bridge",     oxygen: 78),
    (deck: "lab",        oxygen: 64),
    (deck: "greenhouse", oxygen: 55),
    (deck: "cargo",      oxygen: 12),
    (deck: "medbay",     oxygen: 90),
    (deck: "engine",     oxygen: 41)
]

/// Crew records, straight from the personnel file.
let crewData: [(name: String, deck: String, oxygen: Int)] = [
    (name: "Timur",   deck: "engine", oxygen: 62),
    (name: "Dana",    deck: "lab",    oxygen: 48),
    (name: "Aigerim", deck: "bridge", oxygen: 91),
    (name: "Nurlan",  deck: "cargo",  oxygen: 17)
]

print("ALMA-7 recorder online: \(rawManifest.count) manifest lines, \(deckReadings.count) readings, \(crewData.count) crew records.")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Deck Register

// 1.1
// enum Deck: String, CaseIterable { }

// 1.2
// enum AlarmLevel: Int { }


// MARK: Level 2 · The Manifest

// 2.1
// enum ManifestEntry { }

// 2.2
// func parseEntry(_ line: String) -> ManifestEntry { }

// 2.3
// func mass(of entry: ManifestEntry) -> Int { }

// let A = ...


// MARK: Level 3 · Crew Snapshots

// 3.1
// struct CrewSnapshot { }

// 3.2
// let crewRoster: [CrewSnapshot] = ...

// 3.3 · Value-semantics demonstration (copy / plain parameter / inout)


// MARK: Level 4 · The Teleport Pod

// 4.1
// final class TeleportPod { }

// 4.2 · Charge ledger: load+fire three times, then fire an empty pod
// let C = ...

// 4.3 · Reference-semantics demonstration


// MARK: Level 5 · Station Systems

// 5.1
// final class Station { }

// let B = ...

// 5.2 · The clamp trap: 130, then -40, then 55


// MARK: Level 6 · Incident Reports
// Three of these compile and are wrong. One does not compile.
// For each: expectation, actual behaviour, the language rule, the fix.

/*
// Report 1
var roster = crewRoster
for var member in roster {
    member.oxygen -= 10
}
print(roster[0].oxygen)   // author expected the crew to have lost oxygen

// Report 2
let podA = TeleportPod(id: "A", chargeLevel: 100)
let podB = podA
podB.chargeLevel = 0
print(podA.chargeLevel)   // author expected 100

// Report 3
struct Logbook {
    var entries: [String] = []
    func add(_ entry: String) {
        entries.append(entry)
    }
}

// Report 4
let snapshot = CrewSnapshot.rookie(named: "Dana")
snapshot.oxygen = 40

let pod = TeleportPod(id: "B", chargeLevel: 50)
pod.chargeLevel = 10
*/


// MARK: Level 7 · Sealing the Black Box

// The leaky original:
//
// class FlightRecorder {
//     var entries: [String] = []
//     var isSealed = false
// }
//
// Your sealed version below. One comment per access keyword.

// final class FlightRecorder { }

// A free function elsewhere in the file that uses your fileprivate helper:
// func auditTranscript(of recorder: FlightRecorder) -> String { }


// MARK: Finale · Integrity Code

// let D = ...
// let integrityCode = "\(A)-\(B)-\(C)-\(D)"
// print("INTEGRITY CODE: \(integrityCode)")


// MARK: Bonus

// deinit in TeleportPod, a do-block lifetime experiment, and === identity


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?

 2. What does `mutating` do to self, and why do classes never need it?

 3. In Report 4 both values are `let`. What exactly does `let` freeze for a
    struct, and what does it freeze for a class?

 4. Why must a lazy property be var? When does lazy change behaviour, not
    just performance?

 5. private vs fileprivate: where in your FlightRecorder would private be
    too strict?

 Bonus. On which line does deinit fire, and why can't === be used on
 CrewSnapshot?

*/


enum Deck: String, CaseIterable {
    case bridge
    case lab
    case medbay
    case engine
    var evacuationPriority: Int {
        switch self {
        case .bridge: return 1
        case .medbay: return 2
        case .lab: return 3
        case .engine: return 4
        }
    }
}

for item in Deck.allCases {
    print("Deck \(item) has has priority \(item.evacuationPriority)")
}

print("Teleporter Diagnostic: The highest priority area is \(Deck.bridge) (Level \(Deck.bridge.evacuationPriority)) \n")

enum AlarmLevel: Int {
    case green = 0,
    yellow, orange, red
    
    static func level(forTotalMass mass: Int) -> AlarmLevel {
        let steps = mass / 500
        
        return AlarmLevel(rawValue: steps) ?? .red
    }
}

print(AlarmLevel.level(forTotalMass: 0))
print(AlarmLevel.level(forTotalMass: 993))
print(AlarmLevel.level(forTotalMass: 1002))
print(AlarmLevel.level(forTotalMass: 1600))

enum ManifestEntry {
    case crate(id: Int, massKg: Int)
    case container(code: String, massKg: Int)
    case livestock(species: String, count: Int, massPerUnitKg: Int)
    case unknown(raw: String)
}

func parseEntry(_ line: String) -> ManifestEntry {
    let parts = fields(line)
    
    guard !parts.isEmpty else { return .unknown(raw: line) }
    
    switch parts[0] {
    case "crate":
        if parts.count == 3,
           let parsedId = Int(parts[1]),
           let parsedMassKg = Int(parts[2]) {
            return .crate(id: parsedId, massKg: parsedMassKg)
        }
        
    case "container":
        if parts.count == 3,
           let parsedMassKg = Int(parts[2]) {
            return .container(code: parts[1], massKg: parsedMassKg)
        }
        
    case "livestock":
        if parts.count == 4,
           let parsedCount = Int(parts[2]),
           let parsedMassPerUnitKg = Int(parts[3]) {
            return .livestock(species: parts[1], count: parsedCount, massPerUnitKg: parsedMassPerUnitKg)
        }
        
    default:
        break
    }
        
    return .unknown(raw: line)
}

print(parseEntry("crate:101:120"))
print(parseEntry("container:KZ-ALM-7:340"))
print(parseEntry("livestock:lab mice:12:2"))
print(parseEntry("crate:brokenID:120"))
print(parseEntry("livestock:cows:5"))
print(parseEntry("alien_tech:unknown:500"))


func mass(of entry: ManifestEntry) -> Int {
    switch entry {
    case .crate(_, let massKg):
        return massKg
    case .container(_, let massKg):
        return massKg
    case .livestock(_, let count, let massPerUnitKg):
        return count * massPerUnitKg
    case .unknown:
        return 0
    }
}
 
print("\nLevel 2")
var totalMass = 0
var unknownCount = 0
for line in rawManifest {
    let entry = parseEntry(line)
    print("\(entry) -> \(mass(of: entry)) kg")
    totalMass += mass(of: entry)
    if case .unknown = entry {
        unknownCount += 1
    }
}
print("Unknown lines: \(unknownCount)")
print("Total manifest mass: \(totalMass) kg")
 
let A = totalMass
 
 
// MARK: Level 3 · Crew Snapshots
 
struct CrewSnapshot {
    let name: String
    var deck: Deck
    var oxygen: Int
 
    mutating func breathe(_ amount: Int) {
        oxygen -= amount
        if oxygen < 0 {
            oxygen = 0
        }
    }
 
    mutating func move(to deck: Deck) {
        self.deck = deck
    }
 
    mutating func reviveInMedbay() {
        self = CrewSnapshot(name: name, deck: .medbay, oxygen: 100)
    }
 
    static func rookie(named name: String) -> CrewSnapshot {
        return CrewSnapshot(name: name, deck: .bridge, oxygen: 100)
    }
}
 
func buildRoster() -> [CrewSnapshot] {
    var result: [CrewSnapshot] = []
    for record in crewData {
        if let deck = Deck(rawValue: record.deck) {
            result.append(CrewSnapshot(name: record.name, deck: deck, oxygen: record.oxygen))
        } else {
            print("Warning: \(record.name) is on unknown deck \(record.deck), skipped")
        }
    }
    return result
}
 
print("\nLevel 3")
let crewRoster: [CrewSnapshot] = buildRoster()
for member in crewRoster {
    print("\(member.name) on \(member.deck), oxygen \(member.oxygen)")
}
 
var testCrew = CrewSnapshot.rookie(named: "Aliya")
testCrew.breathe(30)
testCrew.move(to: .lab)
print("After breathe and move: \(testCrew.name) on \(testCrew.deck), oxygen \(testCrew.oxygen)")
testCrew.breathe(500)
print("After breathe(500): oxygen \(testCrew.oxygen)")
testCrew.reviveInMedbay()
print("After revive: \(testCrew.name) on \(testCrew.deck), oxygen \(testCrew.oxygen)")
 
print("\n1) Copy")
let original = CrewSnapshot.rookie(named: "Timur")
var copy = original
print("Before: original \(original.oxygen), copy \(copy.oxygen)")
copy.breathe(40)
print("After:  original \(original.oxygen), copy \(copy.oxygen)")
 
func drainPlain(_ crew: CrewSnapshot) {
    var local = crew
    local.breathe(40)
    print("Inside plain function: \(local.oxygen)")
}
 
func drainInout(_ crew: inout CrewSnapshot) {
    crew.breathe(40)
    print("Inside inout function: \(crew.oxygen)")
}
 
print("2) Plain parameter")
let plainCrew = CrewSnapshot.rookie(named: "Dana")
print("Before: \(plainCrew.oxygen)")
drainPlain(plainCrew)
print("After:  \(plainCrew.oxygen)")
 
print("3) inout parameter")
var inoutCrew = CrewSnapshot.rookie(named: "Nurlan")
print("Before: \(inoutCrew.oxygen)")
drainInout(&inoutCrew)
print("After:  \(inoutCrew.oxygen)")
 
 
// MARK: Level 4 · The Teleport Pod
 
/* A struct gets a free memberwise initializer because Swift can safely set its properties one by one. Classes do not get one (inheritance could add more stored properties), so every class with properties without default values needs its own init. */
final class TeleportPod {
    let id: String
    var chargeLevel: Int
    var occupant: CrewSnapshot?
 
    init(id: String, chargeLevel: Int) {
        self.id = id
        self.chargeLevel = chargeLevel
        self.occupant = nil
    }
 
    deinit {
        print("deinit: pod \(id) destroyed")
    }
 
    func load(_ crew: CrewSnapshot) -> Bool {
        if occupant == nil && chargeLevel >= 20 {
            occupant = crew
            return true
        }
        return false
    }
 
    func fire() -> CrewSnapshot? {
        guard let crew = occupant else {
            return nil
        }
        chargeLevel -= 20
        occupant = nil
        return crew
    }
}
 
func findCrew(_ name: String) -> CrewSnapshot? {
    for member in crewRoster {
        if member.name == name {
            return member
        }
    }
    return nil
}
 
print("\nLevel 4")
let ledgerPod = TeleportPod(id: "P-1", chargeLevel: 100)
print("Start charge: \(ledgerPod.chargeLevel)")
 
for name in ["Timur", "Dana", "Nurlan"] {
    if let crew = findCrew(name) {
        let loaded = ledgerPod.load(crew)
        let arrived = ledgerPod.fire()
        print("\(name): loaded \(loaded), fired \(arrived?.name ?? "nobody"), charge \(ledgerPod.chargeLevel)")
    }
}
let emptyShot = ledgerPod.fire()
print("Empty fire: \(emptyShot?.name ?? "nobody"), charge \(ledgerPod.chargeLevel)")
 
let C = ledgerPod.chargeLevel
 
let podOne = TeleportPod(id: "R-1", chargeLevel: 100)
let podTwo = podOne
podTwo.chargeLevel = 30
print("Class: podOne \(podOne.chargeLevel), podTwo \(podTwo.chargeLevel)")
 
let snapOne = CrewSnapshot.rookie(named: "Aigerim")
var snapTwo = snapOne
snapTwo.oxygen = 30
print("Struct: snapOne \(snapOne.oxygen), snapTwo \(snapTwo.oxygen)")
 
// Assigning a class copies the reference to one shared object, assigning a struct copies the whole value.
 
 
// MARK: Level 5 · Station Systems
 
final class Station {
    let callSign: String
    var oxygenByDeck: [Deck: Int]
 
    var hullIntegrity: Int {
        willSet {
            print("Hull: \(hullIntegrity) -> \(newValue)")
        }
        didSet {
            if hullIntegrity > 100 {
                hullIntegrity = 100
            } else if hullIntegrity < 0 {
                hullIntegrity = 0
            }
        }
    }
 
    lazy var fullDiagnostics: String = self.runDiagnostics()
 
    var totalOxygen: Int {
        var sum = 0
        for (_, oxygen) in oxygenByDeck {
            sum += oxygen
        }
        return sum
    }
 
    var averageOxygen: Int {
        get {
            if oxygenByDeck.isEmpty {
                return 0
            }
            return totalOxygen / oxygenByDeck.count
        }
        set {
            for deck in oxygenByDeck.keys {
                oxygenByDeck[deck] = newValue
            }
        }
    }
 
    init(callSign: String, hullIntegrity: Int) {
        self.callSign = callSign
        self.hullIntegrity = hullIntegrity
        var readings: [Deck: Int] = [:]
        for reading in deckReadings {
            if let deck = Deck(rawValue: reading.deck) {
                readings[deck] = reading.oxygen
            } else {
                print("Skipping reading for unknown deck \(reading.deck)")
            }
        }
        self.oxygenByDeck = readings
    }
 
    func runDiagnostics() -> String {
        print("Running full scan...")
        return "\(callSign): \(oxygenByDeck.count) decks, total oxygen \(totalOxygen), hull \(hullIntegrity)"
    }
}
 
print("\nLevel 5")
let station = Station(callSign: "ALMA-7", hullIntegrity: 100)
print("Call sign: \(station.callSign)")
print("Total oxygen: \(station.totalOxygen)")
print("Average oxygen: \(station.averageOxygen)")
 
let B = station.averageOxygen
 
print("Before first diagnostics access")
print(station.fullDiagnostics)
print("Second access:")
print(station.fullDiagnostics)
 
let spareStation = Station(callSign: "ALMA-8", hullIntegrity: 100)
print("\(spareStation.callSign) created, diagnostics never touched, so no scan line for it")
 
station.averageOxygen = 70
print("After setting average to 70: total \(station.totalOxygen), average \(station.averageOxygen)")
 
// Assigning to a property inside its own didSet does not call the observers again,
// so the clamp just stores the fixed value and stops.
station.hullIntegrity = 130
print("Hull after 130: \(station.hullIntegrity)")
station.hullIntegrity = -40
print("Hull after -40: \(station.hullIntegrity)")
station.hullIntegrity = 55
print("Hull after 55: \(station.hullIntegrity)")
 
 
// MARK: Level 6 · Incident Reports
 
/*
// Report 1
var roster = crewRoster
for var member in roster {
    member.oxygen -= 10
}
print(roster[0].oxygen)   // author expected the crew to have lost oxygen
 
// Report 2
let podA = TeleportPod(id: "A", chargeLevel: 100)
let podB = podA
podB.chargeLevel = 0
print(podA.chargeLevel)   // author expected 100
 
// Report 3
struct Logbook {
    var entries: [String] = []
    func add(_ entry: String) {
        entries.append(entry)
    }
}
 
// Report 4
let snapshot = CrewSnapshot.rookie(named: "Dana")
snapshot.oxygen = 40
 
let pod = TeleportPod(id: "B", chargeLevel: 50)
pod.chargeLevel = 10
*/
 
print("\nLevel 6")
 
// Report 1
// Expected: every crew member loses 10 oxygen.
// Actual: compiles, prints 62, roster is unchanged.
// Rule: `for var member` gives a copy of each struct, changing the copy does not touch the array.
// Fix: change the array element through its index.
var roster = crewRoster
for i in 0..<roster.count {
    roster[i].oxygen -= 10
}
print("Report 1 fixed: \(roster[0].oxygen)")
 
// Report 2
// Expected: podA keeps 100.
// Actual: compiles, prints 0.
// Rule: TeleportPod is a class, `let podB = podA` copies the reference, both names point to the same pod.
// Fix: create a separate pod.
let podA = TeleportPod(id: "A", chargeLevel: 100)
let podB = TeleportPod(id: "A", chargeLevel: podA.chargeLevel)
podB.chargeLevel = 0
print("Report 2 fixed: podA \(podA.chargeLevel), podB \(podB.chargeLevel)")
 
// Report 3
// Expected: add() appends to entries.
// Actual: does not compile, "cannot use mutating member on immutable value: 'self' is immutable".
// Rule: methods of a struct cannot change its properties unless marked `mutating`.
// Fix: mark add as mutating.
struct Logbook {
    var entries: [String] = []
    mutating func add(_ entry: String) {
        entries.append(entry)
    }
}
var logbook = Logbook()
logbook.add("Teleporter online")
print("Report 3 fixed: \(logbook.entries.count) entry")
logbook.add("Teleporter offline")
print("Report 3 fixed: \(logbook.entries)")
 
// Report 4
// Expected: both assignments work.
// Actual: `snapshot.oxygen = 40` does not compile, "cannot assign to property: 'snapshot' is a 'let' constant".
// `pod.chargeLevel = 10` is fine.
// Rule: `let` on a struct freezes the whole value, including every property.
// `let` on a class only freezes the reference, the object it points to can still change.
// Fix: declare the snapshot with var.
var snapshot = CrewSnapshot.rookie(named: "Dana")
snapshot.oxygen = 40
let pod = TeleportPod(id: "B", chargeLevel: 50)
pod.chargeLevel = 10
print("Report 4 fixed: snapshot \(snapshot.oxygen), pod \(pod.chargeLevel)")
 
 
// MARK: Level 7 · Sealing the Black Box
 
final class FlightRecorder {
    // private: blocks any code outside this class from replacing, clearing or appending to the list
    private var entries: [String] = []
 
    // private(set): blocks outside code from changing isSealed, reading is still allowed
    private(set) var isSealed = false
 
    // internal: blocks access from other modules, open for this module
    internal var entryCount: Int {
        return entries.count
    }
 
    // internal: blocks access from other modules, open for this module
    internal var transcript: String {
        var result = ""
        var number = 1
        for entry in entries {
            result += "\(number). \(entry)\n"
            number += 1
        }
        return result
    }
 
    // internal: blocks access from other modules, open for this module
    internal func add(_ entry: String) -> Bool {
        if isSealed {
            return false
        }
        entries.append(entry)
        return true
    }
 
    // internal: blocks access from other modules, open for this module
    internal func seal() {
        isSealed = true
    }
 
    // fileprivate: blocks code in other files, lets auditTranscript in this file use it
    fileprivate func rawEntries() -> [String] {
        return entries
    }
}
 
func auditTranscript(of recorder: FlightRecorder) -> String {
    var characters = 0
    for entry in recorder.rawEntries() {
        characters += entry.count
    }
    return "Audit: \(recorder.entryCount) entries, \(characters) characters, sealed \(recorder.isSealed)"
}
 
print("\nLevel 7")
let recorder = FlightRecorder()
print("Added: \(recorder.add("Day 10: teleporter reports full crew transfer"))")
print("Added: \(recorder.add("Day 10: Nurlan seen on two decks"))")
recorder.seal()
print("Added after seal: \(recorder.add("Nothing happened"))")
print("Entries: \(recorder.entryCount), sealed: \(recorder.isSealed)")
print(recorder.transcript)
print(auditTranscript(of: recorder))
 
// recorder.entries = []
// error: 'entries' is inaccessible due to 'private' protection level
// recorder.isSealed = false
// error: cannot assign to property: 'isSealed' setter is inaccessible
 
 
// MARK: Finale · Integrity Code
 
print("\nFinale")
let D = AlarmLevel.level(forTotalMass: A).rawValue
let integrityCode = "\(A)-\(B)-\(C)-\(D)"
print("INTEGRITY CODE: \(integrityCode)")
 
 
// MARK: Bonus
 
print("\nBonus")
var keeper: TeleportPod? = nil
do {
    let tempPod = TeleportPod(id: "TMP", chargeLevel: 50)
    keeper = tempPod
    print("Inside do block, pod \(tempPod.id) exists")
}
print("Left the do block, keeper still holds \(keeper?.id ?? "nothing")")
keeper = nil
print("keeper set to nil")
 
// deinit fires on `keeper = nil`, not at the end of the do block.
// When the block ends tempPod goes away, but keeper still holds a reference,
// so the count is 1. Setting keeper to nil drops the count to 0 and the pod is destroyed.
 
func comparePods(_ first: TeleportPod, _ second: TeleportPod) -> String {
    if first === second {
        return "same pod"
    }
    if first.id == second.id && first.chargeLevel == second.chargeLevel {
        return "two different pods with equal contents"
    }
    return "two different pods"
}
 
let recordOne = TeleportPod(id: "N-1", chargeLevel: 60)
let recordTwo = recordOne
let recordThree = TeleportPod(id: "N-1", chargeLevel: 60)
print("recordOne vs recordTwo: \(comparePods(recordOne, recordTwo))")
print("recordOne vs recordThree: \(comparePods(recordOne, recordThree))")
 
// === checks if two references point to the same object. CrewSnapshot is a struct,
// every variable holds its own copy, there is no shared object, so === does not compile for it.
 
 
// MARK: - DEFENSE QUESTIONS
/*
 1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?
    Structs get a memberwise init automatically. Classes don't, because of
    inheritance: a subclass could add stored properties, so Swift makes you
    write the init yourself so every property is surely set.
 
 2. What does `mutating` do to self, and why do classes never need it?
    Inside a struct method self is a constant. `mutating` makes self an inout
    value, so the method can change properties or even replace self
    (like reviveInMedbay does). In a class self is a reference, changing
    properties changes the object, not the reference, so nothing is needed.
 
 3. In Report 4 both values are `let`. What exactly does `let` freeze for a
    struct, and what does it freeze for a class?
    Struct: the whole value, so no property can change (snapshot.oxygen = 40 fails).
    Class: only the reference. pod can't point to another pod,
    but pod.chargeLevel = 10 is allowed because the object itself is not frozen.
 
 4. Why must a lazy property be var? When does lazy change behaviour, not
    just performance?
    A lazy property has no value after init, it is set later on first access,
    and a let must have its value when init ends. Behaviour changes when the
    initializer has side effects or depends on state: fullDiagnostics prints
    "Running full scan..." only if accessed, and it captures the station data
    at the moment of first access, not at init.
 
 5. private vs fileprivate: where in your FlightRecorder would private be
    too strict?
    rawEntries() is used by auditTranscript, a free function outside the
    class. With private it could not be called there. fileprivate lets that
    function use it but still hides it from other files.
 
 Bonus. On which line does deinit fire, and why can't === be used on
 CrewSnapshot?
    On `keeper = nil`, because that removes the last reference to the pod.
    === compares object identity, CrewSnapshot is a value type with no
    identity, so === is not defined for it.
 */
