//
//  HomeViewModel.swift
//  Brypto
//
//  Created by Bruke on 6/12/22.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []
    @Published var marketCategories: [MarketCategoryDataModel] = []
    @Published var marketNews: [MarketNewsModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var purchasedCoins: [CoinModel] = []
    @Published var bookmaredCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    //@Published var isBookmarked: Bool = false
    
    @Published var dollarAmount: String = ""
    @AppStorage("totalDollarAmountInPortfolio") var totalDollarAmountInPortfolio: Double = 0
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    let marketCategoryDataService = MarketCategoryDataService()
    let marketNewsDataService = MarketNewsDataService()
    //@Published var marketCategoryDataService = MarketCategoryDataService()
    private let portfolioDataService = PortfolioDataService()
    private let bookmarkDataService = BookmarkDataService()
    private var cancellables = Set<AnyCancellable>()
        
    @Published var alternativeTheme: Bool = false
    
    @AppStorage("isUnlocked") var isUnlocked: Bool = false
    @AppStorage("isSignedUp") var isSignedUp: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userName") var userName: String = ""
    @AppStorage("password") var password: String = ""
    
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("email") var email: String = ""
    
    @AppStorage("faceIDEnabled") var faceIDEnabled: Bool = false
    @AppStorage("passcodeRequired") var passcodeRequired: Bool = false
        
    let icons: [String] = ["bonjour", "antenna.radiowaves.left.and.right", "wifi", "icloud.and.arrow.down", "lock.icloud", "key.icloud", "bolt.horizontal", "network.badge.shield.half.filled", "personalhotspot", "externaldrive.connected.to.line.below", "lock.iphone", "pencil.slash", "square.and.pencil", "folder", "square.grid.3x1.folder.badge.plus", "paperplane", "tray.and.arrow.down", "externaldrive", "doc", "doc.text.magnifyingglass", "note.text", "calendar.badge.clock", "text.book.closed", "newspaper", "link", "umbrella", "bolt.shield", "wand.and.stars", "speedometer", "amplifier", "dice", "theatermasks", "puzzlepiece", "lock", "testtube.2", "checkerboard.shield", "chart.xyaxis.line", "chart.pie", "sdcard", "esim", "camera.filters", "lightbulb", "person.wave.2", "person.crop.circle.fill.badge.plus", "brain.head.profile", "face.smiling", "globe.americas", "flame", "bolt", "scale.3d", "bag", "cart", "creditcard", "banknote", "dollarsign.square", "centsign.square"]
    
    //@Published var priceChanges: [Double] = []
    let defaults = UserDefaults.standard
    var priceChanges: [String] = UserDefaults.standard.stringArray(forKey: "priceChanges") ?? []
    //defaults.set(priceChanges, forKey: "priceChanges")
    
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
            
    var portfolioValue: Double {
       return purchasedCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
    }
    
    var totalReturn: Double {
        portfolioValue - totalDollarAmountInPortfolio
    }
        
//    var priceHistory: [Double] {
//
//    }
    
//    var sparklinePrices: [Double] {
//
//    }
    
//    let combined = purchasedCoins.map { $0.sparklineIn7D?.price }
//
//    if let averages = averageByIndex(elms: elms) {
//        print(averages) // [4.0, 4.0, 6.666666666666667]
//    }
    
//    var avgPrices: [Double] {
//        let combined = purchasedCoins.map { $0.sparklineIn7D?.price ?? [0] }
//
//        //averageByIndex(elms: combined)
//
//        guard let averages = averageByIndex(elms: combined) else {
//            //print(averages) // [4.0, 4.0, 6.666666666666667]
//            //return averages
//            return []
//        }
//
//        return averages
//    }
    
    func averageByIndex(elms:[[Double]]) -> [Double]? {
        guard let length = elms.first?.count else { return []}

        // check all the elements have the same length, otherwise returns nil
        guard !elms.contains(where:{ $0.count != length }) else { return nil }

        return (0..<length).map { index in
            let sum = elms.map { $0[index] }.reduce(0, +)
            return sum / Double(elms.count)
        }
    }
    
    var totalReturnPercentage: Double {
        ((portfolioValue - totalDollarAmountInPortfolio) / totalDollarAmountInPortfolio) * 100
    }
    
    func getTop3Coins(coins: [CoinModel]) -> [String] {
        var top3CoinsNames: [String] = []
        var newLink = ""
        
        for categories in marketCategories {
            for link in categories.top3Coins {
                newLink = link.replacingOccurrences(of: "-", with: "")
                newLink = newLink.replacingOccurrences(of: "_", with: "")
                for coin in coins {
                    if newLink.contains(coin.name) {
                        top3CoinsNames.append(coin.name)
                    }
                }
            }
        }
        return top3CoinsNames
    }
    
//    var portfolioDiversity: Double {
//
//    }
    
//    var percentageChange: Double {
//        ((portfolioValue - previousValue) / previousValue) * 100
//    }
        
//    let previousValue =
//        portfolioCoins
//        .map { coin -> Double in
//            let currentValue = coin.currentHoldingsValue
//            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
//            let previousValue = currentValue / (1 + percentChange)
//            return previousValue
//        }
//        .reduce(0, +)
    
//    let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // code below no longer needed
//        dataService.$allCoins
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
                
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.allCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates portfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortflio)
            .sink { [weak self] returedCoins in
                self?.purchasedCoins = returedCoins
            }
            .store(in: &cancellables)
        
        // updates bookmark
        $allCoins
            .combineLatest(bookmarkDataService.$savedEntities)
            .map(mapAllCoinsToBookmark)
            .sink { [weak self] returnedCoins in
                self?.bookmaredCoins = returnedCoins
            }
            .store(in: &cancellables)
//            .sink { [weak self] returedCoins in
//                self?.purchasedCoins = returedCoins
//            }
//            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($purchasedCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
         // updates marketCategoryData
        marketCategoryDataService.$marketCategoryData
            //.combineLatest($purchasedCoins)
            //.map(mapMarketCategoryData)
            .map { marketData in
                guard let data = marketData else { return [] }
                return data
            }
            .sink { [weak self] returnedMarketCategoryData in
                self?.marketCategories = returnedMarketCategoryData
                //self?.isLoading = false
            }
            .store(in: &cancellables)
        
        // updates marketNewsData
        marketNewsDataService.$marketNews
           //.combineLatest($purchasedCoins)
           //.map(mapMarketCategoryData)
           .map { marketNews in
               guard let newsData = marketNews else { return [] }
               return newsData
           }
           .sink { [weak self] returnedMarketNewsData in
               self?.marketNews = returnedMarketNewsData
               //self?.isLoading = false
           }
           .store(in: &cancellables)
    }
    
    func buyCoin(coin: CoinModel, amount: Double) {
        portfolioDataService.buyCoin(coin: coin, amount: amount)
    }
    
    func sellCoin(coin: CoinModel, amount: Double) {
        portfolioDataService.sellCoin(coin: coin, amount: amount)
    }
    
//    func updatePortfolio(coin: CoinModel, amount: Double) {
//        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
//    }
    
    func updateBookmark(coin: CoinModel, isBookmarked: Bool) {
        //portfolioDataService.updateBookmarks(coin: coin, isBookmarked: isBookmarked)
        //portfolioDataService.updateBookmarks(coin: coin, isBookmarked: isBookmarked)
        bookmarkDataService.updateBookmarks(coin: coin, isBookmarked: isBookmarked)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            return  coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { ($0.currentPrice ?? 0) > ($1.currentPrice ?? 0) })
        case .priceReversed:
            coins.sort(by: { ($0.currentPrice ?? 0) < ($1.currentPrice ?? 0) })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holdings or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    func topMovers(coins: [CoinModel]) -> [CoinModel] {
        coins.sorted(by: { $0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0 })
    }
    
    private func mapAllCoinsToPortflio(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id && $0.amount != 0 }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapAllCoinsToBookmark(allCoins: [CoinModel], portfolioEntities: [BookmarkEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateBookmark(isBookmarked: entity.isBookmarked)
            }
    }

    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
            portfolioCoins
                .map({ $0.currentHoldingsValue })
                .reduce(0, +)
        
        let previousValue =
            portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
//        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Balance", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        // percentage change before -> ((portfolioValue - totalDollarAmountInPortfolio) / totalDollarAmountInPortfolio) / 100
                
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
    
    func getTotalPriceChange(portfolioCoins: [CoinModel]) -> Double {
        let portfolioValue =
            portfolioCoins
                .map({ $0.currentHoldingsValue })
                .reduce(0, +)
        
        let previousValue =
            portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

        return percentageChange
    }
    
//    private func mapMarketCategoryData(marketCategoryDataModel: MarketCategoryDataModel?) -> [MarketCategoryDataModel] {
//        var categories: [MarketCategoryDataModel] = []
//
//        guard let categoryData = marketCategoryDataModel else { return categories }
//        categories.append(categoryData)
//
//        return categories
//    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to use Brypto."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    Task { @MainActor in
                        self.isUnlocked = true
                    }
                } else {
                    // error
                }
            }
        } else {
            // no biometrics
        }
    }
    
    func signUp(enteredUserName: String, enteredPassword: String, enteredEmail: String, enteredFullName: String) {
        if !enteredUserName.isEmpty && !enteredPassword.isEmpty && !enteredEmail.isEmpty && !enteredFullName.isEmpty {
            self.isUnlocked = true
            self.isSignedUp = true
            self.isLoggedIn = true
        }
    }
    
    func signIn(userName: String, password: String) {
        if userName == self.userName && password == self.password {
            self.isUnlocked = true
            self.isSignedUp = true
        }
    }
    
    func login(enteredUserName: String, enteredPassword: String) {
        if enteredUserName == self.userName && enteredPassword == self.password {
            self.isUnlocked = true
            self.isLoggedIn = true
        }
    }
    
    func enableFaceID(faceIDEnabled: Bool) {
        if faceIDEnabled {
            authenticate()
        }
    }
    
    func logOut() {
        self.isLoggedIn = false
        self.isUnlocked = false
    }
    
    func deleteAccount() {
        self.isLoggedIn = false
        self.isUnlocked = false
        self.isSignedUp = false
        
        self.userName = ""
        self.password = ""
        self.fullName = ""
        self.email = ""
    }
    
//    func changeTheme() {
//        if !alternativeTheme {
//            Color.theme = ColorThemeAlternative()
//        } else {
//            Color.theme = ColorThemeAlternative()
//        }
//    }
}
