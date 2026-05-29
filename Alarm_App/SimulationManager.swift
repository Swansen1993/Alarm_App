import Observation
import Foundation

enum SleepState{
    case awake
    case asleep
}


@Observable  // Stausanderungen werden automatisch an das User Interface gesendet. 
class SimulationManagerClass {
    static let simulationsschicht = SimulationManagerClass()
    
    var currentStatus: SleepState = .awake
    var zielSchlafdauerInStunden: Double = 8.0
    var eingestellteWeckzeit: Date = Calendar.current.date(bySettingHour: 6, minute: 30, second: 0, of: Date()) ?? Date()
    
    var erkannterEinschlafZeitpunkt: Date?

    
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
