//
//  CategoryVerticalListView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 04/01/24.
//

import SwiftUI
import SwiftData

struct CategoryVerticalListView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var categories: [Category]
    var body: some View {
        VStack(spacing: 16){
            ForEach(categories){ category in
                NavigationLink(destination: CategoryView(category: category)){
                    
                    CategoryListItem(name: category.name, duration: category.totalDurationInMinutes, color: category.color)
                }
                
            }
        }
        .padding(.top, 16)
        .padding(.leading, 16)
        .padding(.trailing, 18)
    }
}

#Preview {
    CategoryVerticalListView()
}
