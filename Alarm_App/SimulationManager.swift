import Observation
import Foundation

enum SleepState{
    case awake
    case asleep
}


@Observable  // Stausanderungen werden automatisch an das User Interface gesendet. 
class SimulationManager {
    static let simulationsschicht = SimulationManager()
    
    var currentStatus: SleepState = .awake
    
    private init (){}
    
    func  triggerToAsleep(){
        self.currentStatus = .asleep
    }
    
    func resetToAwake(){
        self.currentStatus = .awake
    }
}
