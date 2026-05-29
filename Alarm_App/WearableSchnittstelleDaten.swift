//
//  WearableSchnittstelle.swift
//  Alarm_App
//
//  Created by Sven Niederlöhner on 29.05.26.
//

import Foundation
import HealthKit

class WatchData{
        
        var heartRate: Double = 72.0
        var motion: Double = 1.0
        var simtime : Date = Date()
        
        func SimulatedTime(hour: Int, minute: Int) {
            self.simtime = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
        }
       
        func userAwake() {
            heartRate = 80.0
            motion = 0.5
            simtime = Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date()) ?? Date()
        }
        
        func userSleeping() {
            heartRate = 52.0
            motion = 0.0
            simtime = Calendar.current.date(bySettingHour: 03, minute: 0, second: 0, of: Date()) ?? Date()
        }
    }
