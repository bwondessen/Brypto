//
//  PortfolioView.swift
//  Brypto
//
//  Created by Bruke on 6/19/22.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    @State private var isBookmarked: Bool = false
    
    @State private var showEditPortfolioSheet = false
    @Binding var inPortfolioTab: Bool
    
    @State private var showDetailView: Bool = false
    
    @AppStorage("collapsBookmarkeSection") private var collapseBookmarkSection: Bool = false
    @AppStorage("collapsePurchasedCoinsSection") private var collapsePurchasedCoinsSection: Bool = false
    
    @State private var emptyArray: [CoinModel] = []
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                homeHeader
                // testing
                Text("\(vm.priceDates?[0] ?? Date())")
                Text("buying power: \(vm.buyingPower.asCurrencyWith2Decimals())")
                Text("price count: \(vm.priceChanges.count)")
                Text("date count: \(vm.priceDates?.count ?? 0)")
                Text("total return: \(vm.totalReturn.asCurrencyWith2Decimals())")
                Text("portfolio value: \(vm.portfolioValue.asCurrencyWith2Decimals())")
                Text("total dollar amount: \(vm.totalDollarAmountInPortfolio.asCurrencyWith2Decimals())")
//                balanceView
//                    .padding()
                //SearchBarView(searchText: $vm.searchText)
                VStack {
                    purchasedAndBookmarkedCoinsRows
                    //.listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
                //            if selectedCoin != nil {
                //                portfolioInputSection
                //                    .padding(.bottom)
                //            }
                
            }
            .onChange(of: vm.portfolioValue, perform: { newValue in
                vm.priceChanges.append(String(newValue))
                UserDefaults.standard.set(vm.priceChanges, forKey: "priceChanges")
                
                vm.priceDates?.append(Date())
                UserDefaults.standard.set(vm.priceDates, forKey: "priceDates")
            })
            .navigationBarHidden(true)
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .sheet(isPresented: $showEditPortfolioSheet) {
                EditPortfolioTabView()
            }
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    if !inPortfolioTab {
            //                        XMarkButton(dismiss: _dismiss)
            //                    }
            //                }
            //            }
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    trailingNavBarButtons
            //                }
            //            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    isActive: $showDetailView,
                    destination: { DetailLoadingView(coin: $selectedCoin) },
                    label: { EmptyView() })
            )
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioTabView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var homeHeader: some View {
        ZStack {
            HStack {
                CircleButtonView(iconName: "plus")
                    .scaledToFit()
                    .animation(nil, value: UUID())
                    .onTapGesture {
                        showEditPortfolioSheet = true
                    }
                Spacer()
            }
            HStack {
                Text("Portfolio")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.theme.accent)
                    .padding()
            }
        }
        .padding(.horizontal)
        .frame(height: 55)
    }
    
    private var balanceView: some View {
        VStack {
            HStack {
                HomeStatsView(showPortfolio: .constant(true))
                //Spacer()
            }
            .padding(.bottom)
            PortfolioChartView(purchasedCoins: vm.purchasedCoins, showPortfoliInputSection: false)
                //.frame(height: 100)
        }
//        //.padding()
    }
    
    private var purchasedAndBookmarkedCoinsRows: some View {
        List {
            Section {
                balanceView
                    .padding(.bottom)
                columnTitles
                    .listRowSeparator(.hidden)
            }
            .listRowSeparator(.hidden)
            
            Section {
//                ForEach(vm.searchText.isEmpty ? vm.purchasedCoins : vm.allCoins) { coin in
                ForEach(collapsePurchasedCoinsSection ? emptyArray : vm.purchasedCoins) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: true, showRank: false, showChart: true)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .padding(.horizontal)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.theme.background)
                        .onTapGesture {
                            segue(coin: coin)
                        }
                        .swipeActions {
                            Button {
                                withAnimation {
                                    vm.updateBookmark(coin: coin, isBookmarked: isBookmarked)
                                }
                            } label: {
                                Image(systemName: vm.bookmaredCoins.contains(where: { $0.id == coin.id }) ? "bookmark.slash" : "bookmark")
                            }
                            .tint(Color("AccentColor"))
    
                        }
                }
            } header: {
                HStack {
                    Text("Purchased")
                        .font(.headline.bold())
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    Button {
                        withAnimation(.default) {
                            collapsePurchasedCoinsSection.toggle()
                        }
                    } label: {
                        Image(systemName: collapsePurchasedCoinsSection ? "chevron.down" : "chevron.up")
                            .font(.body)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
            }
            //.padding(.vertical)

            Section {
                LazyVGrid(columns: columns) {
                    ForEach(collapseBookmarkSection ? emptyArray : vm.bookmaredCoins) { coin in
                        //CoinRowView(coin: coin, showHoldingsColumn: false)
                        HStack {
                            VStack {
                                CoinImageView(coin: coin)
                                    .frame(width: 30, height: 30)
                                Text(coin.symbol.uppercased())
                            }
                            VStack {
                                Text("\(coin.currentPrice?.asCurrencyWith2Decimals() ?? "N/A")")
                                    .font(.headline.bold())
                                    .padding(.bottom, 2)
                                Text((coin.priceChange24H?.asNumberString() ?? "N/A") + "%")
                                    .font(.callout)
                                    .foregroundColor((coin.priceChange24H ?? 0 >= 0) ? Color.theme.green : Color.theme.red)
                            }
                        }
                        .frame(width: 115, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder((coin.priceChange24H ?? 0 >= 0) ? Color.theme.green : Color.theme.red, lineWidth: 0.40)
                        )
                        .lineLimit(1)
                        //.padding(.bottom)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                segue(coin: coin)
                            }
                    }
                }
            } header: {
                HStack {
                    Text("Bookmarked")
                        .font(.headline.bold())
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    Button {
                        withAnimation(.default) {
                            collapseBookmarkSection.toggle()
                        }
                    } label: {
                        Image(systemName: collapseBookmarkSection ? "chevron.down" : "chevron.up")
                            .font(.body)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.theme.background)
            
            //        LazyVGrid(columns: columns, spacing: 10, pinnedViews: [.sectionHeaders]) {
            //            Section {
            //                ForEach(vm.searchText.isEmpty ? vm.purchasedCoins : vm.allCoins) { coin in
            //                    CoinLogoView(coin: coin)
            //                        .frame(width: 75)
            //                        .padding(4)
            //                        .onTapGesture {
            //                            withAnimation(.easeIn) {
            //                                updateSelectedCoin(coin: coin)
            //                            }
            //                        }
            //                        .background(
            //                            RoundedRectangle(cornerRadius: 10)
            //                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear, lineWidth: 1)
            //                        )
            //                }
            //            } header: {
            //                Text(vm.searchText.isEmpty ? "Holdings" : "Select a coin")
            //                    .font(.headline.bold())
            //                    .padding()
            //            }
            
            //            Section {
            //                ForEach(vm.bookmaredCoins) { coin in
            //                    if coin.isBookmarked ?? false {
            //                        CoinLogoView(coin: coin)
            //                            .frame(width: 75)
            //                            .padding(4)
            //                            .onTapGesture {
            //                                withAnimation(.easeIn) {
            //                                    updateSelectedCoin(coin: coin)
            //                                }
            //                            }
            //                            .background(
            //                                RoundedRectangle(cornerRadius: 10)
            //                                    .stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear, lineWidth: 1)
            //                            )
            //                    }
            //                }
            //            } header: {
            //                Text("Bookmarked")
            //                    .font(.headline.bold())
            //                    .padding()
            //            }
        }
        .listStyle(.grouped)
        //.padding(.leading)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0.0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            HStack(spacing: 4) {
                Text("Holdings")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0.0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0.0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 5.0, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360.0 : 0.0), anchor: .center)
        }
        .font(.caption)
        .foregroundColor(Color.theme.accent)
        .padding(.horizontal)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.theme.accent.opacity(0.05))
        )
        .listRowBackground(Color.theme.background)
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.purchasedCoins.first(where: { $0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice?.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals() )
            }
        }
        .animation(nil, value: UUID())
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
//        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show the checkmart
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // hdie keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    //    private func bookmarkButtonPressed() {
    //        guard let coin = selectedCoin else { return }
    //
    //        // save to bookmarks, isBookmarked: <#Bool#>
    //        //vm.updatePortfolio(coin: coin, amount: 0, isBookmarked: isBookmarked)
    //
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
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
}
































// this is it
/*
 //
 //  PortfolioView.swift
 //  Brypto
 //
 //  Created by Bruke on 6/19/22.
 //
 
 import SwiftUI
 
 struct PortfolioView: View {
 @EnvironmentObject private var vm: HomeViewModel
 @Environment(\.dismiss) var dismiss
 @State private var selectedCoin: CoinModel? = nil
 @State private var quantityText: String = ""
 @State private var showCheckMark: Bool = false
 //@State private var isBookmarked: Bool
 
 @State private var showEditPortfolioSheet = false
 @Binding var inPortfolioTab: Bool
 
 let columns = [
 GridItem(.flexible()),
 GridItem(.flexible()),
 GridItem(.flexible()),
 GridItem(.flexible())
 ]
 
 var body: some View {
 //NavigationView {
 VStack {
 homeHeader
 HomeStatsView(showPortfolio: .constant(true))
 .padding(.leading)
 SearchBarView(searchText: $vm.searchText)
 VStack {
 columnTitles
 coinRows
 //.listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
 }
 //            if selectedCoin != nil {
 //                portfolioInputSection
 //                    .padding(.bottom)
 //            }
 
 }
 .navigationBarHidden(true)
 .background(
 Color.theme.background
 .ignoresSafeArea()
 )
 .sheet(isPresented: $showEditPortfolioSheet) {
 EditPortfolioTabView()
 }
 //            .toolbar {
 //                ToolbarItem(placement: .navigationBarLeading) {
 //                    if !inPortfolioTab {
 //                        XMarkButton(dismiss: _dismiss)
 //                    }
 //                }
 //            }
 //            .toolbar {
 //                ToolbarItem(placement: .navigationBarTrailing) {
 //                    trailingNavBarButtons
 //                }
 //            }
 .onChange(of: vm.searchText) { newValue in
 if newValue == "" {
 removeSelectedCoin()
 }
 }
 //}
 }
 }
 
 struct PortfolioView_Previews: PreviewProvider {
 static var previews: some View {
 EditPortfolioTabView()
 .environmentObject(dev.homeVM)
 }
 }
 
 extension PortfolioView {
 private var homeHeader: some View {
 HStack {
 //                CircleButtonView(iconName: "plus")
 //                    .animation(nil, value: UUID())
 //                    .onTapGesture {
 //                        showEditPortfolioSheet = true
 //                    }
 //                Spacer()
 Text("Portfolio")
 .font(.headline)
 .fontWeight(.heavy)
 .foregroundColor(Color.theme.accent)
 .padding()
 //                Spacer()
 //                Spacer()
 }
 .padding(.horizontal)
 //.frame(height: 75)
 }
 
 private var coinRows: some View {
 List {
 ForEach(vm.searchText.isEmpty ? vm.purchasedCoins : vm.allCoins) { coin in
 CoinRowView(coin: coin, showHoldingsColumn: true)
 .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
 .listRowBackground(Color.theme.background)            }
 //        LazyVGrid(columns: columns, spacing: 10, pinnedViews: [.sectionHeaders]) {
 //            Section {
 //                ForEach(vm.searchText.isEmpty ? vm.purchasedCoins : vm.allCoins) { coin in
 //                    CoinLogoView(coin: coin)
 //                        .frame(width: 75)
 //                        .padding(4)
 //                        .onTapGesture {
 //                            withAnimation(.easeIn) {
 //                                updateSelectedCoin(coin: coin)
 //                            }
 //                        }
 //                        .background(
 //                            RoundedRectangle(cornerRadius: 10)
 //                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear, lineWidth: 1)
 //                        )
 //                }
 //            } header: {
 //                Text(vm.searchText.isEmpty ? "Holdings" : "Select a coin")
 //                    .font(.headline.bold())
 //                    .padding()
 //            }
 
 //            Section {
 //                ForEach(vm.bookmaredCoins) { coin in
 //                    if coin.isBookmarked ?? false {
 //                        CoinLogoView(coin: coin)
 //                            .frame(width: 75)
 //                            .padding(4)
 //                            .onTapGesture {
 //                                withAnimation(.easeIn) {
 //                                    updateSelectedCoin(coin: coin)
 //                                }
 //                            }
 //                            .background(
 //                                RoundedRectangle(cornerRadius: 10)
 //                                    .stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear, lineWidth: 1)
 //                            )
 //                    }
 //                }
 //            } header: {
 //                Text("Bookmarked")
 //                    .font(.headline.bold())
 //                    .padding()
 //            }
 }
 .listStyle(.plain)
 //.frame(height: 120)
 //.padding(.leading)
 }
 
 private var columnTitles: some View {
 HStack {
 HStack(spacing: 4) {
 Text("Coin")
 Image(systemName: "chevron.down")
 .opacity( (vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0 )
 .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0.0 : 180))
 }
 .onTapGesture {
 withAnimation(.default) {
 vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
 }
 }
 
 Spacer()
 HStack(spacing: 4) {
 Text("Holdings")
 Image(systemName: "chevron.down")
 .opacity( (vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0 )
 .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0.0 : 180))
 }
 .onTapGesture {
 withAnimation(.default) {
 vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
 }
 }
 
 HStack(spacing: 4) {
 Text("Price")
 Image(systemName: "chevron.down")
 .opacity( (vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0 )
 .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0.0 : 180))
 }
 .frame(width: UIScreen.main.bounds.width / 5.0, alignment: .trailing)
 .onTapGesture {
 withAnimation(.default) {
 vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
 }
 }
 
 Button {
 withAnimation(.linear(duration: 2.0)) {
 vm.reloadData()
 }
 } label: {
 Image(systemName: "goforward")
 }
 .rotationEffect(Angle(degrees: vm.isLoading ? 360.0 : 0.0), anchor: .center)
 }
 .font(.caption)
 .foregroundColor(Color.theme.secondaryText)
 .padding(.horizontal)
 }
 
 private func updateSelectedCoin(coin: CoinModel) {
 selectedCoin = coin
 
 if let portfolioCoin = vm.purchasedCoins.first(where: { $0.id == coin.id}),
 let amount = portfolioCoin.currentHoldings {
 quantityText = "\(amount)"
 } else {
 quantityText = ""
 }
 }
 
 private func getCurrentValue() -> Double {
 if let quantity = Double(quantityText) {
 return quantity * (selectedCoin?.currentPrice ?? 0)
 }
 return 0
 }
 
 private var portfolioInputSection: some View {
 VStack(spacing: 20) {
 HStack {
 Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
 Spacer()
 Text(selectedCoin?.currentPrice?.asCurrencyWith6Decimals() ?? "")
 }
 Divider()
 HStack {
 Text("Amount holding:")
 Spacer()
 TextField("Ex: 1.4", text: $quantityText)
 .multilineTextAlignment(.trailing)
 .keyboardType(.decimalPad)
 }
 Divider()
 HStack {
 Text("Current value:")
 Spacer()
 Text(getCurrentValue().asCurrencyWith2Decimals() )
 }
 }
 .animation(nil, value: UUID())
 .padding()
 .font(.headline)
 }
 
 private var trailingNavBarButtons: some View {
 HStack(spacing: 10) {
 Image(systemName: "checkmark")
 .opacity(showCheckMark ? 1.0 : 0.0)
 
 Button {
 saveButtonPressed()
 } label: {
 Text("Save".uppercased())
 }
 .opacity(
 (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
 )
 }
 .font(.headline)
 }
 
 private func saveButtonPressed() {
 guard
 let coin = selectedCoin,
 let amount = Double(quantityText)
 else { return }
 
 // save to portfolio
 //vm.updatePortfolio(coin: coin, amount: amount, isBookmarked: )
 
 // show the checkmart
 withAnimation(.easeIn) {
 showCheckMark = true
 removeSelectedCoin()
 }
 
 // hdie keyboard
 UIApplication.shared.endEditing()
 
 // hide checkmark
 DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
 withAnimation(.easeOut) {
 showCheckMark = false
 }
 }
 }
 
 //    private func bookmarkButtonPressed() {
 //        guard let coin = selectedCoin else { return }
 //
 //        // save to bookmarks, isBookmarked: <#Bool#>
 //        //vm.updatePortfolio(coin: coin, amount: 0, isBookmarked: isBookmarked)
 //
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
 
 private func removeSelectedCoin() {
 selectedCoin = nil
 vm.searchText = ""
 }
 }
 
 */
