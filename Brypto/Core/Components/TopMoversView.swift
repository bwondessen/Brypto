//
//  TopMoversView.swift
//  Brypto
//
//  Created by Bruke on 9/14/22.
//

import SwiftUI

struct TopMoversView: View {
    let coin: CoinModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                CoinImageView(coin: coin)
                    .frame(width: 30, height: 30)
                Spacer()
            }
            
            HStack {
                Text(coin.name)
                    .font(.subheadline.bold())
                        .foregroundColor(Color.theme.accent)
                    .lineLimit(1)
            }
            
            HStack {
                Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "N/A")
                    .font(.subheadline.bold())
                    .foregroundColor(Color.theme.secondaryText)
                Group {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(Angle(degrees: (coin.priceChangePercentage24H ?? 0) >= 0 ? 0 : 180))
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                }
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.theme.accent, lineWidth: 0.25)
        )
    }
}

struct TopMoversView_Previews: PreviewProvider {
    static var previews: some View {
        TopMoversView(coin: dev.coin)
    }
}
