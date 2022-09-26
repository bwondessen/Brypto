//
//  MarketNewsDataService.swift
//  Brypto
//
//  Created by Bruke on 9/21/22.
//

import Foundation
import Combine

class MarketNewsDataService {
    @Published var marketNews: [MarketNewsModel]?
    var marketNewsDataSubscription: AnyCancellable?
    
    init() {
        getMarketNewsData()
    }

    func getMarketNewsData() {
        guard let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_11500953b057f8fdf0e4045065ac8bf96d449&q=crypto&language=en") else { return }
        
        marketNewsDataSubscription = NetworkingManager.download(url: url)
            .decode(type: Result.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedResultData in
                self?.marketNews = returnedResultData.results
                self?.marketNewsDataSubscription?.cancel()
            })
    }
}
