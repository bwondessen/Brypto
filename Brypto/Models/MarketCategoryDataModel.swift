//
//  MarketCategoryDataModel.swift
//  Brypto
//
//  Created by Bruke on 9/11/22.
//

import Foundation
import SwiftUI

// JSON Data:
/*
 URL: https://api.coingecko.com/api/v3/coins/categories
 
 JSON Response:
 {
     "id": "ethereum-ecosystem",
     "name": "Ethereum Ecosystem",
     "market_cap": 480199895102.1914,
     "market_cap_change_24h": 1.8192687244610233,
     "content": "",
     "top_3_coins": [
       "https://assets.coingecko.com/coins/images/279/small/ethereum.png?1595348880",
       "https://assets.coingecko.com/coins/images/325/small/Tether-logo.png?1598003707",
       "https://assets.coingecko.com/coins/images/6319/small/USD_Coin_icon.png?1547042389"
     ],
     "volume_24h": 77985354084.34267,
     "updated_at": "2022-09-11T16:56:49.227Z"
   }
 */

struct MarketCategoryDataModel: Identifiable, Codable {
    let id, name: String
    let marketCap, marketCapChange24h: Double?
    let content: String?
    let top3Coins: [String]
    let volume24h: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case marketCap = "market_cap"
        case marketCapChange24h = "market_cap_change_24h"
        case content
        case top3Coins = "top_3_coins"
        case volume24h = "volume_24h"
    }
}
