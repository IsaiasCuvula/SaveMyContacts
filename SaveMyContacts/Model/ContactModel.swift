//
//  ContactModel.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 28.11.21.
//

import SwiftUI


struct Contact: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let phone: String
}
