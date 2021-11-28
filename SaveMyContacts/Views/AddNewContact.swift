//
//  AddNewContact.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 28.11.21.
//

import SwiftUI

struct AddNewContact: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var myDismiss
    @State private var showingAlert = false
    
    @State var name = ""
    @State var email = ""
    @State var phone = ""
    
    
    //MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newContact = ContactsEntity(context: viewContext)
            newContact.name = name
            newContact.email = email
            newContact.phone = phone
            newContact.id = UUID()

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
        NavigationView{
            
            VStack(alignment: .leading, spacing: 10) {
                TextField("Name:" , text: $name)
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(12)
                    .font(.system(size: 24, weight: .light, design: .rounded))
                    
                TextField("Email:", text: $email)
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(12)
                    .font(.system(size: 24, weight: .light, design: .rounded))
                
                TextField("Phone:", text: $phone)
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(12)
                    .font(.system(size: 24, weight: .light, design: .rounded))
                
                Button {
                    if self.name.isEmpty {
                       showingAlert = true
                    }else {
                        addItem()
                        myDismiss()
                    }
                   
                } label: {
                    Spacer()
                    Text("SAVE")
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
            .navigationTitle("New Contact")
            .navigationBarTitleDisplayMode(.inline)
            
        }//:NAVIGATION
        
        
    }
}

//MARK: - PREVIEW

struct AddNewContact_Previews: PreviewProvider {
    static var previews: some View {
        AddNewContact()
            .background(Color.gray.ignoresSafeArea(.all))
    }
}
