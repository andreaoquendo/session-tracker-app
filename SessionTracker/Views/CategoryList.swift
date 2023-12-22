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
            List{
                ForEach(categories){ category in
                    NavigationLink(destination: CategoryView(category: category)){
                        Text(category.name)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryList()
//        .modelContainer(for: [Category.self])

}
