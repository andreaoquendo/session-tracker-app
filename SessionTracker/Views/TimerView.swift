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
    @State private var isPaused = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                VStack(alignment: .leading){
                    Text(quote.text)
                    Text("- \(quote.author)")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .background(color.opacity(0.2))
                
                Rectangle()
                    .frame(height: 2)
                
                VStack{
                    
                    ClockView(runningTime: $runningTime, color: color)
                        .padding([.trailing, .bottom], 8)
                    
                    HStack{
                        Button{
                            if runningTime > 10 {
                                runningTime -= 10
                            } else {
                                runningTime = 0
                            }
                        } label: {
                            TimerButton(color: color, image: "gobackward.minus")
                            
                        }
                        
                        
                        
                        
                        Button{
                            isPaused.toggle()
                        } label: {
                            TimerButton(color: color, image:  (isPaused == false) ? "pause.fill" : "play.fill")
                            
                        }
                        
                    }
                    
                    Button{
                        
                    } label: {
                        DoneButton()
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .background(color.opacity(0.9))
                    
                
            }
            .onReceive(timer) { _ in
                if isPaused == false {
                    runningTime += 1
                }
            }
            .navigationTitle("Correr")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    private func DoneButton() -> some View {
        VStack(alignment: .center){
            Text("Done")
                .font(.system(size: 24))
                .bold()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .stroke(.black, lineWidth: 3)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color)
                        .stroke(.black, lineWidth: 3)
                        .offset(x: 4, y: 4)
                )
            
        )
        .padding([.trailing, .bottom], 8)
    }
}

#Preview {
    TimerView(color: .red)
}
