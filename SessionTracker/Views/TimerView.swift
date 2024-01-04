//
//  TimerView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 04/01/24.
//

import SwiftUI

struct TimerView: View {
    
    @State private var quote: Quote = appQuotes[0]
    let color: Color
    
    @State var runningTime = 0
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                VStack(alignment: .leading){
                    Text(quote.text)
                    Text("- \(quote.author)")
                }
                .frame(maxWidth: .infinity)
                .background(color.opacity(0.2))
                
                Rectangle()
                    .frame(height: 2)
                
                Text(clockString())
                    
                
            }
            .onReceive(timer) { _ in
                runningTime += 1
            }
            .navigationTitle("Correr")
            .navigationBarTitleDisplayMode(.inline)
        }
        
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
    TimerView(color: .red)
}
