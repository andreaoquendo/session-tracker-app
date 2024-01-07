//
//  SwiftUIView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 05/01/24.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var runningTime: Int
    let color: Color
    var body: some View {
                 
        VStack(alignment: .center){
            Text(clockString())
                .font(.system(size: 48))
                .bold()
                .monospaced()
        }
        .padding(.vertical, 16)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
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
        .padding([.trailing, .bottom], 8)
            
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
    ClockView(runningTime: .constant(45), color: .blue)
}
