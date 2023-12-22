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
                }
            }
            .navigationTitle("Activities")
            .toolbar{
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
            }
            .sheet(isPresented: $addCategorySheet){
                EditCategoryView()
            }
        }
        
        
        
        
    }
}

#Preview {
    HomeView()
}
