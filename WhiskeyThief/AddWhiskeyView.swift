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
    @State private var estimatedPrice: Int? = nil

    let colors = ["Mahogany", "Caramel", "Amber", "Gold", "Honey", "Straw", "Clear"]
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Whiskey name", text: $name)
                        .textInputAutocapitalization(.words)
                    TextField("Distiller", text: $distiller)
                    TextField("Age", value: $age, format: .number)
                        .keyboardType(.numberPad)
                    TextField("Origin", text: $origin)
                        .textInputAutocapitalization(.words)
                    TextField("Price", value: $price, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
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
                    TextField("Estimated Price", value: $estimatedPrice, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
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
        if !distiller.isEmpty {
            newWhiskey.distiller = distiller
        }
        if age != nil {
            newWhiskey.age = Int32(age!)
        }
        if !origin.isEmpty {
            newWhiskey.origin = origin
        }
        if price != nil {
            newWhiskey.price = Double(price!)
        }
        if estimatedPrice != nil {
            newWhiskey.estimatedPrice = Double(estimatedPrice!)
        }
        newWhiskey.color = color
        newWhiskey.sampled = sampled
        newWhiskey.rating = rating
        if !notes.isEmpty {
            newWhiskey.notes = notes
        }
        
        try? moc.save()
        
        dismiss()
        
    }
}

struct AddWhiskeyView_Previews: PreviewProvider {
    static var previews: some View {
        AddWhiskeyView().preferredColorScheme(.dark)
    }
}
