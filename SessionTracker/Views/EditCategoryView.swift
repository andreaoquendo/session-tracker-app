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
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    @State var selectedEmoji: String = "Add Icon"
    @State var isPresented: Bool = false
    
    let colors: [Color] = [Color.orange, Color.red, Color.yellow, Color.green, Color.blue]
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
                        addCategory()
                        dismiss()
                    }
                    .disabled(activateSaveButton())
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
    
    
    func addCategory(){
        
        if !name.isEmpty {
            let category = Category(name: name, emoji: selectedEmoji, tintColor: selectedTint ?? tintColors[6])
            context.insert(category)
            reset()
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
