//
//  UpdateContact.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 28.11.21.
//

import SwiftUI

struct UpdateContact: View {
    
    //MARK: - PROPERTIES
    @State private var showingAlert = false
    @Environment(\.dismiss) var myDismiss
    @ObservedObject var contact: ContactsEntity
    @Environment(\.managedObjectContext) var viewContext
    
    @State var name = ""
    @State var email = ""
    @State var phone = ""
    
    //MARK: - FUNCS
    private func updateContact() {
        withAnimation {
            let updateContact = ContactsEntity(context: viewContext)
            updateContact.name = name
            updateContact.email = email
            updateContact.phone = phone
            updateContact.id = contact.id

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            name = ""
            email = ""
            phone = ""
        }
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            NavigationView{
                
                VStack(alignment: .leading, spacing: 10) {
                    TextField(contact.name ?? "" , text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(12)
                        .font(.system(size: 24, weight: .light, design: .rounded))
                        
                    TextField(contact.email ?? "", text: $email)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(12)
                        .font(.system(size: 24, weight: .light, design: .rounded))
                    
                    TextField(contact.phone ?? "", text: $phone)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(12)
                        .font(.system(size: 24, weight: .light, design: .rounded))
                    
                    Button {
                        if self.name.isEmpty {
                           showingAlert = true
                        }else {
                            updateContact()
                            myDismiss()
                            
                        }
                       
                    } label: {
                        Spacer()
                        Text("UPDATE")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Spacer()
                    }.foregroundColor(.black)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Invalind Name"), message: Text("Add a valid name!"), dismissButton: .default(Text("OK")))
                    }
                    
                    Spacer()
                }//VSTACK
                .padding(20)
                .navigationTitle("Update Contact")
                .navigationBarTitleDisplayMode(.inline)
                
            }//:NAVIGATION
            
            
        }
    }
}

struct UpdateContact_Previews: PreviewProvider {
    static var previews: some View {
        UpdateContact(contact: myContactExample)
    }
}
