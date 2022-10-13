//
//  SellInputSection.swift
//  Brypto
//
//  Created by Bruke on 10/1/22.
//

import SwiftUI

struct SellInputSection: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    //@Environment(\.dismiss) var dismiss
    //@State private var selectedCoin: CoinModel? = nil
//    @State private var dollarAmount: String = ""
//    @State private var totalDollarAmount: Double = 0
    @State private var showCheckMark: Bool = false
    //@Binding var showPortfolioInput: Bool
    
    //@Binding var buyButtonPressed: Bool
    //@Binding var showPortfolioInputSection: Bool
    @AppStorage("totalDollarAmountInPortfolio") var totalDollarAmountInPortfolio: Double = 0
    
//    @Binding var showBuyView: Bool
//    @Binding var showSellView: Bool
    
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
                sellButton
            }
            .onChange(of: vm.dollarAmount, perform: { _ in
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
            .onAppear {
                vm.dollarAmount = ""
            }
        }
        //        .background(
        //            RoundedRectangle(cornerRadius: 10)
        //                .fill(.white)
        //        )
    }
}


//struct BuyInputSection_Previews: PreviewProvider {
//    static var previews: some View {
//        SellInputSection(coin: dev.coin)
//    }
//}

extension SellInputSection {
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
                Text("Sell")
                //.font(.title.bold())
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                Text((vm.dollarAmount.isEmpty ? "$0" : "$" + (Double(vm.dollarAmount)?.commaSeperatedWith2Decimals() ?? "$0")) )
                //                .font(.largeTitle.bold())
                    .font(.system(size: 75, weight: .bold, design: .rounded))
                    .padding(.bottom)
                //Divider()
                HStack {
                    VStack {
                        Text("Sell all")
                        Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                    }
                        .onTapGesture {
                            vm.dollarAmount = String(coin.currentHoldingsValue)
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
                        vm.dollarAmount.append("1")
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
                        vm.dollarAmount.append("2")
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
                        vm.dollarAmount.append("3")
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
                        vm.dollarAmount.append("4")
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
                        vm.dollarAmount.append("5")
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
                        vm.dollarAmount.append("6")
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
                        vm.dollarAmount.append("7")
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
                        vm.dollarAmount.append("8")
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
                        vm.dollarAmount.append("9")
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
                        vm.dollarAmount.append(".")
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
                        vm.dollarAmount.append("0")
                    }
                Spacer()
                Image(systemName: "arrow.backward")
                    .font(.footnote.bold())
                    .padding(.horizontal)
                    .scaleEffect(animateArrow ? 3 : 1)
                    .onTapGesture {
                        if !vm.dollarAmount.isEmpty {
                            withAnimation(.spring()) {
                                animateArrow = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                withAnimation(.spring()) {
                                    animateArrow = false
                                }
                            }
                            vm.dollarAmount.removeLast()
                        }
                    }
            }
            .padding()
        }
        .font(.title2.bold())
        .padding()
    }
    
    private var sellButton: some View {
        Button {
            sellButtonPressed()
            vm.totalDollarAmountInPortfolio = 0
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
        .disabled(vm.dollarAmount.isEmpty || Double(vm.dollarAmount) == 0)
        .opacity(vm.dollarAmount.isEmpty || Double(vm.dollarAmount) == 0 ? 0.75 : 1)
    }
    
//    private func buyButtonPressed() {
//        guard let currentPrice = coin.currentPrice else { return }
//
//        let amountOfShares = (Double(vm.dollarAmount) ?? 0) / currentPrice
//
//        vm.totalDollarAmountInPortfolio += (Double(vm.dollarAmount) ?? 0)
//
//        // save to portfolio
//        //        vm.updatePortfolio(coin: coin, amount: amountOfShares)
//        vm.buyCoin(coin: coin, amount: amountOfShares)
//
//        // show the checkmart
//        withAnimation(.easeIn) {
//            showCheckMark = true
//            //removeSelectedCoin()
//        }
//
//        // hdie keyboard
//        UIApplication.shared.endEditing()
//
//        // hide checkmark
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            withAnimation(.easeOut) {
//                showCheckMark = false
//                //showPortfolioInputSection = false
//                vm.dollarAmount = ""
//            }
//        }
//    }
    
    private func sellButtonPressed() {
        guard let currentPrice = coin.currentPrice else { return }

        let amountOfShares = (Double(vm.dollarAmount) ?? 0) / currentPrice
        
        totalDollarAmountInPortfolio -= Double(vm.dollarAmount) ?? 0
        vm.buyingPower += Double(vm.dollarAmount) ?? 0
        

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
                vm.dollarAmount = ""
            }
        }
    }
    
    private func getAmountOfShares() -> Double {
        if let dollarAmount = Double(vm.dollarAmount) {
            return dollarAmount / (coin.currentPrice ?? 0)
        }
        return 0
    }
    
    private func updateDollarAmount() {
        if vm.dollarAmount.count > 1 && vm.dollarAmount.first == "0" && !vm.dollarAmount.contains(".") {
            vm.dollarAmount.removeFirst()
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
