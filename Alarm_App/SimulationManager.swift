import Observation
import Foundation
import Combine

enum SleepState{
    case awake
    case asleep
}


  // Stausanderungen werden automatisch an das User Interface gesendet.
class SimulationManagerClass : ObservableObject {
    static let simulationsschicht = SimulationManagerClass()
    
   @Published var currentStatus: SleepState = .awake
   @Published var zielSchlafdauerInStunden: Double = 8.0
   @Published var eingestellteWeckzeit: Date = Calendar.current.date(bySettingHour: 6, minute: 30, second: 0, of: Date()) ?? Date()
   @Published var erkannterEinschlafZeitpunkt: Date?

    
    private init (){}
    
    func  triggerToAsleep(){
        self.currentStatus = .asleep
    }
    
    func resetToAwake(){
        self.currentStatus = .awake
    }
    
    let watchData = WatchData()
        
        
        
    private let sleepAlgorithm = SleepAlgorithm()
        
       
        
    func resetToAwakeSleepStatus() {
            self.currentStatus = .awake
            self.erkannterEinschlafZeitpunkt = nil
            NotificationSoundManager.shared.stopAlarmSound()
        }
    
    func checkObSchlafdauerErreicht(einschlafZeitpunkt: Date, aktuelleZeit: Date, zielSchlafdauerInStunden: Double) -> Bool {
            let geschlafeneSekunden = aktuelleZeit.timeIntervalSince(einschlafZeitpunkt)
            let zielSekunden = zielSchlafdauerInStunden * 3600.0
            
            if geschlafeneSekunden >= zielSekunden {
                print("ZIEL-SCHLAFDAUER ERREICHT!")
                return true
            }
            return false
        }
        
    func checkCurrentSleepStatus() {
            guard let einschlafZeit = erkannterEinschlafZeitpunkt else {
                let isAsleep = sleepAlgorithm.checkIfUserIsAsleep(
                    heartRate: watchData.heartRate,
                    motion: watchData.motion,
                    stunde: Date()
                )
                
                if isAsleep {
                    erkannterEinschlafZeitpunkt = Date()
                    self.currentStatus = .asleep
                }
                return
            }
            
            let jetzt = Date()
            
            let schlafdauerErreicht = sleepAlgorithm.checkObSchlafdauerErreicht(
                einschlafZeitpunkt: einschlafZeit,
                aktuelleZeit: jetzt,
                zielSchlafdauerInStunden: self.zielSchlafdauerInStunden
            )
            
            let harteGrenzeErreicht = sleepAlgorithm.starreWeckzeitPrioritaet(
                einschlafZeitpunkt: einschlafZeit,
                aktuelleZeit: jetzt,
                zielSchlafdauerInStunden: self.zielSchlafdauerInStunden,
                eingestellte_weckzeit: self.eingestellteWeckzeit
            )
            
            if schlafdauerErreicht || harteGrenzeErreicht {
                self.currentStatus = .awake
                NotificationSoundManager.shared.playAlarmSound()
            }
        }
    }
