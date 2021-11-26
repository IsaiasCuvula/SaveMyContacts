//
//  ContactItemView.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 26.11.21.
//

import SwiftUI

struct ContactItemView: View {
    //MARK: - PROPERTIES
    
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Alessandra Oswald")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(alignment: .leading)
                
            HStack(spacing: 10) {
                Text("1")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Spacer()
                Button {
                    //Send email to this user
                } label: {
                    Image(systemName: "envelope.fill")
                }
                

            }//:HSTACK
        }//:VSTACK
        .cornerRadius(12)
        
        
    }
}

struct ContactItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContactItemView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
