//
//  ChartViewMinimal.swift
//  Brypto
//
//  Created by Bruke on 8/29/22.
//

import SwiftUI

struct ChartViewMinimal: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    @State var percentage: CGFloat = 0
    
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange >= 0 ? Color.theme.accentMain : Color.theme.red
    }
    
    var body: some View {
        VStack {
            chartViewMinimal
            //.frame(height: 200)
            //.overlay(chartYAxis.padding(.horizontal, 4)
            //,alignment: .leading)
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView(coin: dev.coin, showPortfoliInputSection: .constant(true))
//    }
//}

extension ChartViewMinimal {
    private var chartViewMinimal: some View {
        GeometryReader { geo in
            Path { path in
                for index in data.indices {
                    let xPosition = geo.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat(data[index] - minY) / yAxis) * geo.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            //.shadow(color: lineColor, radius: 10, x: 0, y: 10)
            //.shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            //.shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            //.shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
}
