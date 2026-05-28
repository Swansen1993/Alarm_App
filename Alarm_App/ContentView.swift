//
//  ContentView.swift
//  Alarm_App
//
//  Created by Sven Niederlöhner on 27.05.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .frame(height: 120)
                            .overlay(Text("Platzhalter: Statusanzeige").foregroundColor(.secondary))
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .frame(height: 150)
                            .overlay(
                                VStack(spacing: 10) {
                                    Text("Platzhalter: Bedienung / Buttons").foregroundColor(.secondary)
                                    Text("(Hier kommt später der Simulations-Button hin)").font(.caption).foregroundColor(.blue)
                                }
                            )
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
