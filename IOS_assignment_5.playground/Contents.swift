// =============================================================
//  Station ALMA-7, Part III: The Repair Fleet
//  iOS Mobile Development · Module 5 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part3_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section. LegacyBeacon in
//     particular must be reached with an extension, not edited.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • The Health Rule must exist in exactly ONE place in this file.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Drone records recovered from the fleet registry.
/// One `kind` does not correspond to any drone type you will build.
let fleetData: [(kind: String, id: String, charge: Int)] = [
    (kind: "welder",  id: "W-1", charge: 80),
    (kind: "scanner", id: "S-1", charge: 45),
    (kind: "cargo",   id: "C-1", charge: 100),
    (kind: "welder",  id: "W-2", charge: 15),
    (kind: "scanner", id: "S-2", charge: 60),
    (kind: "tug",     id: "T-1", charge: 50)
]

/// Hull sensors. These are NOT drones — they never move and never work a shift.
let sensorData: [(id: String, charge: Int)] = [
    (id: "hull-cam", charge: 12),
    (id: "thermal",  charge: 77)
]

/// Hardware from the original station. You may not add anything to this
/// declaration — no methods, no protocols, no properties.
struct LegacyBeacon {
    let name: String
    let signalStrength: Int
}

let beacon = LegacyBeacon(name: "ALMA-BEACON", signalStrength: 8)

print("Fleet registry online: \(fleetData.count) drone records, \(sensorData.count) sensors, beacon \(beacon.name).")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================


// MARK: Level 1 The Power Cell

// Why a class and not a struct here?  -> drone and whoever holds the cell should share the same battery, struct would be copied
final class PowerCell {
    private var charge: Int

    init(charge: Int) {
        if charge < 0 {
            self.charge = 0
        } else if charge > 100 {
            self.charge = 100
        } else {
            self.charge = charge
        }
    }

    func level() -> Int {
        return charge
    }

    func spend(_ amount: Int) -> Bool {
        if amount <= 0 || amount > charge {
            return false
        }
        charge -= amount
        return true
    }

    func recharge(by amount: Int) {
        if amount <= 0 {
            return
        }
        charge += amount
        if charge > 100 {
            charge = 100
        }
    }
}

// Encapsulation proof (leave this commented, with the compiler error):
// let cell = PowerCell(charge: 50)
// cell.charge = 100
// error: 'charge' is inaccessible due to 'private' protection level


// MARK: Level 2 The Fleet

// 2.1  What does `final` on runOnce() buy you?  -> subclasses cant override it so every drone always pays the cost before working
class Drone {
    let id: String
    let cell: PowerCell

    init(id: String, cell: PowerCell) {
        self.id = id
        self.cell = cell
    }

    var powerCost: Int { 10 }

    var statusLine: String {
        return "\(id): \(cell.level())% \(cell.level().powerBar)"
    }

    func performTask() -> Int { 0 }

    final func runOnce() -> Int {
        if !cell.spend(powerCost) {
            return 0
        }
        return performTask()
    }
}

// 2.2
final class WelderDrone: Drone {
    override var powerCost: Int { 25 }

    override func performTask() -> Int { 40 }

    func weldSeam() -> String {
        return "\(id) welded a seam"
    }
}

class ScannerDrone: Drone {
    override var powerCost: Int { 10 }

    override func performTask() -> Int { 15 }

    override var statusLine: String {
        return super.statusLine + " [scanner]"
    }
}

final class CargoDrone: Drone {
    override var powerCost: Int { 20 }

    override func performTask() -> Int { 25 }
}

// 2.3
func makeDrone(kind: String, id: String, charge: Int) -> Drone? {
    let cell = PowerCell(charge: charge)
    switch kind {
    case "welder":
        return WelderDrone(id: id, cell: cell)
    case "scanner":
        return ScannerDrone(id: id, cell: cell)
    case "cargo":
        return CargoDrone(id: id, cell: cell)
    default:
        return nil
    }
}

var fleet: [Drone] = []
for record in fleetData {
    if let drone = makeDrone(kind: record.kind, id: record.id, charge: record.charge) {
        fleet.append(drone)
    } else {
        print("Warning: unknown kind \(record.kind) for \(record.id), skipped")
    }
}


// MARK: Level 3 The Shift

func runShift(_ fleet: [Drone], rounds: Int) -> Int {
    var total = 0
    for _ in 0..<rounds {
        for drone in fleet {
            total += drone.runOnce()
        }
    }
    return total
}

let A = runShift(fleet, rounds: 3)

var chargeSum = 0
var canWork = 0
for drone in fleet {
    print(drone.statusLine)
    chargeSum += drone.cell.level()
    if drone.cell.level() >= drone.powerCost {
        canWork += 1
    }
}
print("Drones that can still work: \(canWork)")

let B = chargeSum
let C = canWork


// MARK: Level 4 · Diagnostics

// 4.1
protocol Diagnosable {
    var componentID: String { get }
    var statusCode: Int { get }
    func diagnose() -> String
}

// 4.2
protocol Rechargeable {
    mutating func recharge(by amount: Int)
}

// Why does Drone implement recharge(by:) without `mutating`?  -> its a class (reference type), mutating is only for value types
extension Drone: Diagnosable, Rechargeable {
    var componentID: String { id }

    var statusCode: Int { healthCode(cell.level()) }

    func recharge(by amount: Int) {
        cell.recharge(by: amount)
    }
}

struct SensorModule: Diagnosable, Rechargeable {
    let id: String
    var chargeLevel: Int

    var componentID: String { id }

    var statusCode: Int { healthCode(chargeLevel) }

    mutating func recharge(by amount: Int) {
        if amount <= 0 {
            return
        }
        chargeLevel += amount
        if chargeLevel > 100 {
            chargeLevel = 100
        }
    }
}

var sensors: [SensorModule] = []
for s in sensorData {
    sensors.append(SensorModule(id: s.id, chargeLevel: s.charge))
}

// 4.3
// Why could [Drone] never have held the sensors?  -> SensorModule is a struct and doesnt inherit from Drone
func diagnosticsReport(_ components: [Diagnosable]) -> String {
    var report = "DIAGNOSTICS"
    for c in components {
        report += "\n" + c.diagnose()
    }
    return report
}

var components: [Diagnosable] = []
for drone in fleet {
    components.append(drone)
}
for sensor in sensors {
    components.append(sensor)
}
print(diagnosticsReport(components))


// MARK: Level 5 · Shared Behaviour

// 5.1
extension Diagnosable {
    func diagnose() -> String {
        return "\(componentID): code \(statusCode)"
    }

    func healthCode(_ level: Int) -> Int {
        if level < 20 {
            return 2
        } else if level < 50 {
            return 1
        }
        return 0
    }
}

// 5.2
extension LegacyBeacon: Diagnosable {
    var componentID: String { name }

    var statusCode: Int { healthCode(signalStrength) }

    func diagnose() -> String {
        return "[LEGACY] \(name) signal \(signalStrength) -> code \(statusCode)"
    }
}

components.append(beacon)
print(diagnosticsReport(components))

var codeSum = 0
for c in components {
    codeSum += c.statusCode
}
let D = codeSum

// 5.3
extension Int {
    var powerBar: String {
        var full = self / 10
        if full < 0 {
            full = 0
        }
        if full > 10 {
            full = 10
        }
        var bar = ""
        for i in 0..<10 {
            if i < full {
                bar += "#"
            } else {
                bar += "."
            }
        }
        return bar
    }
}


// MARK: Level 6 Incident Reports

/*
// Report 1
class PatchDrone: Drone {
    func performTask() -> Int {
        return 30
    }
}
*/
// expected: patch drone makes 30 units
// actual: doesnt compile, overriding declaration requires an 'override' keyword
// rule: overriding a superclass method needs override
// fix: override func performTask() -> Int { return 30 }

/*
// Report 2
final class HeavyWelder: WelderDrone {
    override func runOnce() -> Int {
        return 999
    }
}
*/
// expected: heavy welder returns 999 every run
// actual: doesnt compile, WelderDrone is final so it cant be subclassed, and runOnce is final too
// rule: final classes cant be inherited, final methods cant be overridden
// fix: subclass Drone instead and override performTask() to return 999, leave runOnce alone

/*
// Report 3
let reportFleet: [Drone] = [WelderDrone(id: "W-9", cell: PowerCell(charge: 100))]
let first = reportFleet[0]
print(first.weldSeam())
*/
// expected: prints the weld message
// actual: doesnt compile, value of type 'Drone' has no member 'weldSeam'
// rule: compiler only knows the static type Drone, not the real object type
// fix:
let reportFleet: [Drone] = [WelderDrone(id: "W-9", cell: PowerCell(charge: 100))]
let first = reportFleet[0]
if let welder = first as? WelderDrone {
    print(welder.weldSeam())
}
// as? returns optional because the cast can fail if the object is not actually a WelderDrone

// Report 4
protocol Labelled {
    var componentID: String { get }
    func label() -> String
}

extension Labelled {
    func label() -> String { "generic component" }
}

struct Thruster: Labelled {
    let componentID: String
    func label() -> String { "thruster \(componentID)" }
}

let parts: [Labelled] = [Thruster(componentID: "T-1")]
print(parts[0].label())
// expected: "thruster T-1"
// actual: compiled and printed "generic component"
// rule: label() was only in the extension, not a requirement, so its statically dispatched and the type Labelled picks the extension version
// fix: add func label() -> String to the protocol (done above), now it prints "thruster T-1"


// MARK: Finale · Mission Code

let missionCode = "\(A)-\(B)-\(C)-\(D)"
print("MISSION CODE: \(missionCode)")


// MARK: Bonus

// 1. runtime: put this in Drone.init
//    if type(of: self) == Drone.self { fatalError("use a subclass of Drone") }
//    compile time: dont use a class at all, make Drone a protocol (below), protocols cant be instantiated

// 2.
protocol DroneProtocol {
    var id: String { get }
    var cell: PowerCell { get }
    var powerCost: Int { get }
    func performTask() -> Int
}

extension DroneProtocol {
    var statusLine: String {
        return "\(id): \(cell.level())% \(cell.level().powerBar)"
    }

    func runOnce() -> Int {
        if !cell.spend(powerCost) {
            return 0
        }
        return performTask()
    }
}

struct WelderDroneS: DroneProtocol {
    let id: String
    let cell: PowerCell
    var powerCost: Int { 25 }
    func performTask() -> Int { 40 }
}

let testWelder = WelderDroneS(id: "W-S", cell: PowerCell(charge: 50))
print("bonus welder work: \(testWelder.runOnce()), \(testWelder.statusLine)")

// 3. protocol version cant be created directly and structs can conform, but runOnce can still be shadowed since theres no final.
// class version protects the ritual with final and shares state by reference, so i would keep the class for the station.
// if drones had to share mutable state the structs would get copied, so you need classes (or a shared class like PowerCell inside).


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why does a class satisfy a `mutating` protocol requirement without the
    keyword, while a struct must write it?
    class is a reference type, its methods can always change properties. struct is a value type so changing self needs mutating

 2. One thing inheritance does that protocols cannot, and one thing
    protocols do that inheritance cannot:
    inheritance shares stored properties and can lock methods with final.
    protocols work for structs and enums and can be added to types you cant edit with extension

 3. What does `final` prevent, and what did it protect in runOnce()?
    final prevents overriding (or subclassing for a class). it made sure no drone can skip spending power before working

 4. In Report 4, why did the protocol extension's method win?
    label() wasnt a protocol requirement so there was no dynamic dispatch, the call used the extension method of Labelled type
*/
