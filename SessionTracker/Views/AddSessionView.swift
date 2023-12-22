//
//  AddSessionView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 21/12/23.
//

import SwiftUI
import SwiftData

struct AddSessionView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let category: Category
    var session: Session?
    
    @State private var notes: String = ""
    @State private var date: Date = Date.now
    @State private var hour: Date = Date.now
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section(header: Text("Started")) {
                    HStack{
                        DatePicker("", selection: $date, in: ...Date.now, displayedComponents: .date)
                            .labelsHidden()
                        
                        DatePicker("Please enter a time", selection: $hour, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                
                Section(header: Text("Duration")){
                    HStack {
                        ZStack{
                            Picker("", selection: $hours){
                                ForEach(0..<24, id: \.self) { i in
                                    Text("\(i)   ").tag(i)
                                    
                                }
                                
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                            HStack{
                                Spacer()
                                    .frame(width:50)
                                Text("hrs")
                            }
                        }
                        
                        ZStack{
                            Picker("", selection: $minutes){
                                ForEach(0..<60, id: \.self) { i in
                                    Text("\(i)   ").tag(i)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                            HStack{
                                Spacer()
                                    .frame(width:50)
                                Text("min")
                            }
                        }
                        
                    }.padding(.horizontal)
                }
                
                Section(header: Text("Notes")){
                    TextField("Add notes here...", text: $notes)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle((session != nil) ? "Edit Session" : "Add Session")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let session = self.session {
                            updateSession(session: session, date: date, hours: hours, minutes: minutes)
                        } else {
                            saveSession()
                        }
                        dismiss()
                    }
                }
            }
            .onAppear{
                if let session = session {
                    hours = session.durationHour
                    minutes = session.durationMinutes 
                    date = session.date 
                }

            }
        }
        
    }
    
    
    private func saveSession(){
        let newSession = Session(date: date, durationHour: hours, durationMinutes: minutes)
        
        category.sessions.append(newSession)
    }
    
    private func updateSession(session: Session, date: Date?, hours: Int?, minutes: Int?) {
        
        session.date = date ?? session.date
        session.durationHour = hours ?? session.durationHour
        session.durationMinutes = minutes ?? session.durationMinutes
        
    }
    
    private func reset(){
        notes = ""
        date = Date.now
    }
}

#Preview {
    AddSessionView(category: Category(name: "Janeiro", emoji: "🫠", tintColor: tintColors[0]))
        .modelContainer(for: [Category.self])
}
