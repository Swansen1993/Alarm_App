//
//  ContentView.swift
//  Alarm_App
//
//  Created by Sven Niederlöhner on 27.05.26.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    private var simulator = SimulationManagerClass.simulationsschicht
    
    var body: some View {
        
        TabView {
            
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        VStack{
                            if simulator.currentStatus == .awake{
                                Image(systemName: "sun.max.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.orange)
                                Text("Aktueller Status : Wach")
                                    .font(.headline)
                                    .bold()
                            } else{
                                Image(systemName: "moon.zzz.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                Text("Aktueller Status : Schlaf simuliert")
                                    .font(.headline)
                                    .bold()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray2))
                        .cornerRadius(15)
                        
                        
                        Button(action: {
                            withAnimation(.easeInOut){
                                if simulator.currentStatus == .awake{
                                    simulator.triggerToAsleep()
                                    }
                                else{
                                    simulator.resetToAwake()
                                }
                            }
                        }) {
                            Text(simulator.currentStatus == .awake ? "Simuliere Schlaf" : "Schlafsimulation Stoppen")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(simulator.currentStatus == .awake ? Color.accentColor : Color.red)
                                .background(simulator.currentStatus == .asleep ? Color.accentColor : Color.blue)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Schlaf-Überwachung")
            }
            .tabItem {
                Label("Überwachung", systemImage: "waveform.path.ecg")
            }
            
            NavigationStack {
                List {
                    Section(header: Text("Schlaftrigger endgültig auslösen")) {
                        VStack(alignment: .leading, spacing: 5){
                            Text("Einschlaftrigger bestätigt nach: \(Int(simulator.triggerDelayMinutes)) Min.")
                                .font(.body)
                            
                            Slider(value:$simulator.triggerDelayMinutes, in: 5...15, step: 1)
                                .onChange(of: simulator.triggerDelayMinutes){ oldValue, newValue in
                                    print("INTEGRATIONSTEST [Slider Schlaftrigger]: Wert direkt im Backend geändert auf: \(Int(newValue)) Min.")
                                }
                        }
                    }
                    
                    Section(header:Text("Lautstärke Alarm")) {
                        VStack(alignment: .leading, spacing:5){
                            Text("Laustärke Alarm")
                                .font(.body)
                            
                            Slider(value:$simulator.alarmVolume , in: 5...100,step: 1)
                                .onChange(of:simulator.alarmVolume){ oldValue, newValue in
                                    print(" INTEGRATIONSTEST [Slider Lautstärke]: Wert direkt im Backend geändert auf: \(Int(newValue))%")
                                }
                        }
                    }
                    
                    
                    Section(header: Text("Hardware Pairing")){
                        Button(action:{
                            // Verbindungslogik
                        }){
                            Label("Wearable neu verbinden", systemImage: "applewatch.radiowaves.left.and.right")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    
                    Section(header: Text("System")) {
                        Text("Version 0.3 (Sprint 3): Entwicklungsphase")
                    }
                }
                .navigationTitle("Konfiguration")
            }
            .tabItem {
                Label("Optionen", systemImage: "gearshape")
            }
            
            
            NavigationStack {
                List {
                    Section(header: Text("Einstellung Dynamische Schlafzeit")) {
                        VStack(alignment: .leading, spacing: 5){
                            let gesamtMinuten = Int(simulator.zielSchlafdauerInStunden * 60)
                            let hours = gesamtMinuten/60
                            let minutes = gesamtMinuten % 60
                            
                            Text("Gewünschte Schlafzeit \( hours)h \(minutes)m")
                                .font(.body)
                            
                            Slider(value: Binding(
                                get: {simulator.zielSchlafdauerInStunden * 60},
                                set: {simulator.zielSchlafdauerInStunden = $0 / 60 }
                            ), in: 300...660, step:15)
                            .onChange(of: simulator.zielSchlafdauerInStunden){ oldValue, newValue in
                                print("INTEGRATIONSTEST [Slider Schlafzeit]: Wert im Backend geändert auf: \(newValue) Std. (\(Int(newValue * 60)) Min.)")
                            }
                        }
                    }
                    
                    
                    Section(header: Text("Einstellung späteste Weckzeit")){
                        VStack(alignment: .leading, spacing: 5){
                            DatePicker("Späteste Weckzeit", selection: $simulator.eingestellteWeckzeit, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.compact)
                                .padding(.vertical, 5)
                                .onChange(of: simulator.eingestellteWeckzeit){oldValue, newValue in
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "HH:mm"
                                    print("INTEGRATIONSTEST [DatePicker Weckzeit]: Wert im Backend geändert auf: \(formatter.string(from: newValue)) Uhr")
                                }
                        }
                    }
                }
                
                .navigationTitle("Schlafzeit")
            }
            .tabItem {
                Label("Schlafzeit", systemImage: "zzz")
            }
        }
    }
}

#Preview {
    ContentView()
}
