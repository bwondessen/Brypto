//
//  MarketNewsModel.swift
//  Brypto
//
//  Created by Bruke on 9/20/22.
//

import Foundation
import SwiftUI

/*
 URL: https://newsdata.io/api/1/news?apikey=pub_11500953b057f8fdf0e4045065ac8bf96d449&q=crypto&language=en
 
 JSON Response:
 {
 "title":"A 23-year-old, self-described 'Crypto King' reportedly had his Lamborghini, BMWs, and McLarens seized after investors sued him claiming he stole $35 million",
 "link":"https://www.businessinsider.com/self-described-crypto-king-aiden-pleterski-sued-cars-seized-report-2022-9",
 "keywords":null,
 "creator":null,
 "video_url":null,
 "description":"Around 140 investors reportedly gave at least $35 million to Aiden Pleterski's company as cryptocurrency and foreign exchange investments.","content":"Aiden Pleterski, who calls himself \"Crypto King,\" had $2 million of assets seized, CBC Toronto reports. Pleterski was reportedly given $35 million by 140 investors. Now, he's being sued by former investors in a bankruptcy proceeding and two civil lawsuits. Get the latest tech news & scoops — delivered daily to your inbox. Loading Something is loading. Email address By clicking ‘Sign up’, you agree to receive marketing emails from Insider as well as other partner offers and accept our Terms of Service and Privacy Policy . A 23-year-old Canadian who calls himself the \"Crypto King\" reportedly had $2 million worth of assets seized as he's being sued over allegations he defrauded investors. The seized assets of the man, Aiden Pleterski, include his Lamborghini, two McLarens, and two BMWs, CBC Toronto first reported. Investors told the publication that at least $35 million given to Pleterski's company, AP Private Equity Limited, went missing. Twenty-nine creditors have a bankruptcy proceeding against Pleterski, and say he owes them almost $13 million, including one 65-year-old woman who told CBC Toronto she invested $60,000 that she was keeping for her grandchildren's education. Norman Groot, founder of Investigation Counsel PC, told CBC Toronto that the bankruptcy proceeding against Pleterski, who started investing in cryptocurrency as a teenager, was one of the only ways investors could try to get their money back. Pleterski has since had his assets and bank accounts frozen , according to the report. Pleterski reportedly was renting a lakefront mansion in Burlington, Ontario that he spent $45,000 a month for, and previously paid for promotional articles about himself on websites like Forbes's publication in Monaco , and far-right publication Daily Caller . A lawyer for Pleterski told CBC Toronto that Pleterski thinks the claims against him by former investors are \"wildly exaggerated.\" \"Shockingly, it seems that nobody bothered to consider what would happen if the cryptocurrency market plummeted or whether Aiden, as a very young man, was qualified to handle these types of investments,\" Pleterski's lawyer, Micheal Simaan, told CBC Toronto . He added that Pleterski is \"co-operating with the bankruptcy process and is hopeful that it will work out in the most equitable fashion for everyone involved.\" Insider reached out to Pleterski's lawyer for additional comment but did not immediately hear back ahead of publication. In a meeting with creditors, Pleterski reportedly told them he was \"very unorganized,\" and didn't keep records of his investments. His trustee told creditors that Pleterski said he lost the money he had received between late 2021 and early 2022 \"in a series of margin calls and bad trades,\" CBC Toronto reported. Right now, Pleterski doesn't have a criminal charge against him, Gizmodo reports , but is facing the bankruptcy proceeding and two civil lawsuits .",
 "pubDate":"2022-09-21 22:06:37",
 "image_url":"https://i.insider.com/632b813ff576c60018fc2815?format=jpeg",
 "source_id":"businessinsider_us",
 "country":["united states of america"],
 "category":["top"],
 "language":"english"
 }
 */

struct Result: Codable {
    let status: String
    let totalResults: Int
    let results: [MarketNewsModel]?
}

struct MarketNewsModel: Identifiable, Codable {
    let title: String
    let link: String
    let keywords: [String]?
    let creator: [String]?
    let videoURL: String?
    let description: String
    let content: String?
    let pubDate: String
    let imageURL: String?
    let sourceID: String
    let country: [String]
    let category: [String]
    let language: String

    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description
        case content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case country, category, language
    }
    
    var id: String {
        return title
    }
}

