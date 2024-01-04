//
//  CategoryListItemView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 04/01/24.
//

import SwiftUI

struct CategoryListItem: View {
    
    let name: String
    let duration: Int
    let color : Color
    
    init(name: String, duration: Int, color: Color) {
        self.name = name
        self.color = color
        self.duration = duration
    }
    
    var body: some View {
    
        VStack(alignment: .leading, spacing: 8){
            Text(name)
                .font(.title2)
                .bold()
                .foregroundColor(color)
            
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(durationString())
                   
                
                Text("all time")
                    .textCase(.uppercase)
            }
            .font(.caption).bold()
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
    
    private func durationString() -> String{
        
        if duration >= 60 {
            let hours = Float(duration)/60.0
            
            return "\(hours.formatted(.number.precision(.fractionLength(0...1)))) hrs"
        }
        
        return "\(duration) min"
        
    }
}

#Preview {
    CategoryListItem(name: "Correr", duration: 600, color: .red)
}
