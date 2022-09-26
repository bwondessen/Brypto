//
//  MarketDataModel.swift
//  Brypto
//
//  Created by Bruke on 6/19/22.
//

import Foundation
import SwiftUI

// JSON Data:
/*
 URL: https://api.coingecko.com/api/v3/global

 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 13476,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 521,
     "total_market_cap": {
       "btc": 45759604.36574512,
       "eth": 827923709.3152764,
       "ltc": 17329294452.69135,
       "bch": 7849203766.216507,
       "bnb": 4380060446.957786,
       "eos": 976930065385.7772,
       "xrp": 2881764672355.0923,
       "xlm": 8254220639961.168,
       "link": 142026824062.91043,
       "dot": 125943570334.23285,
       "yfi": 197774788.86270055,
       "usd": 941991363445.3707,
       "aed": 3459938987891.655,
       "ars": 116139271022582.52,
       "aud": 1357681790228.811,
       "bdt": 87735734195600.3,
       "bhd": 355691228880.1541,
       "bmd": 941991363445.3707,
       "brl": 4854822843037.006,
       "cad": 1226147768185.4807,
       "chf": 913368955867.0825,
       "clp": 824677303907720.8,
       "cny": 6327073390853.524,
       "czk": 22200646157571.863,
       "dkk": 6681181132251.706,
       "eur": 898217024786.0603,
       "gbp": 770728855648.7305,
       "hkd": 7394396705205.269,
       "huf": 358360049609335.25,
       "idr": 13974245911422754,
       "ils": 3256609210100.6113,
       "inr": 73437157800683.44,
       "jpy": 127293647920781.2,
       "krw": 1216720588971640,
       "kwd": 289348661135.4234,
       "lkr": 338860952728876.06,
       "mmk": 1747631980845062.2,
       "mxn": 19155830517662.832,
       "myr": 4146645981886.5127,
       "ngn": 391540494347709.94,
       "nok": 9406443157956.414,
       "nzd": 1491200588074.9243,
       "php": 50624657166838.53,
       "pkr": 197356318538116.53,
       "pln": 4205594859419.563,
       "rub": 54070229844446.234,
       "sar": 3535105188737.7817,
       "sek": 9589582292863.393,
       "sgd": 1309669432425.3652,
       "thb": 33209646470641.508,
       "try": 16320306518884.148,
       "twd": 27992686351824.29,
       "uah": 27886408060226.324,
       "vef": 94321595221.78494,
       "vnd": 21881337206784396,
       "zar": 15079051093211.697,
       "xdr": 690230041694.1411,
       "xag": 43560355901.18603,
       "xau": 512123024.6507089,
       "bits": 45759604365745.12,
       "sats": 4575960436574512
     },
     "total_volume": {
       "btc": 9552121.189622667,
       "eth": 172825524.10050043,
       "ltc": 3617415907.2642183,
       "bch": 1638487628.0326614,
       "bnb": 914318836.1683799,
       "eos": 203929961976.169,
       "xrp": 601556018061.1029,
       "xlm": 1723033163674.2937,
       "link": 29647490498.010254,
       "dot": 26290180248.73758,
       "yfi": 41284639.09715861,
       "usd": 196636657766.73187,
       "aed": 722247427160.493,
       "ars": 24243574809239.414,
       "aud": 283410251835.95435,
       "bdt": 18314458293792.75,
       "bhd": 74249018789.42899,
       "bmd": 196636657766.73187,
       "brl": 1013423450521.6273,
       "cad": 255953088765.35464,
       "chf": 190661852920.4896,
       "clp": 172147850892581.9,
       "cny": 1320749439221.8083,
       "czk": 4634289686818.277,
       "dkk": 1394667911789.527,
       "eur": 187498952280.31097,
       "gbp": 160886343654.81995,
       "hkd": 1543548604304.397,
       "huf": 74806123672477.3,
       "idr": 2917063911055640,
       "ils": 679803207944.8868,
       "inr": 15329691785069.027,
       "jpy": 26572003155662.816,
       "krw": 253985205529145.84,
       "kwd": 60400292256.23357,
       "lkr": 70735770812744.78,
       "mmk": 364810681981964.44,
       "mxn": 3998697478459.0264,
       "myr": 865594567489.1517,
       "ngn": 81732399230571.75,
       "nok": 1963554673461.2495,
       "nzd": 311281728344.46936,
       "php": 10567680100021.494,
       "pkr": 41197285211344,
       "pln": 877899892895.5365,
       "rub": 11286928621514.375,
       "sar": 737938049266.9901,
       "sek": 2001784182554.2883,
       "sgd": 273387878026.2421,
       "thb": 6932371294485.228,
       "try": 3406794002722.4,
       "twd": 5843353240525.073,
       "uah": 5821168102885.863,
       "vef": 19689228542.182858,
       "vnd": 4567635312569876,
       "zar": 3147687255239.775,
       "xdr": 144082561428.70572,
       "xag": 9093037503.241718,
       "xau": 106903485.36146116,
       "bits": 9552121189622.666,
       "sats": 955212118962266.6
     },
     "market_cap_percentage": {
       "btc": 41.678380450065426,
       "eth": 14.662648157430489,
       "usdt": 7.2020209635259045,
       "usdc": 5.923765486176081,
       "bnb": 3.7281509783327857,
       "busd": 1.8189800454766623,
       "ada": 1.7329682010120262,
       "xrp": 1.6786685444910112,
       "sol": 1.269002705574948,
       "dot": 0.8918780261495172
     },
     "market_cap_change_percentage_24h_usd": 9.663406205203698,
     "updated_at": 1655678261
   }
 }
 Response headers
  cache-control: public,max-age=300
 */
 
struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}

