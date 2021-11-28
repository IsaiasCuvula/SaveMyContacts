//
//  ContactItemView.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 26.11.21.
//

import SwiftUI

struct ContactItemView: View {
    //MARK: - PROPERTIES
    //@Environment(\.managedObjectContext) var viewContext
    @ObservedObject var  contact: ContactsEntity
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 10) {
                
                Text(contact.name ?? "Unknown")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(alignment: .leading)
                    
                Spacer()
                Button {
                    //Send email to this user
                } label: {
                    Image(systemName: "envelope.fill")
                }
                

            }//:HSTACK
            .padding()
        }//:VSTACK
        .cornerRadius(12)  
    }
}
/*
struct ContactItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContactItemView(contact: myContactExample)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}*/
