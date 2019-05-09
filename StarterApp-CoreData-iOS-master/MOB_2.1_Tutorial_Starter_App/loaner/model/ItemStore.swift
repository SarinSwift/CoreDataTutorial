//
//  ItemStore.swift
//  loaner
//
//  Created by Sarin Swift on 5/8/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//  Or in other words, the Core Data Stack

import UIKit
import CoreData

class ItemStore: NSObject {
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LoanedItems")
        
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                print("Error setting up Core Data: \(error)")
            }
        })
        
        return container
    }()
    
    // MARK: - Save Core Data Context
    
    func saveContext() {
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Fetch Core Data Context
    
    func fetchPersistedData(completion: @escaping (FetchItemsResult) -> Void) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let viewContext = persistentContainer.viewContext
        
        do {
            let allItems = try viewContext.fetch(fetchRequest)
            completion(.success(allItems))
        } catch {
            completion(.failure(error))
        }
    }
}

enum FetchItemsResult {
    case success([Item])
    case failure(Error)
}
