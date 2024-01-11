//
//  HomeView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 20/12/23.
//

import SwiftUI
import SwiftData

enum CategoryListViewMode {
    case vertical, horizontal
}

struct HomeView: View {
    
    @State private var addCategorySheet: Bool = false
    @State private var categoryListMode: CategoryListViewMode = .horizontal
    
    @State private var isDeleted = false
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading){
                    
                    if categoryListMode == .horizontal {
                        CategoryList()
                        AllSessionsListView()
                    } else {
                        CategoryVerticalListView()
                    }
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
                        categoryListMode = (categoryListMode == .vertical) ? .horizontal : CategoryListViewMode.vertical
                    } label: {
                        
                        if categoryListMode == .horizontal {
                            Image(systemName: "lineweight")
                        } else {
                            Image(systemName: "square.fill.and.line.vertical.and.square.fill")
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
        .modelContainer(for: [Category.self, Session.self])
}
