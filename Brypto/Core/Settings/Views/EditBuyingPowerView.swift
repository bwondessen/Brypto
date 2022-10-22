//
//  EditBuyingPowerView.swift
//  Brypto
//
//  Created by Bruke on 10/12/22.
//

import SwiftUI

struct EditBuyingPowerView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    //    //@Environment(\.dismiss) var dismiss
    //    //@State private var selectedCoin: CoinModel? = nil
    //    //    @State private var dollarAmount: String = ""
    //    //    @State private var totalDollarAmount: Double = 0
    @State private var showCheckMark: Bool = false
    //    //@Binding var showPortfolioInput: Bool
    //
    //    //@Binding var buyButtonPressed: Bool
    //    //@Binding var showPortfolioInputSection: Bool
    //
    //    //    @Binding var showBuyView: Bool
    //    //    @Binding var showSellView: Bool
    //
    
    @State private var animateOne: Bool = false
    @State private var animateTwo: Bool = false
    @State private var animateThree: Bool = false
    @State private var animateFour: Bool = false
    @State private var animateFive: Bool = false
    @State private var animateSix: Bool = false
    @State private var animateSeven: Bool = false
    @State private var animateEight: Bool = false
    @State private var animateNine: Bool = false
    @State private var animateTheDot: Bool = false
    @State private var animateZero: Bool = false
    @State private var animateTheArrow: Bool = false
    
    var body: some View {
            VStack {
                Spacer()
                inputSection
                numberPad
                confirmButton
                    .padding(.bottom)
                    .padding(.bottom)
            }
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
                vm.buyingAmount = ""
            }
        //        .onChange(of: vm.dollarAmount, perform: { _ in
        //            updateDollarAmount()
        //        })
        //        .toolbar {
        //            ToolbarItem(placement: .navigationBarLeading) {
        //                Image(systemName: "arrow.backward")
        //                    .font(.title2.bold())
        //                    .onTapGesture {
        //                        dismiss()
        //                    }
        //            }
        //        }
        //        .onAppear {
        //            vm.buyingAmount = ""
        //        }
        //        //        .background(
        //        //            RoundedRectangle(cornerRadius: 10)
        //        //                .fill(.white)
        //        //        )
    }
}


//struct BuyInputSection_Previews: PreviewProvider {
//    static var previews: some View {
//        SellInputSection(coin: dev.coin)
//    }
//}

extension EditBuyingPowerView {
    private var inputSection: some View {
        VStack {
            VStack {
                Text("Buying Power")
                //.font(.title.bold())
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                Text((vm.buyingAmount.isEmpty ? "$0" : "$" + (Double(vm.buyingAmount)?.commaSeperatedWith2Decimals() ?? "$0")) )
                //                .font(.largeTitle.bold())
                    .font(.system(size: 75, weight: .bold, design: .rounded))
                    .padding(.bottom)
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
    //
    private var numberPad: some View {
        VStack {
            //            CoinRowView(coin: coin, showHoldingsColumn: false, showRank: false, showChart: false)
            //                .frame(height: 75)
            
            HStack {
                Text("1")
                    .padding(.horizontal)
                    .scaleEffect(animateOne ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateOne = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateOne = false
                            }
                        }
                        vm.buyingAmount.append("1")
                    }
                Spacer()
                Text("2")
                    .padding(.horizontal)
                    .scaleEffect(animateTwo ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateTwo = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateTwo = false
                            }
                        }
                        vm.buyingAmount.append("2")
                    }
                Spacer()
                Text("3")
                    .padding(.horizontal)
                    .scaleEffect(animateThree ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateThree = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateThree = false
                            }
                        }
                        vm.buyingAmount.append("3")
                    }
            }
            .padding()
            HStack {
                Text("4")
                    .padding(.horizontal)
                    .scaleEffect(animateFour ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateFour = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateFour = false
                            }
                        }
                        vm.buyingAmount.append("4")
                    }
                Spacer()
                Text("5")
                    .padding(.horizontal)
                    .scaleEffect(animateFive ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateFive = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateFive = false
                            }
                        }
                        vm.buyingAmount.append("5")
                    }
                Spacer()
                Text("6")
                    .padding(.horizontal)
                    .scaleEffect(animateSix ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateSix = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateSix = false
                            }
                        }
                        vm.buyingAmount.append("6")
                    }
            }
            .padding()
            HStack {
                Text("7")
                    .padding(.horizontal)
                    .scaleEffect(animateSeven ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateSeven = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateSeven = false
                            }
                        }
                        vm.buyingAmount.append("7")
                    }
                Spacer()
                Text("8")
                    .padding(.horizontal)
                    .scaleEffect(animateEight ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateEight = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateEight = false
                            }
                        }
                        vm.buyingAmount.append("8")
                    }
                Spacer()
                Text("9")
                    .padding(.horizontal)
                    .scaleEffect(animateNine ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateNine = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateNine = false
                            }
                        }
                        vm.buyingAmount.append("9")
                    }
            }
            .padding()
            HStack {
                Text(".  ")
                    .padding(.horizontal)
                    .scaleEffect(animateTheDot ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateTheDot = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateTheDot = false
                            }
                        }
                        vm.buyingAmount.append(".")
                    }
                Spacer()
                Text("0")
                    .padding(.horizontal)
                    .scaleEffect(animateZero ? 3 : 1)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            animateZero = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.spring()) {
                                animateZero = false
                            }
                        }
                        vm.buyingAmount.append("0")
                    }
                Spacer()
                Image(systemName: "arrow.backward")
                    .font(.footnote.bold())
                    .padding(.horizontal)
                    .scaleEffect(animateTheArrow ? 3 : 1)
                    .onTapGesture {
                        if !vm.dollarAmount.isEmpty {
                            withAnimation(.spring()) {
                                animateTheArrow = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                withAnimation(.spring()) {
                                    animateTheArrow = false
                                }
                            }
                            vm.buyingAmount.removeLast()
                        }
                    }
            }
            .padding()
        }
        .font(.title2.bold())
        .padding()
    }
    //
    private var confirmButton: some View {
        Button {
            confirmButtonPressed()
        } label: {
            Text("Confirm")
                .font(.headline.bold())
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.theme.accentMain)
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .disabled(vm.buyingAmount.isEmpty || Double(vm.buyingAmount) == 0)
        .opacity(vm.buyingAmount.isEmpty || Double(vm.buyingAmount) == 0 ? 0.75 : 1)
    }
    //
    private func confirmButtonPressed() {
        //guard let currentPrice = coin.currentPrice else { return }
        
        //let amountOfShares = (Double(vm.dollarAmount) ?? 0) / currentPrice
        
        //vm.totalDollarAmountInPortfolio += (Double(vm.dollarAmount) ?? 0)
        vm.buyingPower = (Double(vm.buyingAmount) ?? 0)
        
        // save to portfolio
        //        vm.updatePortfolio(coin: coin, amount: amountOfShares)
        //vm.buyCoin(coin: coin, amount: amountOfShares)
        
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
                //vm.buyingAmount = ""
            }
        }
    }
    //
    //    //    private func sellButtonPressed() {
    //    //        guard let currentPrice = coin.currentPrice else { return }
    //    //
    //    //        let amountOfShares = (Double(vm.dollarAmount) ?? 0) / currentPrice
    //    //
    //    //        // save to portfolio
    //    //        //        vm.updatePortfolio(coin: coin, amount: amountOfShares)
    //    //        vm.sellCoin(coin: coin, amount: amountOfShares)
    //    //
    //    //        // show the checkmart
    //    //        withAnimation(.easeIn) {
    //    //            showCheckMark = true
    //    //            //removeSelectedCoin()
    //    //        }
    //    //
    //    //        // hdie keyboard
    //    //        UIApplication.shared.endEditing()
    //    //
    //    //        // hide checkmark
    //    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    //    //            withAnimation(.easeOut) {
    //    //                showCheckMark = false
    //    //                //showPortfolioInputSection = false
    //    //                vm.dollarAmount = ""
    //    //            }
    //    //        }
    //    //    }
    //
    //    //    private func getAmountOfShares() -> Double {
    //    //        if let dollarAmount = Double(vm.dollarAmount) {
    //    //            return dollarAmount / (coin.currentPrice ?? 0)
    //    //        }
    //    //        return 0
    //    //    }
    //
    //    private func updateDollarAmount() {
    //        if vm.dollarAmount.count > 1 && vm.dollarAmount.first == "0" && !vm.dollarAmount.contains(".") {
    //            vm.dollarAmount.removeFirst()
    //        }
    //    }
    //
    //    //    private func getCurrentValue() -> Double {
    //    //        if let quantity = Double(dollarAmount) {
    //    //            return quantity * (coin.currentPrice ?? 0)
    //    //        }
    //    //        return 0
    //    //    }
    //
    //    //    private func removeSelectedCoin() {
    //    //        coin = nil
    //    //        vm.searchText = ""
    //    //    }
}
