//
//  Clock.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 05/01/24.
//

import SwiftUI

struct TimerClockView: View {
    
    @Binding var runningTime: Int
    
    var body: some View {
             
            VStack(alignment: .center){
                Text(clockString())
                    .font(.largeTitle)
            }
            .padding(16)
            .background(.white)
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .stroke(.black, lineWidth: 3)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .stroke(.black, lineWidth: 3)
                            .offset(x: 8, y: 8)
                    )
                
            )
        
    }
    
    private func clockString() -> String {
        if runningTime < 60 {
            return "00:00:\(String(format: "%02d", runningTime))"
        }
        var totalTime = runningTime
        
        let seconds = totalTime % 60
        totalTime -= seconds
        let minutes = (totalTime % 3600) / 60
        totalTime -= minutes*60
        let hours = totalTime/3600
        
        
        return [hours, minutes, seconds]
            .map { String(format: "%02d", $0) }
            .joined(separator: ":")
    }
}

#Preview {
    TimerClockView(runningTime: .constant(45))
}
