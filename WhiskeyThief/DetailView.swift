//
//  DetailView.swift
//  WhiskeyThief
//
//  Created by Lisa Garms on 12/12/22.
//
import CoreData
import SwiftUI

struct DetailView: View {
    let whiskey: Whiskey
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            Section {
                Text(whiskey.name ?? "Unknown whiskey")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Section {
                if whiskey.distiller != nil {
                    Text("Distiller: \(whiskey.distiller ?? "unset")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if whiskey.age > 0 {
                    Text("Age: \(whiskey.age)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if whiskey.origin != nil {
                    Text("Origin: \(whiskey.origin ?? "")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if whiskey.price > 0 {
                    Text("$\(whiskey.price, specifier: "%.0f")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .alert("Delete whiskey", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteWhiskey)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this whiskey", systemImage: "trash")
            }
        }
    }
    
    func deleteWhiskey() {
        moc.delete(whiskey)
        try? moc.save()
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let whiskey = Whiskey(context: moc)
        
        
        DetailView(whiskey: whiskey)
    }
}
