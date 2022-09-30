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
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        NavigationView {
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
                        AllCoinsListView()
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

            //                .sheet(isPresented: $showSettingsView) {
            //                    InfoView()
            //                }
        }
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
            Text("Live Prices")
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
                    //.foregroundColor(Color.theme.accent)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.theme.background)
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
                            .tint(.blue)
                    }
                }
            }
            
            
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: topMoversRows) {
                        ForEach(vm.topMovers(coins: vm.allCoins).prefix(15)) { coin in
                            TopMoversView(coin: coin)
                                .onTapGesture {
                                    segue(coin: coin)
                                }
                                .padding([.vertical, .trailing], 3)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .listRowBackground(Color.theme.background)
            } header: {
                HStack {
                    Text("Top movers")
                        .font(.headline.bold())
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    NavigationLink {
                        TopMoversListView()
                    } label: {
                        Text("See all")
                            .font(.headline.bold())
                            .tint(.blue)
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
                                segue(coin: coin)
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
                        AllCoinsListView()
                    } label: {
                        Text("See all")
                            .font(.headline.bold())
                            .tint(.blue)
                    }
                }
            }
        }
        .listStyle(.grouped)
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
    
    
    private func segue(coin: CoinModel) {
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
