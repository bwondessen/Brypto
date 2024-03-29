//
//  HomeView.swift
//  Brypto
//
//  Created by Bruke on 6/9/22.
//

import SwiftUI

struct DiscveryView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // animate right
    @State private var showPortfolioView: Bool = false // new sheet
    //@State private var showSettingsView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var selectedCategory: MarketCategoryDataModel? = nil
    @State private var showCategoryContentView: Bool = false
    @State private var bookmarkedCoin: CoinModel? = nil
    @State private var isBookmarked: Bool = false
    
    @State private var searchText: String = ""
        
    var counter = 0
    
    let categoryColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let topMoversRows = [
        GridItem(.flexible())
    ]
    
    let newsRows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                ZStack {
                    // background layer
                    Color.theme.background
                        .ignoresSafeArea()
                        .sheet(isPresented: $showPortfolioView) {
                            EditPortfolioTabView()
                                .environmentObject(vm)
                        }
                    
                    // content layer
                    VStack {
                        homeHeader
                        
                        SearchBarView(searchText: $vm.searchText)
                            .padding(.horizontal, 8)
                        
                        if vm.searchText.isEmpty {
                            VStack {
                                coinDiscoverySection
                            }
                        } else {
                            //AllCoinsListView(showColumnsTitle: false)
                            TopMoversListView(showColumnsTitle: false)
                        }
                    }
                    //.padding()
                }
                .scrollIndicators(.hidden)
                .navigationBarHidden(true)
                .background(
                    NavigationLink(
                        isActive: $showDetailView,
                        destination: { DetailLoadingView(coin: $selectedCoin) },
                        label: { EmptyView() })
                )
                .background(
                    NavigationLink(
                        isActive: $showCategoryContentView,
                        destination: {
                            CategoryContentView(category: selectedCategory ?? MarketCategoryDataModel(id: "", name: "dfad", marketCap: 1, marketCapChange24h: 1, content: "dfsd", top3Coins: ["d"], volume24h: 1))
                        },
                        label: {
                            EmptyView()
                        })
                )
            } else {
                // Fallback on earlier versions
                ZStack {
                    // background layer
                    Color.theme.background
                        .ignoresSafeArea()
                        .sheet(isPresented: $showPortfolioView) {
                            EditPortfolioTabView()
                                .environmentObject(vm)
                        }
                    
                    // content layer
                    VStack {
                        homeHeader
                        
                        SearchBarView(searchText: $vm.searchText)
                            .padding(.horizontal, 8)
                        
                        if vm.searchText.isEmpty {
                            VStack {
                                coinDiscoverySection
                            }
                        } else {
                            AllCoinsListView(showColumnsTitle: false)
                        }
                    }
                    //.padding()
                }
                .navigationBarHidden(true)
                .background(
                    NavigationLink(
                        isActive: $showDetailView,
                        destination: { DetailLoadingView(coin: $selectedCoin) },
                        label: { EmptyView() })
                )
                .background(
                    NavigationLink(
                        isActive: $showCategoryContentView,
                        destination: {
                            CategoryContentView(category: selectedCategory ?? MarketCategoryDataModel(id: "", name: "dfad", marketCap: 1, marketCapChange24h: 1, content: "dfsd", top3Coins: ["d"], volume24h: 1))
                        },
                        label: {
                            EmptyView()
                        })
                )
            }

            //                .sheet(isPresented: $showSettingsView) {
            //                    InfoView()
            //                }
        }
        .navigationViewStyle(.stack)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DiscveryView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension DiscveryView {
    var searchResults: [CoinModel] {
        if searchText.isEmpty {
            return []
        } else {
            //return vm.all.filter { $0.contains(vm.searchText) }
            return vm.allCoins.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return []
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            return  coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private var homeHeader: some View {
        HStack {
            //            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
            //                .animation(nil, value: UUID())
            //                .onTapGesture {
            //                    if showPortfolio {
            //                        showPortfolioView.toggle()
            //                    } else {
            //                        showSettingsView.toggle()
            //                    }
            //                }
            //                .background(
            //                   x CircleButtonAnimationView(animate: $showPortfolio)
            //                )
            //Spacer()
            Text("Discover")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .padding()
            //Spacer()
            //            CircleButtonView(iconName: "chevron.right")
            //                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
            //                .onTapGesture {
            //                    withAnimation(.spring()) {
            //                        showPortfolio.toggle()
            //                    }
            //                }
        }
        .padding(.horizontal)
        .frame(height: 55)
    }
    
    private var coinDiscoverySection: some View {
        List {
            //            Section {
            //                HStack {
            //                    HomeStatsView(showPortfolio: .constant(false))
            //                        .frame(maxWidth: .infinity)
            //                }
            //            }
            //            .listRowSeparator(.hidden)
            //Text(searchText)
            Section {
                LazyVGrid(columns: categoryColumns) {
                    ForEach(vm.marketCategories) { category in
                        if category.id == "ethereum-ecosystem" || category.id == "meme-token" || category.id == "cosmos-ecosystem" || category.id == "non-fungible-tokens-nft" {
                            CategoryView(category: category)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width / 2.25, height: 70, alignment: .leading)
                                .listRowSeparator(.hidden)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.accent.opacity(0.05))
                                        //.strokeBorder(Color.theme.accent, lineWidth: 0.25)
                                )
                                .onTapGesture {
                                    segueToCategoryContent(category: category)
                                }
                        }
                    }
                    //.foregroundColor(Color.theme.accent
                }
                .listRowSeparator(.hidden)
            } header: {
                HStack {
                    Text("Categories")
                        .font(.headline.bold())
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    NavigationLink {
                        CategoriesListView()
                    } label: {
                        Text("See all")
                            .font(.headline.bold())
                            .foregroundColor(Color.theme.accentMain)
                    }
                }
            }
            
            
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: topMoversRows) {
                        ForEach(vm.topMovers(coins: vm.allCoins).prefix(15)) { coin in
                            TopMoversView(coin: coin)
                                .padding([.vertical, .trailing], 3)
                                .frame(width: 180)
                                .overlay(
                                    Rectangle()
                                        .fill(.white.opacity(0.00000000000000000000001))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                        .onTapGesture {
//                                            segue(coin: coin)
//                                        }
                                )
                                .onTapGesture {
                                    segueToDetailView(coin: coin)
                                }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.leading)
            } header: {
                HStack {
                    Text("Top movers")
                        .font(.headline.bold())
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    NavigationLink {
                        TopMoversListView(showColumnsTitle: true)
                    } label: {
                        Text("See all")
                            .font(.headline.bold())
                            .foregroundColor(Color.theme.accentMain)
                    }
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                ForEach(vm.allCoins) { coin in
                    if coin.rank <= 10 {
                        CoinRowView(coin: coin, showHoldingsColumn: false)
                        //.listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                            .onTapGesture {
                                segueToDetailView(coin: coin)
                            }
                            .listRowBackground(Color.theme.background)
                            .listRowSeparator(.hidden)
                            .swipeActions {
                                Button {
                                    vm.updateBookmark(coin: coin, isBookmarked: isBookmarked)
                                } label: {
                                    Image(systemName: vm.bookmaredCoins.contains(where: { $0.id == coin.id }) ? "bookmark.slash" : "bookmark")
                                }
                                .tint(Color("AccentColor"))
                                
                            }
                    }
                }
            } header: {
                HStack {
                    Text("Top coins")
                        .font(.headline.bold())
                        //.foregroundColor(.primary)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    NavigationLink {
                        AllCoinsListView(showColumnsTitle: true)
                    } label: {
                        Text("See all")
                            .font(.headline.bold())
                            .foregroundColor(Color.theme.accentMain)
                    }
                }
            }
            
            if vm.marketNews.isEmpty {
                
            } else {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: newsRows) {
                            ForEach(vm.marketNews.prefix(5)) { news in
                                Link(destination: URL(string: news.link) ?? URL(string: "https://dilbert.com/404")!) {
                                    NewsView(sourceID: news.sourceID.capitalized, date: Date(coinGeckoString: news.pubDate).asShortDateString(), description: news.description, url: news.imageURL ?? "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80")
                                }
//                                    .padding([.vertical, .trailing], 3)
//                                    .frame(width: 180)
//                                    .overlay(
//                                        Rectangle()
//                                            .fill(.white.opacity(0.00000000000000000000001))
//                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                    )
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal)
                    .padding(.leading)
                } header: {
                    HStack {
                        Text("News")
                            .font(.headline.bold())
                            //.foregroundColor(.primary)
                            .foregroundColor(Color.theme.accent)
                        Spacer()
                        NavigationLink {
                            CryptoNewsView()
                        } label: {
                            Text("See all")
                                .font(.headline.bold())
                                .foregroundColor(Color.theme.accentMain)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.inset)
    }
    
    //    private var portfolioCoinsList: some View {
    //        List {
    //            ForEach(vm.purchasedCoins) { coin in
    //                CoinRowView(coin: coin, showHoldingsColumn: true)
    //                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
    //                    .onTapGesture {
    //                        segue(coin: coin)
    //                    }
    //                    .listRowBackground(Color.theme.background)
    //            }
    //        }
    //        .listStyle(.plain)
    //    }
    
    private var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐")
            .font(.callout)
            .foregroundColor(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    
    private func segueToDetailView(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private func segueToCategoryContent(category: MarketCategoryDataModel) {
        selectedCategory = category
        showCategoryContentView.toggle()
    }
    
    //        private func bookmarkButtonPressed() {
    //            guard
    //                //let coin = selectedCoin,
    //                let isBookmarked = isBookmarked
    //                //let amount = Double(quantityText)
    //            else { return }
    //
    //            // save to portfolio
    //            vm.updateBookmark(coin: coin, isBookmarked: <#T##Bool#>)
    //        }
    
}
