//
//  HomeView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 20/12/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State private var addCategorySheet: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading){
                    CategoryList()
                    
                    
                    
                    AllSessionsListView()
                }
                
                Spacer()
            }
            .navigationTitle("Activities")
            .toolbar{
                
                // line.3.horizontal
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button{
                        addCategorySheet = true
                    } label: {
                        HStack{
                            Text("New Activity")
                            Image(systemName: "plus")
                        }
                    }
                    
                })
                
                ToolbarItem(placement: .topBarLeading, content: {
                    Button{
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                })
            }
            .sheet(isPresented: $addCategorySheet){
                EditCategoryView()
            }
        }
        
        
        
        
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [Category.self, Session.self])
}
