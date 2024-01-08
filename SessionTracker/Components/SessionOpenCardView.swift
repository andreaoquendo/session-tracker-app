//
//  SessionOpenCardView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 21/12/23.
//

import SwiftUI

struct SessionOpenCardView: View {
    
    let duration: Float
    let prefix: String
    let date: Date
    let color : Color
    
    init(duration: Float, prefix: String, date: Date, color: Color) {
        self.duration = duration
        self.prefix = prefix
        self.date = date
        self.color = color
    }
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .stroke(.black, lineWidth: 3)
                .frame(
                    width: 160,
                    height: 220,
                    alignment: .leading
                )
                
                .offset(x: 8, y: 8)
            
            VStack(alignment: .leading){
                Spacer()
                Text("\(dateString())")
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .bold()
                Spacer()
                
//                    .formatted(.number.precision(.fractionLength(1)))
                Text("\(duration.formatted(.number.precision(.fractionLength(0...1)))) \(prefix)")
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
            }
            .foregroundColor(.black)
            .padding(16)
            .frame(
                width: 160,
                height: 220,
                alignment: .leading
            )
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 3)
            )
            
            
            
        }
    }
    
    private func dateString() -> String{

        // ask for the full relative date
        let isToday = Calendar.current.isDateInToday(date)
        let isYesterday = Calendar.current.isDateInYesterday(date)
        
        var weekday = "\(date.formatted(.dateTime.weekday(.wide))), \(date.formatted(.dateTime.month(.wide))) \(date.formatted(.dateTime.day())),"
        
        if isToday {
            weekday = "Today at"
        } else if isYesterday {
            weekday = "Yesterday at"
        }
        
        let time = date.formatted(date: .omitted, time: .shortened)

        // print it out
//        Date.now.formatted(date: .long, time: .shortened)
        return "\(weekday) \(time)"
//        Date.now.formatted(date: .numeric, time: .shortened)
    }
    
    
}

#Preview {
    SessionOpenCardView(duration: (17 + 30/60), prefix: "min", date: Date.now, color: Color.blue)
}
