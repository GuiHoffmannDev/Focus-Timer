//
//  ProgressRing.swift
//  Timer
//
//  Created by Guilher Hoffmann on 14/08/23.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack{
            // Mark: Placeholder Ring
            
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // Mark: Colored Ring
            
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3242608032, green: 0.6418597783, blue: 0.9151900773, alpha: 1)), Color(#colorLiteral(red: 0.9151900773, green: 0.5272756683, blue: 0.7465224298, alpha: 1)), Color(#colorLiteral(red: 0.9151900773, green: 0.774978901, blue: 0.8141802206, alpha: 1)), Color(#colorLiteral(red: 0.5525906023, green: 0.9151900773, blue: 0.8642835127, alpha: 1)), Color(#colorLiteral(red: 0.3242608032, green: 0.6418597783, blue: 0.9151900773, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
            
            VStack(spacing: 30) {
                if fastingManager.festingState == .notStarted {
                    //Mark: Upcoming
                    
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)
                        
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                } else {
                    //Mark: Elapsed Time
                    
                    VStack(spacing: 5) {
                        Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                }
                    .padding(.top)
                    
                    //Mark: Remaining Time
                    
                    VStack(spacing: 5) {
                        if !fastingManager.elapsed {
                            Text("Remaining time (\((1 - fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra time")
                                .opacity(0.7)
                        }
                        
                        Text(fastingManager.endTime, style: .timer)
                            .font(.title2)
                            .fontWeight(.bold)
                }
            }
        }
    }
            .frame(width: 250, height: 250)
            .padding()
//           .onAppear {
//                fastingManager.progress = 1
//            }
            .onReceive(timer) { _ in
                fastingManager.track()
            }
        }
    }
    
    struct ProgressRing_Previews: PreviewProvider {
        static var previews: some View {
            ProgressRing()
                .environmentObject(FastingManager())
    }
}
