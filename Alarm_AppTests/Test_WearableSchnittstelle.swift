import XCTest
@testable import Alarm_App

final class WearableTests: XCTestCase {
    
    
    let algorithmus = SleepAlgorithm()
    let uhrdaten = WatchData()
    
    // User ist wach und erledigt ruhige Aktivitäten
    func testUserAwake() {
        
        uhrdaten.userAwake()
        
        let ergebnis = algorithmus.checkIfUserIsAsleep(
            heartRate: uhrdaten.heartRate,  // Herzschlag
            motion: uhrdaten.motion, // Uhr Bewegung am Handgelenk
            stunde: uhrdaten.simtime // aktuelle Zeit
        )
        
        XCTAssertFalse(ergebnis, "Fehler: Der User ist Wach")
    }
    
    func testUserSchlaeft() {
        
        uhrdaten.userSleeping()
        
        
        let ergebnis = algorithmus.checkIfUserIsAsleep(
            heartRate: uhrdaten.heartRate,
            motion: uhrdaten.motion,
            stunde: uhrdaten.simtime
        )
        
        XCTAssertTrue(ergebnis, " Richtig erkannt: Der User schläft")
    }
    
    func testUhzeitEdgeCaseSchlaf(){
        uhrdaten.heartRate = 63.0
        uhrdaten.motion = 0.14
        uhrdaten.SimulatedTime(hour: 22, minute: 00)
        
        let ergebnis = algorithmus.checkIfUserIsAsleep(
            heartRate: uhrdaten.heartRate,
            motion: uhrdaten.motion,
            stunde: uhrdaten.simtime
        )
        
        XCTAssertTrue(ergebnis, " Erfolg: Edge Case User schlaeft bestanden")
    }
    
    func testUhzeitEdgeCaseWach(){
        uhrdaten.heartRate = 64.0
        uhrdaten.motion = 0.16
        uhrdaten.SimulatedTime(hour: 21, minute: 59)
        
        let ergebnis = algorithmus.checkIfUserIsAsleep(
            heartRate: uhrdaten.heartRate,
            motion: uhrdaten.motion,
            stunde: uhrdaten.simtime
        )
    XCTAssertFalse (ergebnis, " Erfolg: Edge Case User Wach bestanden")
    }
}
