//
//  AddWhiskeyView.swift
//  Whiskey Thief
//
//  Created by Jess Garms on 12/5/22.
//

import SwiftUI

struct AddWhiskeyView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var distiller = ""
    @State private var age: Int? = nil
    @State private var origin = ""
    @State private var price: Int? = nil
    @State private var sampled = Date()
    @State private var rating = 0.0
    @State private var color = "Gold"
    @State private var notes = ""
    
    let colors = ["Clear", "Straw", "Honey", "Gold", "Amber", "Caramel", "Mahogany"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Whiskey name", text: $name)
                    TextField("Distiller", text: $distiller)
                    TextField("Age", value: $age, format: .number)
                    TextField("Origin", text: $origin)
                    TextField("Price", value: $price, format: .number)
                    Picker("Color", selection: $color) {
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    DatePicker("Sampled on", selection: $sampled, displayedComponents: .date)
                }
                Section {
                    RatingView($rating)
                }
                Section {
                    Text("Notes")
                    TextEditor(text: $notes)
                }
                Section {
                    Button("Save") {
                        save()
                    }
                }
            }
            .navigationTitle("Add Whiskey")
        }
    }
    
    func save() {
        let newWhiskey = Whiskey(context: moc)
        newWhiskey.id = UUID()
        newWhiskey.name = name
        newWhiskey.distiller = distiller
        if age != nil {
            newWhiskey.age = Int32(age!)
        }
        newWhiskey.origin = origin
        if price != nil {
            newWhiskey.price = Double(price!)
        }
        newWhiskey.color = color
        newWhiskey.sampled = sampled
        newWhiskey.rating = rating
        newWhiskey.notes = notes
        
        try? moc.save()
        
        dismiss()
        
    }
}

struct AddWhiskeyView_Previews: PreviewProvider {
    static var previews: some View {
        AddWhiskeyView().preferredColorScheme(.dark)
    }
}
