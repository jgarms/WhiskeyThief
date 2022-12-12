import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.sampled, order: .reverse)
    ])
    var whiskies: FetchedResults<Whiskey>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(whiskies) { whiskey in
                    NavigationLink {
                        DetailView(whiskey: whiskey)
                    } label: {
                        HStack {
                            Text(whiskey.name ?? "Unknown Whiskey")
                                .font(.headline)
                            Text(whiskey.distiller ?? "")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteWhiskies)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Whiskey", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddWhiskeyView()
            }
        }
    }
    
    func deleteWhiskies(at offsets: IndexSet) {
        for offset in offsets {
            let whiskey = whiskies[offset]
            moc.delete(whiskey)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
