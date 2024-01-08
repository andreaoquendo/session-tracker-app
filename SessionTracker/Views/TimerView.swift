//
//  TimerView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 04/01/24.
//

import SwiftUI

struct TimerView: View {
    
    let category: Category
    
    @Environment(\.dismiss) var dismiss
    @State private var date: Date = Date.now
    @State private var quote: Quote = appQuotes[0]
    
    @State var runningTime = 0
    @State private var isPaused = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var saveSessionSheet = false
    @State private var showAlert = false
    @State private var elapsedTimeHigher = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                VStack(alignment: .leading, spacing: 16){
                    Text(quote.text)
                        .bold()
                    
                    Text("— \(quote.author)")
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .background(category.color.opacity(0.2))
                
                Rectangle()
                    .frame(height: 2)
                
                VStack(spacing: 24){
                    
                    ClockView(runningTime: $runningTime, color: category.color)
                        .padding([.trailing, .bottom], 8)
                    
                    HStack{
                        
                        Spacer()
                        
                        Button{
                            if runningTime > 10 {
                                runningTime -= 10
                            } else {
                                runningTime = 0
                            }
                        } label: {
                            TimerButton(color: category.color, image: "gobackward.minus")
                            
                        }
                        
                        Spacer()
                        
                        
                        Button{
                            isPaused.toggle()
                        } label: {
                            TimerButton(color: category.color, image:  (isPaused == false) ? "pause.fill" : "play.fill")
                            
                        }
                        
                        Spacer()
                    }
                    
                    Button{
                        isPaused = true
                        
                        if runningTime < 60 {
                            showAlert = true
                        } else {
                            saveSessionSheet = true
                        }
                        
                    } label: {
                        DoneButton()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .background(category.color.opacity(0.9))
                    
                
            }
            .onReceive(timer) { _ in
                if isPaused == false {
                    runningTime += 1
                }
                if runningTime > 10 {
                    isPaused = true
                    elapsedTimeHigher = true
                }
            }
            .actionSheet(isPresented: $saveSessionSheet) {
                ActionSheet(
                    title: Text("Save or discard session?"),
                    buttons: [
                        .default(Text("Save")){
                            saveSession()
                            dismiss()
                        },
                        .destructive(Text("Discard")){
                            dismiss()
                        },
                        .cancel(){
                            isPaused = false
                        }
                    ]
                )
            }
            .alert("Time Warning", isPresented: $showAlert) {
                Button("OK") {
                    isPaused = false
                }
            } message: {
                Text("The elapsed time needs to be higher than one minute to save the session.")
            }
//            .alert("Time Warning", isPresented: $elapsedTimeHigher) {
//                Button(role: .cancel){
//                    dismiss()
//                } label: {
//                    Text("Discard")
//                }
//    
//                
//                Button(role: .none){
//                    saveSession()
//                    dismiss()
//                } label: {
//                    Text("Save")
//                }
//            } message: {
//                Text("The elapsed cannot be higher than 24 hours, save session?")
//            }
            .navigationTitle(category.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
         }
        
    }
    
    private func DoneButton() -> some View {
        VStack(alignment: .center){
            Text("Done!")
                .font(.system(size: 24))
                .foregroundColor(.black)
                .bold()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 24)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .stroke(.black, lineWidth: 3)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(category.color)
                        .stroke(.black, lineWidth: 3)
                        .offset(x: 8, y: 8)
                )
            
        )
        .padding(8)
    }
    
    private func saveSession(){
        let hours = runningTime / 3600
        let minutes = (runningTime % 3600) / 60
        let newSession = Session(date: date, durationHour: hours, durationMinutes: minutes)
        
        category.sessions.append(newSession)

    }
}

//#Preview {
////    TimerView(color: .red)
//}
