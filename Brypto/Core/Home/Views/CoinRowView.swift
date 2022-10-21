//
//  CoinRowView.swift
//  Brypto
//
//  Created by Bruke on 6/11/22.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    let showRank: Bool
    let showChart: Bool
    
    init(coin: CoinModel, showHoldingsColumn: Bool, showRank: Bool = true, showChart: Bool = true) {
        self.coin = coin
        self.showHoldingsColumn = showHoldingsColumn
        self.showRank = showRank
        self.showChart = showChart
    }
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
//            if showChart {
//                chartView
//                    //.padding(.leading)
//                    .padding(.horizontal)
//                    .padding(.horizontal)
//                    //.padding(.horizontal)
//            }
//            if !showChart {
//                Spacer()
//            }
            Spacer()
//            if showHoldingsColumn {
//                centerColumn
//                Spacer()
//            }
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            if !showRank {
                Text(" ")
                    .frame(minWidth: 10)
            }
            
            if showRank {
                Text("\(coin.rank)")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                    .frame(minWidth: 30)
            }
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
//            if !showRank {
//                Spacer()
//            }
            
            VStack(alignment: .leading) {
                Text(showHoldingsColumn ? coin.symbol.uppercased() : coin.name)
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                Text(showHoldingsColumn ? "\((coin.currentHoldings ?? 0).asNumberString()) shares" : coin.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(Color.theme.secondaryText)
            }
            .lineLimit(1)
            .padding(.leading, 5)
        }
        .frame(width: showHoldingsColumn ? UIScreen.main.bounds.width / 2.5 : UIScreen.main.bounds.width / 2.5, alignment: .leading)
    }
    
//    private var chartView: some View {
//        ChartViewMinimal(coin: coin)
//    }
    
//    private var centerColumn: some View {
//        VStack {
//            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
//                .bold()
//        }
//        .foregroundColor(Color.theme.accent)
//    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "N/A")
                .bold()
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.accentMain :
                        Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 4.75, alignment: .trailing)
    }
}
