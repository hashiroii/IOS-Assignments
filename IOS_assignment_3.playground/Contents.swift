// =============================================================
//  Station ALMA-7: Rescue Protocol
//  iOS Mobile Development · Module 3 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER CODE section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Use the exact function names from the assignment PDF.
// =============================================================


// MARK: - =================== STARTER CODE ===================
// MARK: - Do not modify anything in this section

typealias Reading = (sensor: String, value: Int)

/// Splits a string at the first occurrence of the separator.
/// splitOnce("O2:87", by: ":") -> ("O2", "87")
/// splitOnce("hello", by: ":") -> nil
func splitOnce(_ line: String, by separator: Character) -> (String, String)? {
    guard let index = line.firstIndex(of: separator) else { return nil }
    let left = String(line[..<index])
    let right = String(line[line.index(after: index)...])
    return (left, right)
}

let rawLog = [
    "O2:87", "TEMP:-12", "O2:9x", "PRESS:101", "TEMP:abc", "O2:",
    "RAD:3", "O2:64", ":55", "TEMP:31", "PRESS:98", "O2:71",
    "RAD:-1", "TEMP:4", "PRESS:1o2", "O2:90"
]

class Tank {
    var level: Int
    init(level: Int) { self.level = level }
}

class Module {
    let name: String
    var oxygenTank: Tank?
    init(name: String, oxygenTank: Tank?) {
        self.name = name
        self.oxygenTank = oxygenTank
    }
}

class CrewMember {
    let name: String
    let role: String
    let priority: Int      // 1 = evacuated first
    var module: Module?    // nil = in open space
    init(name: String, role: String, priority: Int, module: Module?) {
        self.name = name
        self.role = role
        self.priority = priority
        self.module = module
    }
}

let lab  = Module(name: "Lab",  oxygenTank: Tank(level: 40))
let hab  = Module(name: "Hab",  oxygenTank: Tank(level: 12))
let dock = Module(name: "Dock", oxygenTank: nil)

let crew = [
    CrewMember(name: "Timur",   role: "Engineer",  priority: 3, module: lab),
    CrewMember(name: "Dana",    role: "Scientist", priority: 4, module: dock),
    CrewMember(name: "Aigerim", role: "Commander", priority: 1, module: hab),
    CrewMember(name: "Nurlan",  role: "Pilot",     priority: 2, module: nil)
]

var roster: [String: CrewMember] = [:]
for member in crew { roster[member.name] = member }

print("ALMA-7 systems online: \(rawLog.count) log lines, \(crew.count) crew members.")

// MARK: - ================= END OF STARTER CODE =================

func parseReading(_ raw: String) -> Reading? {
    guard let parts = splitOnce(raw, by: ":"),
          parts.0.isEmpty == false,
          let value = Int(parts.1),
          value >= 0 || parts.0 == "TEMP"
    else { return nil }
    return (sensor: parts.0, value: value)
}

print(parseReading("O2:87") as Any)
print(parseReading("TEMP:-12") as Any)
print(parseReading("RAD:-1") as Any)
print(parseReading(":55") as Any)
print(parseReading("O2:9x") as Any)
print(parseReading("hello") as Any)

func parseLog(_ lines: [String]) -> (valid: [Reading], invalidCount: Int) {
    var valid: [Reading] = []
    var invalidCount = 0
    for line in lines {
        if let reading = parseReading(line) {
            valid.append(reading)
        } else {
            invalidCount += 1
        }
    }
    return (valid: valid, invalidCount: invalidCount)
}

let log = parseLog(rawLog)
print("Valid: \(log.valid.count), invalid: \(log.invalidCount)")
let smallLog = parseLog(["O2:5", "bad", "TEMP:-3"])
print("Small log -> valid: \(smallLog.valid.count), invalid: \(smallLog.invalidCount)")

let A = log.invalidCount
print("Fragment A = \(A)")

func select(_ readings: [Reading], where isIncluded: (Reading) -> Bool) -> [Reading] {
    var result: [Reading] = []
    for reading in readings {
        if isIncluded(reading) {
            result.append(reading)
        }
    }
    return result
}

func values(of readings: [Reading]) -> [Int] {
    var result: [Int] = []
    for reading in readings {
        result.append(reading.value)
    }
    return result
}

let o2Readings = select(log.valid) { $0.sensor == "O2" }
print("O2 readings: \(o2Readings)")
print("O2 values: \(values(of: o2Readings))")
let bigReadings = select(log.valid) { $0.value > 90 }
print("Values > 90: \(values(of: bigReadings))")

func stats(of values: [Int]) -> (min: Int, max: Int, average: Double)? {
    guard let first = values.first else { return nil }
    var minValue = first
    var maxValue = first
    var sum = 0
    for value in values {
        if value < minValue { minValue = value }
        if value > maxValue { maxValue = value }
        sum += value
    }
    return (min: minValue, max: maxValue, average: Double(sum) / Double(values.count))
}

func stats(_ values: Int...) -> (min: Int, max: Int, average: Double)? {
    stats(of: values)
}

print(stats(3, 8, 1) as Any)
print(stats() as Any)
print(stats(of: []) as Any)
let o2Stats = stats(of: values(of: o2Readings))
print("O2 stats: \(o2Stats as Any)")

let B = Int(o2Stats?.average ?? -1)
print("Fragment B = \(B)")

let validReadings = log.valid

let sorted1 = validReadings.sorted(by: { (a: Reading, b: Reading) -> Bool in
    return a.value > b.value
})
let sorted2 = validReadings.sorted(by: { a, b in return a.value > b.value })
let sorted3 = validReadings.sorted(by: { a, b in a.value > b.value })
let sorted4 = validReadings.sorted(by: { $0.value > $1.value })
let sorted5 = validReadings.sorted { $0.value > $1.value }

func sameReadings(_ lhs: [Reading], _ rhs: [Reading]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for i in 0..<lhs.count {
        if lhs[i].sensor != rhs[i].sensor || lhs[i].value != rhs[i].value {
            return false
        }
    }
    return true
}

let allMatch = sameReadings(sorted1, sorted2)
    && sameReadings(sorted1, sorted3)
    && sameReadings(sorted1, sorted4)
    && sameReadings(sorted1, sorted5)
print("Sorted: \(values(of: sorted5))")
print("All five sorts match: \(allMatch)")

let safeRange = 18...24

func heatUp(_ t: Int) -> Int { t + 5 }
func coolDown(_ t: Int) -> Int { t - 3 }
func hold(_ t: Int) -> Int { t }

func chooseProtocol(for temp: Int) -> (Int) -> Int {
    if temp < safeRange.lowerBound {
        return heatUp
    } else if temp > safeRange.upperBound {
        return coolDown
    } else {
        return hold
    }
}

print(chooseProtocol(for: 10)(10))
print(chooseProtocol(for: 30)(30))
print(chooseProtocol(for: 20)(20))

func runUntilStable(from start: Int, maxSteps: Int = 10) -> (finalTemp: Int, steps: Int, isStable: Bool) {
    var temp = start
    var steps = 0
    while safeRange.contains(temp) == false && steps < maxSteps {
        let applyProtocol = chooseProtocol(for: temp)
        temp = applyProtocol(temp)
        steps += 1
    }
    return (finalTemp: temp, steps: steps, isStable: safeRange.contains(temp))
}

print(runUntilStable(from: 31))
print(runUntilStable(from: -100, maxSteps: 5))
print(runUntilStable(from: 20))

let C: Int = {
    let tempValues = values(of: select(log.valid) { $0.sensor == "TEMP" })
    guard let lowest = stats(of: tempValues)?.min else { return -1 }
    print("Lowest valid temperature: \(lowest)")
    return runUntilStable(from: lowest).steps
}()
print("Fragment C = \(C)")

func oxygenLevel(of member: CrewMember) -> Int? {
    member.module?.oxygenTank?.level
}

for member in crew {
    print("\(member.name): \(oxygenLevel(of: member) as Any)")
}

func status(of member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member) else {
        let location = member.module?.name ?? "open space"
        return "\(member.name): no data (\(location))"
    }
    return level < 20
        ? "\(member.name): \(level)% CRITICAL"
        : "\(member.name): \(level)% OK"
}

for member in crew {
    print(status(of: member))
}

@discardableResult
func transferOxygen(from source: inout Int, to target: inout Int, amount: Int) -> Int {
    let capacity = 100
    guard amount > 0 else { return 0 }
    let available = max(0, source)
    let freeSpace = max(0, capacity - target)
    let actual = min(amount, available, freeSpace)
    source -= actual
    target += actual
    return actual
}

var testSource = 50, testTarget = 90
print(transferOxygen(from: &testSource, to: &testTarget, amount: 30), testSource, testTarget)
var poorSource = 5, emptyTarget = 0
print(transferOxygen(from: &poorSource, to: &emptyTarget, amount: 20), poorSource, emptyTarget)
print(transferOxygen(from: &testSource, to: &emptyTarget, amount: -10), testSource, emptyTarget)

if let labTank = lab.oxygenTank, let habTank = hab.oxygenTank {
    let moved = transferOxygen(from: &labTank.level, to: &habTank.level, amount: 30)
    print("Transferred \(moved) from Lab to Hab. Lab: \(labTank.level), Hab: \(habTank.level)")
} else {
    print("Transfer impossible: a tank is missing")
}

let D = hab.oxygenTank?.level ?? -1
print("Fragment D = \(D)")

print("Crew status after transfer:")
for member in crew {
    print(status(of: member))
}

func evacuationOrder(_ names: String..., roster: [String: CrewMember]) -> [String] {
    var found: [CrewMember] = []
    for name in names {
        guard let member = roster[name] else {
            print("Unknown crew member: \(name)")
            continue
        }
        found.append(member)
    }
    let ordered = found.sorted { $0.priority < $1.priority }
    var result: [String] = []
    for member in ordered {
        result.append(member.name)
    }
    return result
}

print(evacuationOrder("Dana", "Ghost", "Aigerim", "Timur", roster: roster))
print(evacuationOrder("Nurlan", "Timur", roster: roster))
print(evacuationOrder(roster: roster))

func reportOxygen(for member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member) else {
        return "\(member.name): no data"
    }
    return "\(member.name): \(level)%"
}

func firstCritical(in members: [CrewMember]) -> String? {
    for member in members {
        if let level = oxygenLevel(of: member), level < 20 {
            return member.name
        }
    }
    return nil
}

for member in crew {
    print(reportOxygen(for: member))
}
print("First critical in crew: \(firstCritical(in: crew) ?? "none")")

let alpha = CrewMember(name: "Alpha", role: "Test", priority: 1,
                       module: Module(name: "T1", oxygenTank: Tank(level: 5)))
let noData = CrewMember(name: "NoData", role: "Test", priority: 2, module: nil)
let beta = CrewMember(name: "Beta", role: "Test", priority: 3,
                      module: Module(name: "T2", oxygenTank: Tank(level: 10)))
let healthy = CrewMember(name: "Healthy", role: "Test", priority: 4,
                         module: Module(name: "T3", oxygenTank: Tank(level: 80)))

let logicTest = firstCritical(in: [noData, alpha, beta])
print("Logic test: \(logicTest ?? "nil") -> \(logicTest == "Alpha" ? "PASS" : "FAIL")")
let noneTest = firstCritical(in: [healthy, noData])
print("Nobody critical: \(noneTest ?? "nil") -> \(noneTest == nil ? "PASS" : "FAIL")")
let emptyTest = firstCritical(in: [])
print("Empty crew: \(emptyTest ?? "nil") -> \(emptyTest == nil ? "PASS" : "FAIL")")

let launchCode = "\(A)-\(B)-\(C)-\(D)"
print("LAUNCH CODE: \(launchCode)")

func makeAlarm(threshold: Int) -> (Int) -> Bool {
    var firedCount = 0
    return { level in
        guard level < threshold else { return false }
        firedCount += 1
        print("Alarm #\(firedCount)")
        return true
    }
}

let alarm = makeAlarm(threshold: 20)
print(alarm(12))
print(alarm(40))
print(alarm(5))
let otherAlarm = makeAlarm(threshold: 50)
print(otherAlarm(30))
