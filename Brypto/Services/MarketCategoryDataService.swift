//
//  MarketCategoryDataService.swift
//  Brypto
//
//  Created by Bruke on 9/11/22.
//

import Foundation
import Combine

class MarketCategoryDataService {
    @Published var marketCategoryData: [MarketCategoryDataModel]?
    var marketCategoryDataSubscription: AnyCancellable?
    
    init() {
        getMarketCategoryData()
    }

    func getMarketCategoryData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/categories") else { return }
        
        marketCategoryDataSubscription = NetworkingManager.download(url: url)
            .decode(type: [MarketCategoryDataModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedMarketCategoryData in
                self?.marketCategoryData = returnedMarketCategoryData
                self?.marketCategoryDataSubscription?.cancel()
            })
    }
}
