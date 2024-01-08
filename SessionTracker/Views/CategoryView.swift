//
//  CategoryView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 21/12/23.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    
    @Environment(\.modelContext) private var context
    var category: Category
    
    @State private var addSessionSheet: Bool = false
    
    @State private var editSessionSheet: Bool = false
    @State private var selectedSession: Session? = nil
    
    @State private var editCategorySheet: Bool = false

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                Group{
                    ZStack{

                        
                        VStack(alignment: .leading, spacing: 12){
                            Text(category.name)
                                .font(.title).bold()
                                .foregroundColor(category.color)
                            
                            VStack(alignment: .trailing){
                                Text(totalDurationString(duration: category.totalDuration))
                                    .font(.caption)
                                Text("All time")
                                    .font(.caption)
                                    .textCase(.uppercase)
                            }
                            .frame(
                                maxWidth: .infinity,
                                alignment: .trailing
                            )
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.leading, 24)
                        .padding(.trailing, 16)
                        .padding(.top, 56)
                        .padding(.bottom, 12)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 3)
                        )
                        
                        HStack{
                            Text(category.emoji)
                                .font(.title)
                                .frame(
                                    width:70,
                                    height:70
                                )
                                .background(category.color)
                                .cornerRadius(20)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.black, lineWidth: 3)
                                }
                            
                            
                            Spacer()
                                
                        }
                       
                        .offset(x: -12, y: -60)
                    }
                                 
                    HStack{
                        Text("Sessions")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                        Spacer()
                        Group{
                            Text("\(category.sessions.count)")
                            Image(systemName: "repeat")
                        }.foregroundColor(.gray)
                        
                    }
                }
                .padding(.trailing, 16)
                
                ScrollView(.horizontal){
                    HStack(spacing: 16){
                        ForEach(category.sessions.sorted{ $0.date > $1.date }){ session in
                            NavigationLink(destination: SessionView(session: session)){
                                SessionOpenCardView(duration: session.duration, prefix: session.durationPrefix, date: session.date, color: category.color)
                            }
                        }
                    }
                    .padding(.leading, 2)
                    .padding(.top, 2)
                    .padding(.bottom, 16)
                    
                }
                .scrollIndicators(.hidden)
            
                
                Spacer()
                
                HStack(spacing: 16){
                    NavigationLink(destination: TimerView(category: category)){
                        Text("Start Timer")
                            .foregroundColor(.black)
                            .bold()
                            .frame(
                                width: 150
                            )
                            .padding(.vertical, 16)
                            .background{
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black, lineWidth: 3)
                                    
                            }
                        
                    }
                    
                    
                    Button{
                        addSessionSheet = true
                    } label : {
                        Text("Add Manually")
                            .foregroundColor(.black)
                            .bold()
                            .frame(
                                width: 150
                            )
                            .padding(.vertical, 16)
                            .overlay{
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black, lineWidth: 3)
                            }
                        
                    }
                }
                .padding(.trailing, 16)
                
                
                
            }
            .padding(.leading, 20)
            .padding(.vertical, 36)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(category.name)
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        editCategorySheet = true
                    } label: {
                        Text("Edit")
                    }
                    
                }
            }
            .onChange(of: selectedSession){
                editSessionSheet = true
            }
            .sheet(isPresented: $addSessionSheet){
                AddSessionView(category: category)
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $editSessionSheet){
                AddSessionView(category: category, session: selectedSession)
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $editCategorySheet){
                EditCategoryView(category: category)
                    .interactiveDismissDisabled()
            }
            
        }
        
    }
    
    private func totalDurationString(duration: Float) -> String {
        
        if duration >= 1.0 {
            return duration.formatted(.number.precision(.fractionLength(1))) + " hrs"
        }
        
        return duration.formatted(.number.precision(.fractionLength(0))) + " min"
    }
}

//#Preview {
////    CategoryView()
//}
