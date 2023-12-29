//
//  CategoryOpenCardView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 29/12/23.
//

import SwiftUI

struct CategoryOpenCardView: View {
    
    let emoji: String
    let name: String
    let quantity: Int
    let totalDuration: Int
    let color : Color
    
    init(emoji: String, name: String, quantity: Int, totalDuration: Int, color: Color) {
        self.emoji = emoji
        self.name = name
        self.quantity = quantity
        self.totalDuration = totalDuration
        self.color = color
    }
    
    var body: some View {
        ZStack(alignment: .center){
            
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .stroke(.black, lineWidth: 3)
                .frame(
                    width: 160,
                    height: 220,
                    alignment: .leading
                )
                
                .offset(x: 8, y: 8)
            
            VStack(alignment: .leading, spacing: 8){
                
                HStack {
                    Spacer()
                    Text(String(quantity))
                        .font(.caption)
                    Image(systemName: "repeat")
                        .font(.caption)
                }
                .foregroundColor(.gray)
                
                Spacer()
                Text(name)
                    .font(.title)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .bold()
                    .minimumScaleFactor(0.01)
                    .foregroundColor(color)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text(durationString())
                        .font(.caption)
                        .bold()
                    Text("All time")
                        .font(.caption)
                        .textCase(.uppercase)
                        .bold()
                }
                .foregroundColor(.black)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
            }
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
            
            HStack{
                Text(emoji)
                    .font(.title)
                    .frame(
                        width:50,
                        height:50
                    )
                    .background(color)
                    .cornerRadius(15)
                    .overlay{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black, lineWidth: 3)
                    }
                
                
                Spacer()
                    
            }
            .offset(x:-10, y: -95)
            
            
            
        }
    }
    
    private func durationString() -> String {
        if totalDuration > 59 {
            let hours: Float = Float(totalDuration) / 60.0
            
            return "\(hours.formatted(.number.precision(.fractionLength(1)))) hrs"
        }
        
        return "\(totalDuration) min"
    }
    
}


#Preview {
    CategoryOpenCardView(emoji: "🥇", name: "atividade com nome grande muito grande mesmo", quantity: 3, totalDuration: 85, color: Color.blue)
}
