//
//  ContentView.swift
//  GPACalculator
//
//  Created by Mehmet Alp Sönmez on 18/06/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State var showingSheet = false
    @Query var grades: [Grade]
    @State var showingEditSheet = false
    @State private var buttonTapped = false
    @State  var result: Double
    @State var selectedGrade: Grade?
    
    
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        GridItem(.fixed(30), alignment: .center)  // Fixed width for delete button column
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    Group {
                        Text("Module Name")
                        Text("Credits")
                        Text("Results")
                        Text("Weight")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.bottom, 5)
                    
                    ForEach(grades) { grade in
                        Text(grade.name)
                        Text("\(grade.credit)")
                        Text("\(grade.result, specifier: "%.2f")")
                        Text("\(grade.result * Double(grade.credit), specifier: "%.2f")")
                        Button(action: {
                            deleteRow(grade: grade)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(.vertical, 20)
                Section("Calculate your grade") {
                    Button("Tap to see your GPA") {
                        buttonTapped = true
                        calculateFinalGrade()
                        
                    }
                    .foregroundStyle(Color.black)
                    .padding()
                    .background(Color.green)
                    .clipShape(.rect(cornerRadius: 30))
                    
                    
                    if buttonTapped {
                        Text("Your GPA: \(result, specifier: "%.2f")")
                            .foregroundStyle(result >= 70 ? .green : .yellow)
                            .font(.largeTitle)
                    }
                    
                }
            }
            .navigationTitle("Sussex GPA Calculator")
            .preferredColorScheme(.dark)
            .background(RadialGradient(colors: [.black, .blue], center: .center, startRadius: 20, endRadius: 600))
            .foregroundStyle(.white)
            .toolbar {
                Button("Add Module") {
                    showingSheet.toggle()
                }
                .foregroundStyle(.orange)
            }
            .sheet(isPresented: $showingSheet) {
                AddModuleView(grades:Grade(name: "Trial", credit: 15, result: 1.0))
            }
        }
    }
    
    func deleteRow(grade: Grade) {
        modelContext.delete(grade)
    }
    
    func calculateFinalGrade(){
        var totalWeight = 0.0
        var totalCredits = 0.0
        var finalGrade = 0.0
        
        for grade in grades {
            totalWeight += grade.result * Double(grade.credit)
            totalCredits += Double(grade.credit)
        }
        
        finalGrade = totalWeight / totalCredits
        result = finalGrade
    }
}

#Preview {
    ContentView(result: 5.0)
}
