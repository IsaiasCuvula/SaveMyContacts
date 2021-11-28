//
//  ContactViewDetail.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 28.11.21.
//

import SwiftUI

struct ContactViewDetail: View {
    
    //MARK: - PROPERTIES
    @ObservedObject var contact: ContactsEntity
    
    //MARK: - FUNCS
    
    private func myContactsLabel(myLabel: String) -> Text {
        
        return  Text(myLabel).fontWeight(.light)
            .font(.body)
            
    }
    
    private func myContactsValues(txt: String) -> Text {
        
        return  Text(txt).fontWeight(.medium)
            .font(.title)
  
    }
    
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            //MARK: - TOP
            VStack(alignment: .leading, spacing: 0) {
                   myContactsLabel(myLabel: "Full Name")
                myContactsValues(txt: contact.name ?? "Unknown")
            }.padding()
            
            //MARK: - CENTER
            VStack(alignment: .leading, spacing: 0) {
                   myContactsLabel(myLabel: "Email Address")
                HStack(spacing: 0) {
                    myContactsValues(txt: contact.email ?? "Unknown")
                    Spacer()
                    Image(systemName: "envelope.fill")
                }.padding(.trailing)
            }.padding()
            
            //MARK: - BOTTOM
            VStack(alignment: .leading, spacing: 0) {
                   myContactsLabel(myLabel: "Phone")
                   myContactsValues(txt: contact.phone ?? "Unknown")
            }.padding()
            
            Spacer()
            
        }//: VSTACK
        .padding()
    }
}

struct ContactViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContactViewDetail(contact: myContactExample)
    }
}
