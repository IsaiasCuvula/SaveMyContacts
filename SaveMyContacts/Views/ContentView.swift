//
//  ContentView.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 26.11.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddTodoView: Bool = false
    
    //MARK: - FECTHING DATA

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ContactsEntity.name, ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<ContactsEntity>
    
    
    //MARK: - BODY

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        
                        ContactViewDetail(contact: contact)
                        
                    } label: {
                        
                        ContactItemView(contact: contact)
                        
                    }
                    
                }
                //.onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                            self.showingAddTodoView.toggle()
                
                    } label: {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showingAddTodoView){
                        AddNewContact()
                            .environment(\.managedObjectContext, self.viewContext)
                    }}
            }
            //Text("Select an item")
        }//: NAVIGATION
        
    }
    
    //MARK: - FUNCS
   
   
    /*
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { //items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }*/
}

//MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
