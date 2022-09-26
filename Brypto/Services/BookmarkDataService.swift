//
//  HoldingsDataService.swift
//  Brypto
//
//  Created by Bruke on 6/20/22.
//

import Foundation
import CoreData
import UIKit

class BookmarkDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "BookmarkEntity"
    
    @Published var savedEntities: [BookmarkEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC
        
    func updateBookmarks(coin: CoinModel, isBookmarked: Bool) {
        // check if coin is alrady in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if isBookmarked {
                addToBookmark(entity: entity, isBookmarked: isBookmarked)
            } else {
                //removeFromBookmark(entity: entity)
                delete(entity: entity)
            }
        } else {
            addToBookmarkAndPortfolio(coin: coin)
        }
    }
    
//    func updateBooking(coin: CoinModel, isBookmarked: Bool) {
//        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
//            delete(entity: entity)
//        } else {
//            bookmark(coin: coin, isBookmarked: isBookmarked)
//        }
//    }
    
    // MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<BookmarkEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
            
    private func addToBookmark(entity: BookmarkEntity, isBookmarked: Bool) {
        entity.isBookmarked = isBookmarked
        applyChanges()
    }
    
    private func removeFromBookmark(entity: BookmarkEntity) {
        entity.isBookmarked = false
        applyChanges()
    }
    
    private func addToBookmarkAndPortfolio(coin: CoinModel) {
        let entity = BookmarkEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.isBookmarked = true
        applyChanges()
    }
    
    private func delete(entity: BookmarkEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
