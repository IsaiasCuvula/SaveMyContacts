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
        VStack(alignment: .trailing, spacing: 5) {
            TextField("Name:" , text: $name)
                .foregroundColor(.black)
                .font(.title)
            TextField("Email:", text: $email)
                .font(.title)
            
            Button {
                addItem()
               
            } label: {
                Spacer()
                Text("SAVE")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                Spacer()
            }
        }
        .padding()
    }
}

struct AddNewContact_Previews: PreviewProvider {
    static var previews: some View {
        AddNewContact()
            .background(Color.gray.ignoresSafeArea(.all))
    }
}
