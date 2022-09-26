//
//  HoldingsDataService.swift
//  Brypto
//
//  Created by Bruke on 6/20/22.
//

import Foundation
import CoreData
import UIKit

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
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
    
    func buyCoin(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            purchaseCoin(entity: entity, amount: amount)
        } else {
            addToPortfolio(coin: coin, amount: amount)
        }
    }
    
    func sellCoin(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            guard amount <= entity.amount else { return }
            removeCoin(entity: entity, amount: amount)
        }
    }
    
//    func updatePortfolio(coin: CoinModel, amount: Double) {
//        // check if coin is alrady in portfolio
//        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
//            if amount > 0 {
//                updatePortfolio(entity: entity, amount: amount)
//            }
//            else {
//                delete(entity: entity)
//            }
//        } else {
//            addToPortfolio(coin: coin, amount: amount)
//        }
//    }
    
//    func updateBookmarks(coin: CoinModel, isBookmarked: Bool) {
//        // check if coin is alrady in portfolio
//        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
//            if isBookmarked {
//                addToBookmark(entity: entity, isBookmarked: isBookmarked)
//            } else {
//                //removeFromBookmark(entity: entity)
//                delete(entity: entity)
//            }
//        } else {
//            //addToBookmarkAndPortfolio(coin: coin)
//        }
//    }
    
//    func updateBooking(coin: CoinModel, isBookmarked: Bool) {
//        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
//            delete(entity: entity)
//        } else {
//            bookmark(coin: coin, isBookmarked: isBookmarked)
//        }
//    }
    
    // MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func addToPortfolio(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func purchaseCoin(entity: PortfolioEntity, amount: Double) {
        entity.amount += amount
        applyChanges()
    }
    
    private func removeCoin(entity: PortfolioEntity, amount: Double) {
        entity.amount -= amount
//        if entity.amount == 0 {
//            delete(entity: T##PortfolioEntity)
//        }
        applyChanges()
    }
    
    private func addToBookmark(entity: PortfolioEntity, isBookmarked: Bool) {
        entity.isBookmarked = isBookmarked
        applyChanges()
    }
    
    private func removeFromBookmark(entity: PortfolioEntity) {
        entity.isBookmarked = false
        applyChanges()
    }
    
//    private func addToBookmarkAndPortfolio(coin: CoinModel) {
//        let entity = PortfolioEntity(context: container.viewContext)
//        entity.coinID = coin.id
//        entity.isBookmarked = true
//        applyChanges()
//    }
    
    private func delete(entity: PortfolioEntity) {
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
