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
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddContactView: Bool = false
    
    //MARK: - FECTHING DATA

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ContactsEntity.name, ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<ContactsEntity>
    
    
    //MARK: - BODY

    var body: some View {
        NavigationView {
            ZStack {
               
                VStack(alignment: .leading, spacing: 0) {
                    //MARK: - HEARDER
                    HStack(alignment: .center ,spacing: 10) {
                        
                        //MARK: - EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 24, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.black, lineWidth: 2))
                        Spacer()
                        
                        Text("My Contacts")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                       
                        
                        //MARK: - ADD NEW CONTACT
                       
                        //MARK: - BUTTON DARK MODE
                        Button {
                            isDarkMode.toggle()
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                        
                    }//:HSTACK
                    .padding()
                    
                    //MARK: - BODY
                    List {
                        ForEach(contacts) { contact in
                            NavigationLink {
                                ContactViewDetail(contact: contact)
                            } label: {
                                ContactItemView(contact: contact)
                            }
                        }
                        .onDelete(perform: deleteItems)
                        
                    }//:LIST
                    
                }//VSTACK
                
            }//ZSTACK
            .navigationBarHidden(true)
            .overlay(
               
                ZStack {
                    
                    Circle()
                        .fill()
                        .opacity(0.2)
                        .scaleEffect(1)
                        .frame(width: 58, height: 58, alignment: .center)
                    
                    Circle()
                        .fill()
                        .opacity(0.15)
                        .scaleEffect(1)
                        .frame(width: 68, height: 68, alignment: .center)
                    
                    
                    Button {
                        self.showingAddContactView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color.black))
                            .frame(width: 48, height: 48, alignment: .center)
                    }.padding()
                        .sheet(isPresented: $showingAddContactView) {
                            AddNewContact()
                                .environment(\.managedObjectContext, self.viewContext)
                        }

                }//:ZSATCK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
                   
            )
            
            
        }//: NAVIGATION
        
    }
    
    //MARK: - FUNCS
   
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { contacts[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
