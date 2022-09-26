////
////  BuyAndSellView.swift
////  Brypto
////
////  Created by Bruke on 9/22/22.
////
//
//import SwiftUI
//
//struct BuyAndSellView: View {
//    @Environment(\.dismiss) private var dissmiss
//    @Binding var showBuyView: Bool
//    @Binding var showSellView: Bool
//
//    let coin: CoinModel
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if showBuyView {
//                    VStack {
//                        PortfolioInputSection(buyButtonPressed: $showBuyView, showPortfolioInputSection: $showSellView, coin: coin)
//                    }
//
//                } else {
//
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Image(systemName: "arrow.backward")
//                        .font(.headline.bold())
//                }
//            }
//        }
//    }
//}
//
//struct BuyAndSellView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuyAndSellView(showBuyView: .constant(true), showSellView: .constant(false), coin: dev.coin)
//    }
//}
