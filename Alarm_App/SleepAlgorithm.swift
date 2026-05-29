import Foundation

class SleepAlgorithm{
    
    func checkIfUserIsAsleep(heartRate : Double , motion :Double, stunde :Date) -> Bool{
        let stunde = Calendar.current.component(.hour, from: stunde)
        let isNightTime = (stunde >= 22 || stunde < 6)
        guard isNightTime else {return false}
        
        if heartRate <= 63.0 && motion <= 0.15 {
            return true
        }
        
        return false
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
    
    func starreWeckzeitPrioritaet(einschlafZeitpunkt: Date, aktuelleZeit: Date, zielSchlafdauerInStunden: Double, eingestellte_weckzeit : Date) -> Bool{
        let geschlafeneSekunden = aktuelleZeit.timeIntervalSince(einschlafZeitpunkt)
        let zielSekunden = zielSchlafdauerInStunden * 3600.0
        
        if geschlafeneSekunden < zielSekunden && aktuelleZeit >= eingestellte_weckzeit{
            print("HARTE WECKGRENZE ERREICHT!")
            return true
        }
        return false
    }
      
}
        
  
