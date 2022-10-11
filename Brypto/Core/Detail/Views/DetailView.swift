//
//  DetailView.swift
//  Brypto
//
//  Created by Bruke on 6/21/22.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
    
}

struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    @EnvironmentObject private var homeVM: HomeViewModel
    @State private var isBookmarked: Bool = false
    
    @Environment(\.dismiss) var dismiss
    //    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    //@State private var showPortfolioInputSection: Bool = false
    
    let coin: CoinModel
    
    @State private var showBuyAndSellButtons: Bool = false
//    @State private var showBuyView: Bool = false
//    @State private var showSellView: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        self.coin = coin
    }
    
    var body: some View {
        VStack {
            ScrollView {
                
                VStack {
//                    LineView(data: [5, 17, 11, 21, 39, 27, 44, 18, 52, 48, 71, 77, 59, 80, 87, 71, 99, 92, 105, 115, 97, 130, 122, 155, 137, 195])
                    ChartView(coin: vm.coin, showPortfoliInputSection: false)
                    //.padding(.vertical)
                       .padding()
                    
                    VStack(spacing: 20) {
                        Group {
                            overviewTitle
                            descriptionSection
                            //Divider()
                            if homeVM.purchasedCoins.contains(where: { $0.id == coin.id }) {
                                positionTitle
                                positionSection
                            }
                        }
                        statsTitle
                        //Divider()
                        statsGrid
                        //additionalTitle
                        //Divider()
                        //additionalGrid
                        websiteSection
                    }
                    .padding()
                }
            }
        }
        .padding(.bottom)
        .padding(.bottom)
        .padding(.bottom)
        .padding(.bottom)
        .overlay(
            VStack {
                Spacer()
//                if showPortfolioInputSection {
//                    PortfolioInputSection(showBuyView: $showPortfolioInputSection, showSellView: $showPortfolioInputSection, coin: vm.coin)
//                }
                if showBuyAndSellButtons {
                    withAnimation {
                        buyAndSellButtons
                            .background(
                                Color.white.opacity(0.000001)
                                    .frame(height: 20000)
                                    .onTapGesture {
                                        showBuyAndSellButtons = false
                                    }
                            )
                    }
                } else {
                    tradeButton
                }
            }
        )
        .navigationTitle(vm.coin.name)
        //.navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    var percentChange: String {
        return (coin.priceChangePercentage24H ?? 0).asPercentString() /// 100
    }
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
//    private var chartView: some View {
//            VStack {
//            LineView(data: coin.sparklineIn7D?.price ?? [], title: coin.name, legend: coin.symbol, style: ChartStyle(backgroundColor: .red, accentColor: .blue, gradientColor: GradientColor(start: .yellow, end: .orange), textColor: .green, legendTextColor: .gray, dropShadowColor: .purple))
//            }
//    }
    
    private var tradeButton: some View {
        Button {
            showBuyAndSellButtons = true
            //showPortfolioInputSection = true
            //saveButtonPressed()
        } label: {
            Text("Trade")
                .font(.headline.bold())
                .foregroundColor(Color("AccentColorReversed"))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.theme.accent)
                .cornerRadius(10)
                .padding(.horizontal)
//                .onTapGesture {
//                    showBuyAndSellButtons = true
//                }
        }
    }
    
    private var buyAndSellButtons: some View {
        VStack {
            if homeVM.purchasedCoins.contains(where: { $0.id == coin.id }) {
                NavigationLink {
                    SellInputSection(coin: coin)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                } label: {
                    Text("Sell")
                        .font(.headline.bold())
                        .foregroundColor(Color("AccentColorReversed"))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.accent)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            NavigationLink {
                BuyInputSection(coin: coin)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } label: {
                Text("Buy")
                    .font(.headline.bold())
                    .foregroundColor(Color("AccentColorReversed"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.theme.accent)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
    
//    private var buyAndSellButtons: some View {
//        VStack {
//            if homeVM.purchasedCoins.contains(where: { $0.id == coin.id }) {
//                NavigationLink {
//                    PortfolioInputSection(showBuyView: .constant(true), showSellView: .constant(true), coin: coin)
//                        .navigationBarBackButtonHidden(true)
//                        .navigationBarHidden(true)
//                } label: {
//                    Text("Sell")
//                        .font(.headline.bold())
//                        .foregroundColor(Color("AccentColorReversed"))
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.theme.accent)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
////                                            .onTapGesture {
////                                                showSellView = true
////                                                showBuyView = false
////                                            }
//                }
//            }
//
//            if !homeVM.purchasedCoins.contains(where: { $0.id == coin.id }) {
//                NavigationLink {
//                    PortfolioInputSection(showBuyView: .constant(true), showSellView: .constant(false), coin: coin)
//                        .navigationBarBackButtonHidden(true)
//                        .navigationBarHidden(true)
//                } label: {
//                    Text("Buy")
//                        .font(.headline.bold())
//                        .foregroundColor(Color("AccentColorReversed"))
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.theme.accent)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//    //                                    .onTapGesture {
//    //                                        showSellView = false
//    //                                        showBuyView = true
//    //                                    }
//                }
//            }
//        }
//    }
    
    private var overviewTitle: some View {
        HStack {
            Text("Overview")
                .font(.title.bold())
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button {
                homeVM.updateBookmark(coin: vm.coin, isBookmarked: isBookmarked)
            } label: {
                Image(systemName: homeVM.bookmaredCoins.contains(where: { $0.id == vm.coin.id }) ? "bookmark.slash" : "bookmark")
                    .font(.title2)
            }
            .tint(Color.theme.accent)
        }
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty  {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var positionTitle: some View {
        HStack {
            Text(homeVM.purchasedCoins.contains(where: { $0.id == coin.id }) ? "Your position" : "")
                .font(.title.bold())
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var positionSection: some View {
        VStack(spacing: 30) {
            LazyVGrid(
                columns: columns,
                alignment: .leading,
                spacing: spacing,
                pinnedViews: [],
                content: {
                    VStack(alignment: .leading) {
                        Text("Shares")
                            .font(.callout)
                            .foregroundColor(Color.theme.secondaryText)
                        Text(coin.currentHoldings?.asNumberString() ?? "0")
                            .font(.headline.bold())
                            .foregroundColor(Color.theme.accent)
                    }
                    VStack(alignment: .leading) {
                        Text("Equity")
                            .font(.callout)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                    }
                    VStack(alignment: .leading) {
                        Text("Avg Cost")
                            .font(.callout)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("\(coin.avgCost.asCurrencyWith2Decimals())")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                    }
                    VStack(alignment: .leading) {
                        Text("Portfolio Diversity")
                            .font(.callout)
                            .foregroundColor(Color.theme.secondaryText)
                        HStack(spacing: -85) {
                            Text(((coin.currentHoldingsValue / homeVM.portfolioValue) * 100).asPercentString())
                                .font(.headline)
                                .foregroundColor(Color.theme.accent)
                            Circle()
                                .trim(from: 0, to: ((coin.currentHoldingsValue / homeVM.portfolioValue)))
                                .stroke(Color.theme.green, lineWidth: 2.5)
                                .background(
                                    Circle()
                                        .trim(from: 0, to: ((coin.currentHoldingsValue / homeVM.portfolioValue)))
                                        .stroke(Color.theme.secondaryText, lineWidth: 2.5)
                                )
                        }
                    }
                }
            )
            
            VStack(spacing: 15) {
                HStack {
                    Text("Todays Return")
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Spacer()
                    Text("$1 million")
                        .font(.headline)
                        .foregroundColor(Color.theme.accent)
                }
                Divider()
                
                HStack {
                    Text("Total Return")
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Spacer()
                    Text("$1,000 (\(homeVM.getTotalPriceChange(portfolioCoins: [coin]).asPercentString()))")
                        .font(.headline)
                        .foregroundColor(Color.theme.accent)
                }
                Divider()
            }
        }
        .padding(.bottom)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title.bold())
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var statsTitle: some View {
        Text("Stats")
            .font(.title.bold())
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var statsGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
        )
    }
    
//    private var additionalGrid: some View {
//        LazyVGrid(
//            columns: columns,
//            alignment: .leading,
//            spacing: spacing,
//            pinnedViews: [],
//            content: {
//                ForEach(vm.additionalStatistics) { stat in
//                    StatisticView(stat: stat)
//                }
//            }
//        )
//    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
    //    private func getCurrentValue() -> Double {
    //        if let quantity = Double(quantityText) {
    //            return quantity * (selectedCoin?.currentPrice ?? 0)
    //        }
    //        return 0
    //    }
    
    //    private func saveButtonPressed() {
    //        guard
    //            let coin = selectedCoin,
    //            let amount = Double(quantityText)
    //        else { return }
    //
    //        // save to portfolio
    //        homeVM.updatePortfolio(coin: coin, amount: amount)
    //        // show the checkmart
    //        withAnimation(.easeIn) {
    //            showCheckMark = true
    //            removeSelectedCoin()
    //        }
    //
    //        // hdie keyboard
    //        UIApplication.shared.endEditing()
    //
    //        // hide checkmark
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    //            withAnimation(.easeOut) {
    //                showCheckMark = false
    //            }
    //        }
    //    }
    
    //    private func removeSelectedCoin() {
    //        selectedCoin = nil
    //        homeVM.searchText = ""
    //    }
}
