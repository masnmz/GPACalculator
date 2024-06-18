//
//  AddModuleView.swift
//  GPACalculator
//
//  Created by Mehmet Alp Sönmez on 18/06/2024.
//
import SwiftData
import SwiftUI

struct AddModuleView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var credit = 15
    @State private var result = 0.0
    
    var grades: Grade
    let credits = [15, 60]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    TextField("Module name", text: $name)
                    
                    Picker("Credits", selection: $credit) {
                        ForEach(credits, id:\.self) { credit in
                            Text("\(credit)")
                        }
                    }
                    TextField("Result", value: $result, format: .number)
                }
                
            }
            .scrollContentBackground(.hidden)
            .preferredColorScheme(.dark)
            .navigationTitle("Add Module")
            .background(RadialGradient(colors: [.black, .blue], center: .center, startRadius: 20, endRadius: 600))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = Grade(name: name, credit: credit, result: result)
                        modelContext.insert(item)
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
        }
        
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Grade.self, configurations: config)
        let example = Grade(name: "test", credit: 15, result: 90.0)
        return AddModuleView(grades: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
