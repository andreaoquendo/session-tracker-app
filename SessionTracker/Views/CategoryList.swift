//
//  CategoryList.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 21/12/23.
//

import SwiftUI
import SwiftData

struct CategoryList: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: [SortDescriptor(\Category.name, order: .reverse)], animation: .snappy)
    private var categories: [Category]

    
    var body: some View {
        NavigationStack{
            
            ScrollView(.horizontal){
                HStack(spacing: 24){
                    ForEach(categories){ category in
                        NavigationLink(destination: CategoryView(category: category)){
                            CategoryOpenCardView(emoji: category.emoji, name: category.name, quantity: category.sessionCount, totalDuration: category.totalDurationInMinutes, color: category.color)
                            
                        }
                    }
                }
                .padding(.leading, 24)
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            .scrollIndicators(.hidden)
        
        }
    }
}

#Preview {
    CategoryList()
//        .modelContainer(for: [Category.self])

}
