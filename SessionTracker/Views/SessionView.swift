//
//  SessionView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 07/01/24.
//

import SwiftUI

struct SessionView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var editSessionSheet = false
    let session: Session
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading, spacing: 24){
                
              
                    HStack(alignment: .top){
                        VStack(alignment:.leading){
                            ZStack{
                                Text(String(session.durationHour))
                                    .font(.title)
                                
                                Text("hrs")
                                    .font(.caption)
                                    .textCase(.uppercase)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight:.infinity, alignment: .bottomTrailing)
                                    .padding(8)
                            }
                            
                            
                        }
                        
                        .frame(
                            width: 100,
                            height: 100
                        )
                        .cornerRadius(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 3)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(session.category?.color ?? .black)
                                        .stroke(.black, lineWidth: 3)
                                        .offset(x: 8, y: 8)
                                )
                        )
                        
                        VStack{
                            ZStack{
                                Text("\(session.durationMinutes)")
                                    .font(.title)
                                
                                Text("min")
                                    .font(.caption)
                                    .textCase(.uppercase)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight:.infinity, alignment: .bottomTrailing)
                                    .padding(8)
                            }
                            
                            
                        }
                        
                        .frame(
                            width: 100,
                            height: 100
                        )
                        
                        
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    Text("Correr")
                        .textCase(.uppercase)
                        .bold()
                        .foregroundColor(session.category?.color)
                    
                    Text(dateString())
                        .font(.title)
                    
                    Spacer()
                    
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .navigationTitle("Session")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement:.topBarTrailing){
                    Button{
                        editSessionSheet = true
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
        .onChange(of: editSessionSheet){
            print("hey")
            print(session.category?.name ?? "deu errado")
        }
        .onChange(of: session.category){
            print("ohayou")
            dismiss()
        }
        .sheet(isPresented: $editSessionSheet){
            if session.category != nil {
                AddSessionView(category: session.category!, session: session)
                    .interactiveDismissDisabled()
            }
        }
    }
    
    
    private func dateString() -> String{

        // ask for the full relative date
        let isToday = Calendar.current.isDateInToday(session.date)
        let isYesterday = Calendar.current.isDateInYesterday(session.date)
        
        var weekday = "\(session.date.formatted(.dateTime.weekday(.wide))), \(session.date.formatted(.dateTime.month(.wide))) \(session.date.formatted(.dateTime.day())),"
        
        if isToday {
            weekday = "Today at"
        } else if isYesterday {
            weekday = "Yesterday at"
        }
        
        let time = session.date.formatted(date: .omitted, time: .shortened)

        // print it out
//        Date.now.formatted(date: .long, time: .shortened)
        return "\(weekday) \(time)"
//        Date.now.formatted(date: .numeric, time: .shortened)
    }
}

//#Preview {
//    SessionView()
//}
