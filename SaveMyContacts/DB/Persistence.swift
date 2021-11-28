//
//  Persistence.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 26.11.21.
//

import CoreData

struct PersistenceController {
    //MARK: - PROPERTY
    static let shared = PersistenceController()

    
    let container: NSPersistentContainer

    //MARK: - BODY
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SaveMyContacts")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    
    //MARK: - PREVIEW
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newContact = ContactsEntity(context: viewContext)
            newContact.name = "Isaiah Cuvulaa"
            newContact.id = UUID()
            newContact.email = "bersyte@gmail.com"
            newContact.phone = "+244 923 456 678"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    
}
