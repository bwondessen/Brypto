//
//  PortfolioInputSection.swift
//  Brypto
//
//  Created by Bruke on 9/5/22.
//

import SwiftUI

struct PortfolioInputSection: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    //@Environment(\.dismiss) var dismiss
    //@State private var selectedCoin: CoinModel? = nil
    @State private var dollarAmount: String = ""
    @State private var showCheckMark: Bool = false
    //@Binding var showPortfolioInput: Bool
    
    //@Binding var buyButtonPressed: Bool
    //@Binding var showPortfolioInputSection: Bool
    
    @Binding var showBuyView: Bool
    @Binding var showSellView: Bool
    
    @State private var animate1: Bool = false
    @State private var animate2: Bool = false
    @State private var animate3: Bool = false
    @State private var animate4: Bool = false
    @State private var animate5: Bool = false
    @State private var animate6: Bool = false
    @State private var animate7: Bool = false
    @State private var animate8: Bool = false
    @State private var animate9: Bool = false
    @State private var animateDot: Bool = false
    @State private var animate0: Bool = false
    @State private var animateArrow: Bool = false
    
    //    @State private var buyButtonPressed: Bool = false
    
    let coin: CoinModel
    
    var body: some View {
        NavigationView {
            VStack {
                inputSection
                numberPad
                buyOrSellButton
            }
            .onChange(of: dollarAmount, perform: { _ in
                updateDollarAmount()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "arrow.backward")
                        .font(.title2.bold())
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
        //        .background(
        //            RoundedRectangle(cornerRadius: 10)
        //                .fill(.white)
        //        )
    }
}


struct PortfolioInputSection_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioInputSection(showBuyView: .constant(true), showSellView: .constant(false), coin: dev.coin)
    }
}

extension PortfolioInputSection {
    //    private var trailingNavBarButtons: some View {
    //        VStack {
    ////            Rectangle()
    ////                .frame(height: 2)
    //
    //            HStack(spacing: 10) {
    //                Image(systemName: "checkmark")
    //                    .opacity(showCheckMark ? 1.0 : 0.0)
    //                .opacity(
    //                    (showBuyView != false && coin.currentHoldings != Double(dollarAmount)) ? 1.0 : 0.0
    //                )
    //            }
    //            .font(.headline)
    //        }
    //    }
    
    private var inputSection: some View {
        VStack {
            VStack {
                Text(showBuyView ? "Buy" : "Sell")
                //.font(.title.bold())
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                Text((dollarAmount.isEmpty ? "$0" : "$" + (Double(dollarAmount)?.commaSeperatedWith2Decimals() ?? "$0")) )
                //                .font(.largeTitle.bold())
                    .font(.system(size: 75, weight: .bold, design: .rounded))
                    .padding(.bottom)
                //Divider()
                HStack {
                    VStack {
                        Text(showSellView ? "Sell all" : "")
                        Text(showSellView ? "-\(coin.currentHoldingsValue.asCurrencyWith2Decimals())-" : "")
                    }
                        .onTapGesture {
                            dollarAmount = String(coin.currentHoldingsValue)
                        }
                    Spacer()
                }
                .overlay(
                    HStack {
                        Text("Shares:")
                        Text((getAmountOfShares().asNumberString()))
                    }
                        .foregroundColor(Color.theme.secondaryText)
                )
            }
            .overlay(
                VStack {
                    Image(systemName: "checkmark")
                        .font(.title.bold())
                        .padding()
                        .opacity(showCheckMark ? 1.0 : 0.0)
                    Spacer()
                }
                    .frame(height: UIScreen.main.bounds.width)
            )
        }
        .animation(nil, value: UUID())
        .padding()
        .font(.headline)
        .foregroundColor(.black)
        
    }
    
    private var numberPad: some View {
        VStack {
            CoinRowView(coin: coin, showHoldingsColumn: false, showRank: false, showChart: false)
                .frame(height: 75)
            
            HStack {
                Text("1")
                    .padding(.horizontal)
                    .scaleEffect(animate1 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate1 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate1 = false
                            }
                        }
                        dollarAmount.append("1")
                    }
                Spacer()
                Text("2")
                    .padding(.horizontal)
                    .scaleEffect(animate2 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate2 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate2 = false
                            }
                        }
                        dollarAmount.append("2")
                    }
                Spacer()
                Text("3")
                    .padding(.horizontal)
                    .scaleEffect(animate3 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate3 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate3 = false
                            }
                        }
                        dollarAmount.append("3")
                    }
            }
            .padding()
            HStack {
                Text("4")
                    .padding(.horizontal)
                    .scaleEffect(animate4 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate4 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate4 = false
                            }
                        }
                        dollarAmount.append("4")
                    }
                Spacer()
                Text("5")
                    .padding(.horizontal)
                    .scaleEffect(animate5 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate5 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate5 = false
                            }
                        }
                        dollarAmount.append("5")
                    }
                Spacer()
                Text("6")
                    .padding(.horizontal)
                    .scaleEffect(animate6 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate6 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate6 = false
                            }
                        }
                        dollarAmount.append("6")
                    }
            }
            .padding()
            HStack {
                Text("7")
                    .padding(.horizontal)
                    .scaleEffect(animate7 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate7 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate7 = false
                            }
                        }
                        dollarAmount.append("7")
                    }
                Spacer()
                Text("8")
                    .padding(.horizontal)
                    .scaleEffect(animate8 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate8 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate8 = false
                            }
                        }
                        dollarAmount.append("8")
                    }
                Spacer()
                Text("9")
                    .padding(.horizontal)
                    .scaleEffect(animate9 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate9 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate9 = false
                            }
                        }
                        dollarAmount.append("9")
                    }
            }
            .padding()
            HStack {
                Text(".  ")
                    .padding(.horizontal)
                    .scaleEffect(animateDot ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateDot = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateDot = false
                            }
                        }
                        dollarAmount.append(".")
                    }
                Spacer()
                Text("0")
                    .padding(.horizontal)
                    .scaleEffect(animate0 ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animate0 = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animate0 = false
                            }
                        }
                        dollarAmount.append("0")
                    }
                Spacer()
                Image(systemName: "arrow.backward")
                    .font(.footnote.bold())
                    .padding(.horizontal)
                    .scaleEffect(animateArrow ? 3 : 1)
                    .onTapGesture {
                        if !dollarAmount.isEmpty {
                            withAnimation(.spring()) {
                                animateArrow = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                withAnimation(.spring()) {
                                    animateArrow = false
                                }
                            }
                            dollarAmount.removeLast()
                        }
                    }
            }
            .padding()
        }
        .font(.title2.bold())
        .padding()
    }
    
    private var buyOrSellButton: some View {
        Button {
            if showBuyView {
                buyButtonPressed()
            } else {
                sellButtonPressed()
            }
        } label: {
            Text(showBuyView ? "Buy" : "Sell")
                .font(.headline.bold())
                .foregroundColor(Color("AccentColorReversed"))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.theme.accent)
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .disabled(dollarAmount.isEmpty || Double(dollarAmount) == 0)
        .opacity(dollarAmount.isEmpty || Double(dollarAmount) == 0 ? 0.75 : 1)
    }
    
    private func buyButtonPressed() {
        guard let currentPrice = coin.currentPrice else { return }
        
        let amountOfShares = (Double(dollarAmount) ?? 0) / currentPrice
        
        // save to portfolio
        //        vm.updatePortfolio(coin: coin, amount: amountOfShares)
        vm.buyCoin(coin: coin, amount: amountOfShares)
        
        // show the checkmart
        withAnimation(.easeIn) {
            showCheckMark = true
            //removeSelectedCoin()
        }
        
        // hdie keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
                //showPortfolioInputSection = false
                dollarAmount = ""
            }
        }
    }
    
    private func sellButtonPressed() {
        guard let currentPrice = coin.currentPrice else { return }
        
        let amountOfShares = (Double(dollarAmount) ?? 0) / currentPrice
        
        // save to portfolio
        //        vm.updatePortfolio(coin: coin, amount: amountOfShares)
        vm.sellCoin(coin: coin, amount: amountOfShares)
        
        // show the checkmart
        withAnimation(.easeIn) {
            showCheckMark = true
            //removeSelectedCoin()
        }
        
        // hdie keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
                //showPortfolioInputSection = false
                dollarAmount = ""
            }
        }
    }
    
    private func getAmountOfShares() -> Double {
        if let dollarAmount = Double(dollarAmount) {
            return dollarAmount / (coin.currentPrice ?? 0)
        }
        return 0
    }
    
    private func updateDollarAmount() {
        if dollarAmount.count > 1 && dollarAmount.first == "0" && !dollarAmount.contains(".") {
            dollarAmount.removeFirst()
        }
    }
    
    //    private func getCurrentValue() -> Double {
    //        if let quantity = Double(dollarAmount) {
    //            return quantity * (coin.currentPrice ?? 0)
    //        }
    //        return 0
    //    }
    
    //    private func removeSelectedCoin() {
    //        coin = nil
    //        vm.searchText = ""
    //    }
}
