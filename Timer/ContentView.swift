//
//  ContentView.swift
//  Timer
//
//  Created by Guilher Hoffmann on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fastingManger = FastingManager()
    
    var title: String {
        switch fastingManger.festingState {
        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }
    
    var body: some View {
        ZStack {
            // Mark: Background
            
            Color(#colorLiteral(red: 0.02613605976, green: 0, blue: 0.05102287371, alpha: 1))
                .ignoresSafeArea()
            
            content
        }
    }
    
    var content: some View {
        ZStack {
            VStack(spacing: 40) {
                // Mark: Title
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.3242608032, green: 0.6418597783, blue: 0.9151900773, alpha: 1)))
                
                //Mark: Fastingplan
                Text(fastingManger.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            
            VStack(spacing: 40) {
                
                // Mark: Progress Ring
                
                ProgressRing()
                    .environmentObject(fastingManger)
                
                HStack(spacing: 60) {
                    //Mark: Start Time
                    VStack(spacing: 5) {
                        Text(fastingManger.festingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManger.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    //Mark: End Time
                    VStack(spacing: 5) {
                        Text(fastingManger.festingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManger.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                
                // MARK: Button
                
                Button {
                    fastingManger.toggleFastingState()
                } label: {
                    Text(fastingManger.festingState == .fasting ? "End fast" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
