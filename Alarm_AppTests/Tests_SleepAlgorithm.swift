import XCTest
@testable import Alarm_App

final class SleepAlgorithmTestsXCTestCase {
    
    let algorithmus = SleepAlgorithm()
    
    func testCheckObSchlafdauerErreicht() {
        let kalender = Calendar.current
        let heute = Date()
        
        guard let einschlafZeit = kalender.date(bySettingHour: 23, minute: 0, second: 0, of: heute) else {
            XCTFail("Fehler beim Erstellen des Basis-Datums")
            return
        }
        
        let zielStunden = 8.0
        let zielSekunden = zielStunden * 3600.0 // 28800 Sekunden
        
        let zeitEineSekundeVorZiel = einschlafZeit.addingTimeInterval(zielSekunden - 1.0)
        let ergebnisVorZiel = algorithmus.checkObSchlafdauerErreicht(
            einschlafZeitpunkt: einschlafZeit,
            aktuelleZeit: zeitEineSekundeVorZiel,
            zielSchlafdauerInStunden: zielStunden
        )
        XCTAssertFalse(ergebnisVorZiel)
        
        let zeitPunktlandung = einschlafZeit.addingTimeInterval(zielSekunden)
        let ergebnisPunktlandung = algorithmus.checkObSchlafdauerErreicht(
            einschlafZeitpunkt: einschlafZeit,
            aktuelleZeit: zeitPunktlandung,
            zielSchlafdauerInStunden: zielStunden
        )
        XCTAssertTrue(ergebnisPunktlandung)
    }
    
    func testStarreWeckzeitPrioritaet() {
        let kalender = Calendar.current
        let heute = Date()
        
        guard let einschlafZeit = kalender.date(bySettingHour: 23, minute: 0, second: 0, of: heute),
              let eingestellteWeckzeit = kalender.date(bySettingHour: 6, minute: 30, second: 0, of: heute) else {
            XCTFail("Fehler beim Erstellen der Test-Daten")
            return
        }
        
        let zielStunden = 8.0 // 23:00 + 8 Stunden wäre eigentlich erst 07:00 Uhr morgens
        
        let zeitVorWeckzeit = kalender.date(bySettingHour: 6, minute: 29, second: 59, of: heute) ?? heute
        let ergebnisVorDeadline = algorithmus.starreWeckzeitPrioritaet(
            einschlafZeitpunkt: einschlafZeit,
            aktuelleZeit: zeitVorWeckzeit,
            zielSchlafdauerInStunden: zielStunden,
            eingestellte_weckzeit: eingestellteWeckzeit
        )
        XCTAssertFalse(ergebnisVorDeadline)
        
        let zeitNachWeckzeit = kalender.date(bySettingHour: 6, minute: 30, second: 0, of: heute) ?? heute
        let ergebnisNachDeadline = algorithmus.starreWeckzeitPrioritaet(
            einschlafZeitpunkt: einschlafZeit,
            aktuelleZeit: zeitNachWeckzeit,
            zielSchlafdauerInStunden: zielStunden,
            eingestellte_weckzeit: eingestellteWeckzeit
        )
        XCTAssertTrue(ergebnisNachDeadline)
        
        let zeitNachVollstaendigemSchlaf = kalender.date(bySettingHour: 7, minute: 0, second: 5, of: heute) ?? heute
        let ergebnisSchlafSchonErreicht = algorithmus.starreWeckzeitPrioritaet(
            einschlafZeitpunkt: einschlafZeit,
            aktuelleZeit: zeitNachVollstaendigemSchlaf,
            zielSchlafdauerInStunden: zielStunden,
            eingestellte_weckzeit: eingestellteWeckzeit
        )
        XCTAssertFalse(ergebnisSchlafSchonErreicht)
    }
}
