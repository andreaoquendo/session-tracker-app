//
//  AllSessionsListView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 03/01/24.
//

import SwiftUI
import SwiftData

struct AllSessionsListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: [SortDescriptor(\Session.date, order: .reverse)], animation: .snappy)
    private var sessions: [Session]
    
    @Query(sort: [SortDescriptor(\Category.name, order: .reverse)], animation: .snappy)
    private var categories: [Category]

    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 12){
                
                Text("Recent")
                    .font(.title)
                    .bold()
                
                ScrollView(.vertical){
                    VStack(spacing: 16){
                        ForEach(sessions){ session in
                            NavigationLink(destination: CategoryView(category: session.category!)){
                                RecentSessionView(duration: session.durationMinutes, date: session.date, color: session.category?.color ?? .black, categoryName: session.category?.name ?? "No Category")
                                
                            }
                        }
                    }
                    .padding(.leading, 2)
                    .padding(.trailing, 12)
                    .padding(.top, 4)
                    
                }
                
                .scrollIndicators(.hidden)
                
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            
        }
    }
    
    private func getSessionCategory(session: Session) -> Category? {
        for category in categories {
            if category.sessions.contains(session) {
                return category
            }
        }
        
        return nil
    }
    
    
}

#Preview {
    AllSessionsListView()
        .modelContainer(for: [Category.self, Session.self])
}
