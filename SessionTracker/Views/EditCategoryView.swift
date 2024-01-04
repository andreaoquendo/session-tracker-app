//
//  AddCategoryView.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 20/12/23.
//

import SwiftUI
import MCEmojiPicker

struct EditCategoryView: View {
    
    @Environment(\.modelContext) private var context 
    @Environment(\.dismiss) private var dismiss
    
    let category: Category?
    
    init(category: Category? = nil){
        self.category = category
    }
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    @State var selectedEmoji: String = "Add Icon"
    @State var isPresented: Bool = false
    
    let colors: [Color] = [Color.orange, Color.red, Color.yellow, Color.green, Color.blue, Color.cyan, Color.gray, Color.black, Color.indigo, Color.brown]
    @State private var selectedTint: TintColor? = nil
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Form{
                    Section(header: Text("Name")){
                        TextField("Required", text: $name)
    
                    }
                    
                    Section(header: Text("Appareance")){
                        Button(selectedEmoji) {
                            isPresented.toggle()
                        }.emojiPicker(
                            isPresented: $isPresented,
                            selectedEmoji: $selectedEmoji
                        )
                        
                        HStack{
                            ForEach(tintColors) {tint in
                                Circle()
                                    .stroke(.black, lineWidth: tint == selectedTint ? 4 : 0)
                                    .fill(tint.value)
                                    .frame(
                                        width: 20
                                    )
                                    .onTapGesture(perform: {
                                        selectedTint = tint
                                    })
                            }
                        }
                        
                        Button{
                            selectedTint = nil
                        } label: {
                            Text("Remove Color")
                        }.disabled(activateColorButton())
    
                    }
                    
                    Section(header: Text("Description")){
                        TextField("", text: $description)
    
                    }
                        
                }
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if category != nil {
                            updateCategory()
                        } else {
                            addCategory()
                        }
                        dismiss()
                    }
                    .disabled(activateSaveButton())
                }
            }
            .onAppear{
                if let category = category {
                    name = category.name
                    selectedEmoji = category.emoji
                    
                    for tint in tintColors {
                        if tint.value == category.color {
                            selectedTint = tint
                            break
                        }
                    }
                }
            }
        }
    }
    
    private func activateColorButton() -> Bool {
        if selectedTint == nil {
            return true
        }
        return false
    }
    
    private func activateSaveButton() -> Bool {
        if name.isEmpty {
            return true
        }
        return false
    }
    
    
    private func addCategory(){
        
        if !name.isEmpty {
            let category = Category(name: name, emoji: selectedEmoji, tintColor: selectedTint ?? tintColors[6])
            context.insert(category)
            reset()
        }
        
    }
    
    private func updateCategory() {
        
        if let category = category {
            category.name = name
            category.emoji = selectedEmoji 
            category.tintColor = selectedTint?.color ?? tintColors[6].color
        }
    }
    
    func reset(){
        name = ""
    }
}

#Preview {
    EditCategoryView()
        .modelContainer(for: [Category.self, Session.self])
}
