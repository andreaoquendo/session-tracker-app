//
//  RecentSessionView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 03/01/24.
//

import SwiftUI

struct RecentSessionView: View {
    
    let duration: Int
    let date: Date
    let color : Color
    let categoryName: String
    
    init(duration: Int, date: Date, color: Color, categoryName: String) {
        self.duration = duration
        self.date = date
        self.color = color
        self.categoryName = categoryName
    }
    
    var body: some View {
        ZStack(){
            
            VStack(alignment: .leading, spacing: 4){
                Text(categoryName)
                    .textCase(.uppercase)
                    .bold()
                    .foregroundColor(color)
                
                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .bold()
                    .foregroundColor(.black)
                
                Text(durationString())
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                    .foregroundColor(.black)
            }
            
            .padding(16)
            .frame(
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/
            )
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
    }
    
    private func durationString() -> String{
        
        if duration >= 60 {
            let hours = Float(duration)/60.0
            
            return "\(hours.formatted(.number.precision(.fractionLength(0...1)))) hrs"
        }
        
        return "\(duration) min"
        
    }
}

#Preview {
    RecentSessionView(duration: 60, date: Date.now, color: Color.blue, categoryName: "Netflix")
}
