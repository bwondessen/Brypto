//
//  PortfolioChartView.swift
//  Brypto
//
//  Created by Bruke on 9/14/22.
//

import SwiftUI

struct PortfolioChartView: View {
    private var vm: HomeViewModel = HomeViewModel()
    
    //private let data: [Double]
    private var data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0

    let coins: [CoinModel]
    
    init(purchasedCoins: [CoinModel], showPortfoliInputSection: Bool) {
        self.coins = purchasedCoins
        //data = coins.sparklineIn7D?.price ?? []
        //data = purchasedCoins.map { $0.currentHoldingsValue ?? 0 }
//        data = [10, 5, 18, 13, 27, 40, 31, 55, 73, 67, 81, 90, 72, 103, 95, 103, 99, 115, 107, 155]
        data = vm.priceChanges.map { Double($0) ?? 0 }
//        let combined = purchasedCoins.map { $0.sparklineIn7D?.price ?? [0] }
//        let combined = purchasedCoins.map { $0.priceChanges }
////
//        func averageByIndex(elms:[[Double]]) -> [Double]? {
//            guard let length = elms.first?.count else { return []}
//
//            // check all the elements have the same length, otherwise returns nil
//            guard !elms.contains(where:{ $0.count != length }) else { return nil }
//
//            return (0..<length).map { index in
//                let sum = elms.map { $0[index] }.reduce(0, +)
//                return sum / Double(elms.count)
//            }
//        }
//
//        data = averageByIndex(elms: combined) ?? []
        
//        let combined = purchasedCoins.map { $0.sparklineIn7D?.price ?? [0] }
//
//        //vm.averageByIndex(elms: combined)
//
//        if let averages = vm.averageByIndex(elms: combined) {
//            //print(averages) // [4.0, 4.0, 6.666666666666667]
//            data = averages
//        }
        
        //let totalValue = data.reduce(0, +)
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        //let priceChange = (totalValue) - (totalValue - (data.last ?? 0))
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        //endingDate = Date(coinGeckoString: coins.lastUpdated ?? "")
        endingDate = Date()
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            portfolioChartView
                .frame(height: 200)
                .background(portfolioChartBackground)
                .overlay(porftolioChartYAxis.padding(.horizontal, 4)
                         ,alignment: .leading)
            
            VStack(alignment: .trailing) {
                portflioChartDateLabels
                    .padding(.horizontal, 4)
            }
            .padding(.bottom)
            
            HStack {
                Text("Buying Power")
                    .font(.headline)
                    .foregroundColor(Color.theme.secondaryText)
                Spacer()
                Text(vm.buyingPower.asCurrencyWith2Decimals())
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
            }
        }
//        .sheet(isPresented: $showPortfolioInputSection) {
//            PortfolioInputSection()
//        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .navigationBarHidden(true)
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

extension PortfolioChartView {
    private var portfolioChartView: some View {
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
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var portfolioChartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var porftolioChartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var portflioChartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
