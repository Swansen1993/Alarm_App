//
//  ContentView.swift
//  Alarm_App
//
//  Created by Sven Niederlöhner on 27.05.26.
//

import SwiftUI

struct ContentView: View {
    
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
                            } else{
                                Image(systemName: "moon.zzz.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                Text("Aktueller Status : Schlaf simuliert")
                            }
                        }
                        
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray2))
                        
                        
                        Button(action:{
                            simulator.triggerToAsleep()
                        }) {
                            Text("Simuliere Schlaf")
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
                    Section(header: Text("Metriken Schlaftrigger (Ausblick Sprint 2)")) {
                        Text("Platzhalter: Metrik-Auswahl 1")
                        Text("Platzhalter: Metrik-Auswahl 2")
                    }
                    
                    Section(header: Text("System")) {
                        Text("Version 0.1 (Sprint 1): Entwicklungsphase")
                    }
                }
                .navigationTitle("Konfiguration")
            }
            .tabItem {
                Label("Optionen", systemImage: "gearshape")
            }
            
            
            NavigationStack {
                List {
                    Section(header: Text("Einstellung Schlafzeit (Ausblick Sprint 2)")) {
                        Text("Angegebene Schlafzeit (Stunden : Minuten)")
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
