//
//  EditPortfolioTabView.swift
//  Brypto
//
//  Created by Bruke on 9/1/22.
//

import SwiftUI

struct EditPortfolioTabView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    //@Binding var isBookmarked: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBarView(searchText: $vm.searchText)
                ScrollView {
                    coinLogoList
                        .offset(y: 55)
                }
                if selectedCoin != nil {
                    portfolioInputSection
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

//struct EditPortfolioTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPortfolioTabView()
//            .environmentObject(dev.homeVM)
//    }
//}

extension EditPortfolioTabView {
    private var coinLogoList: some View {
        LazyVGrid(columns: columns, spacing: 10, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(vm.searchText.isEmpty ? vm.purchasedCoins : vm.allCoins) { coin in
                        CoinLogoView(coin: coin)
                            .frame(width: 75)
                            .padding(4)
                            .onTapGesture(count: 2) {
                                removeSelectedCoin()
                            }
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    updateSelectedCoin(coin: coin)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear, lineWidth: 1)
                            )
                    }
                } header: {
                    Text(vm.searchText.isEmpty ? "Holdings" : "Select a coin")
                        .font(.headline.bold())
                }
            }
            .frame(height: 120)
            .padding(.leading)
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
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(nil, value: UUID())
        .padding()
        .font(.headline)
        .foregroundColor(.black)
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
//        guard
//            let coin = selectedCoin,
//            let amount = Double(quantityText)
//        else { return }
        
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
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
