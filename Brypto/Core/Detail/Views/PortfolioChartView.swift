//
//  PortfolioChartView.swift
//  Brypto
//
//  Created by Bruke on 9/14/22.
//

import SwiftUI

struct PortfolioChartView: View {
    //private var vm: HomeViewModel = HomeViewModel()
    @EnvironmentObject var vm: HomeViewModel
    
    //private let data: [Double]
    //private var data: [Double]
    //    private let maxY: Double
    //    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    let coins: [CoinModel]
    
    
    //    var past24hrs: [String] {
    //        var pastDayData: [String] = []
    //
    //        for i in 0..<(vm.priceDates?.count ?? 0) {
    //            if (vm.priceDates?[i].timeIntervalSinceNow ?? 0) <= 3_600 {
    //                pastDayData.append(vm.priceChanges[i])
    //            }
    //        }
    //
    //        return pastDayData
    //    }
    
    func pastTotalData(priceDates: [Date]) -> [Double] {
        //        var pastTotal: [Double] = []
        //
        //        for i in 0..<priceDates.count {
        //            if abs(priceDates[i].timeIntervalSinceNow) <= 86_400 * 7 {
        //                let price: Double = Double(vm.priceChanges[i]) ?? 0
        //                pastTotal.append(price)
        //            }
        //        }
        let totalData = vm.priceChanges.map { Double($0) ?? 0 }
        
        return totalData
    }
    
    func getMaxY() -> Double {
        if vm.pastDaySelected {
            return vm.pastDayData(priceDates: vm.priceDates ?? []).max() ?? 0
        } else if vm.pastWeekSelected {
            return vm.pastWeekData(priceDates: vm.priceDates ?? []).max() ?? 0
        } else if vm.pastMonthSelected {
            return vm.pastMonthData(priceDates: vm.priceDates ?? []).max() ?? 0
        } else if vm.past3MonthsSelected {
            return vm.past3MonthsData(priceDates: vm.priceDates ?? []).max() ?? 0
        } else if vm.pastYearSelected {
            return vm.pastYearData(priceDates: vm.priceDates ?? []).max() ?? 0
        } else {
            return vm.pastTotalData(priceDates: vm.priceDates ?? []).max() ?? 0
        }
    }
    
    func getMinY() -> Double {
        if vm.pastDaySelected {
            return vm.pastDayData(priceDates: vm.priceDates ?? []).min() ?? 0
        } else if vm.pastWeekSelected {
            return vm.pastWeekData(priceDates: vm.priceDates ?? []).min() ?? 0
        } else if vm.pastMonthSelected {
            return vm.pastMonthData(priceDates: vm.priceDates ?? []).min() ?? 0
        } else if vm.past3MonthsSelected {
            return vm.past3MonthsData(priceDates: vm.priceDates ?? []).min() ?? 0
        } else if vm.pastYearSelected {
            return vm.pastYearData(priceDates: vm.priceDates ?? []).min() ?? 0
        } else {
            return vm.pastTotalData(priceDates: vm.priceDates ?? []).min() ?? 0
        }
    }
        
        init(purchasedCoins: [CoinModel], showPortfoliInputSection: Bool) {
            self.coins = purchasedCoins
            //data = coins.sparklineIn7D?.price ?? []
            //data = purchasedCoins.map { $0.currentHoldingsValue ?? 0 }
            //        data = [10, 5, 18, 13, 27, 40, 31, 55, 73, 67, 81, 90, 72, 103, 95, 103, 99, 115, 107, 155]
            //        data = vm.priceChanges.map { Double($0) ?? 0 }
            //data = vm.pastDayData(priceDates: vm.priceDates ?? [])
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
            //        maxY = data.max() ?? 0
            //        maxY = pastDaySelected ? vm.pastDayData(priceDates: vm.priceDates ?? []).max() ?? 0 : (pastWeekSelected ? vm.pastWeekData(priceDates: vm.priceDates ?? []).max() ?? 0 : (pastMonthSelected ? vm.pastMonthData(priceDates: vm.priceDates ?? []).max() ?? 0 : (past3MonthsSelected ? vm.past3MonthsData(priceDates: vm.priceDates ?? []).max() ?? 0 : (pastYearSelected ? vm.pastYearData(priceDates: vm.priceDates ?? []).max() ?? 0) : vm.pastTotalData(priceDates: vm.priceDates ?? []).max() ?? 0))
            //        minY = data.min() ?? 0
            //        minY = vm.pastDayData(priceDates: vm.priceDates ?? []).min() ?? 0
            //        minY = pastDaySelected ? vm.pastDayData(priceDates: vm.priceDates ?? []).min() ?? 0 : (pastWeekSelected ? vm.pastWeekData(priceDates: vm.priceDates ?? []).min() ?? 0 : (pastMonthSelected ? vm.pastMonthData(priceDates: vm.priceDates ?? []).min() ?? 0 : (past3MonthsSelected ? vm.past3monthsData(priceDates: vm.priceDates ?? []).min() ?? 0 : (pastYearSelected ? vm.pastYearData(priceDates: vm.priceDates ?? []).min() ?? 0 : vm.pastTotalData(priceDates: vm.priceDates ?? [])))))
            
            //        let totalPriceChange = (data.last ?? 0) - (data.first ?? 0)
            //        let pastDayPriceChange = pastHour(priceDates: vm.priceDates ?? []).last ?? 0
            //        var pastDayPriceChange: Double {
            //            (pastDayData(priceDates: vm.priceDates ?? []).last ?? 0) - (pastDayData(priceDates: vm.priceDates ?? []).first ?? 0)
            //        }
            //
            //        var pastWeekPriceChange: Double {
            //            (pastWeekData(priceDates: vm.priceDates ?? []).last ?? 0) - (pastWeekData(priceDates: vm.priceDates ?? []).first ?? 0)
            //        }
            //
            //        var pastMonthPriceChange: Double {
            //            (pastMonthData(priceDates: vm.priceDates ?? []).last ?? 0) - (pastMonthData(priceDates: vm.priceDates ?? []).first ?? 0)
            //        }
            //
            //        var past3MonthsPriceChange: Double {
            //            (past3MonthsData(priceDates: vm.priceDates ?? []).last ?? 0) - (past3MonthsData(priceDates: vm.priceDates ?? []).first ?? 0)
            //        }
            //
            //        var pastYearPriceChange: Double {
            //            (pastYearData(priceDates: vm.priceDates ?? []).last ?? 0) - (pastYearData(priceDates: vm.priceDates ?? []).first ?? 0)
            //        }
            
            
            
            //let priceChange = (totalValue) - (totalValue - (data.last ?? 0))
            lineColor = Color.theme.green
            
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
                
                VStack {
                    //                portflioChartDateLabels
                    //                    .padding(.horizontal, 4)
                    
                    HStack(spacing: 10) {
                        Text("1D")
                            .padding(3)
                            .foregroundColor(vm.pastDaySelected ? .white : Color.theme.accent)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(vm.pastDaySelected ? Color.theme.green : .clear)
                            )
                            .onTapGesture {
                                vm.pastDaySelected = true
                                vm.pastWeekSelected = false
                                vm.pastMonthSelected = false
                                vm.past3MonthsSelected = false
                                vm.pastYearSelected = false
                                vm.pastTotalSelected = false
                            }
                        Spacer()
                        Text("1W")
                            .padding(3)
                            .foregroundColor(vm.pastWeekSelected ? .white : Color.theme.accent)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(vm.pastWeekSelected ? Color.theme.green : .clear)
                            )
                            .onTapGesture {
                                vm.pastDaySelected = false
                                vm.pastWeekSelected = true
                                vm.pastMonthSelected = false
                                vm.past3MonthsSelected = false
                                vm.pastYearSelected = false
                                vm.pastTotalSelected = false
                            }
                        Spacer()
                        Group {
                            Text("1M")
                                .padding(3)
                                .foregroundColor(vm.pastMonthSelected ? .white : Color.theme.accent)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(vm.pastMonthSelected ? Color.theme.green : .clear)
                                )
                                .onTapGesture {
                                    vm.pastDaySelected = false
                                    vm.pastWeekSelected = false
                                    vm.pastMonthSelected = true
                                    vm.past3MonthsSelected = false
                                    vm.pastYearSelected = false
                                    vm.pastTotalSelected = false
                                }
                            Spacer()
                            Text("3M")
                                .padding(3)
                                .foregroundColor(vm.past3MonthsSelected ? .white : Color.theme.accent)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(vm.past3MonthsSelected ? Color.theme.green : .clear)
                                )
                                .onTapGesture {
                                    vm.pastDaySelected = false
                                    vm.pastWeekSelected = false
                                    vm.pastMonthSelected = false
                                    vm.past3MonthsSelected = true
                                    vm.pastYearSelected = false
                                    vm.pastTotalSelected = false
                                }
                            Spacer()
                            Text("1Y")
                                .padding(3)
                                .foregroundColor(vm.pastYearSelected ? .white : Color.theme.accent)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(vm.pastYearSelected ? Color.theme.green : .clear)
                                )
                                .onTapGesture {
                                    vm.pastDaySelected = false
                                    vm.pastWeekSelected = false
                                    vm.pastMonthSelected = false
                                    vm.past3MonthsSelected = false
                                    vm.pastYearSelected = true
                                    vm.pastTotalSelected = false
                                }
                            Spacer()
                            Text("All")
                                .padding(3)
                                .foregroundColor(vm.pastTotalSelected ? .white : Color.theme.accent)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(vm.pastTotalSelected ? Color.theme.green : .clear)
                                )
                                .onTapGesture {
                                    vm.pastDaySelected = false
                                    vm.pastWeekSelected = false
                                    vm.pastMonthSelected = false
                                    vm.past3MonthsSelected = false
                                    vm.pastYearSelected = false
                                    vm.pastTotalSelected = true
                                }
                        }
                    }
                    .font(.footnote.bold())
                }
                .padding(.vertical)
                
                HStack {
                    Text("Buying Power")
                    //                Text("past day count: \(pastDayData(priceDates: vm.priceDates ?? []).count)")
                    //                Text("past week count: \(pastWeekData(priceDates: vm.priceDates ?? []).count)")
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
                    //                for index in data.indices {
                    //                    //let xPosition = geo.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    //                    let xPosition = geo.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    ////                    let xPosition = geo.size.width / CGFloat(pastDaySelected ? pastDayData(priceDates: vm.priceDates ?? []).count : (pastWeekSelected ? pastWeekData(priceDates: vm.priceDates ?? []).count : (pastMonthSelected ? pastMonthData(priceDates: vm.priceDates ?? []).count : (past3MonthsSelected ? past3MonthsData(priceDates: vm.priceDates ?? []).count : (pastYearSelected ? pastYearData(priceDates: vm.priceDates ?? []).count : pastYearData(priceDates: vm.priceDates ?? []).count))))) * CGFloat(index + 1)
                    ////                    let xPosition = geo.size.width / CGFloat(pastHourData(priceDates: vm.priceDates ?? []).count) * CGFloat(index + 1)
                    //
                    //                    let yAxis = maxY - minY
                    //
                    //                    let yPosition = (1 - CGFloat(data[index] - minY) / yAxis) * geo.size.height
                    //
                    //                    if index == 0 {
                    //                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    //                    }
                    //                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    //                }
                    
                    if vm.pastDaySelected {
                        for index in vm.pastDayData(priceDates: vm.priceDates ?? []).indices {
                            let xPosition = geo.size.width / CGFloat(vm.pastDayData(priceDates: vm.priceDates ?? []).count) * CGFloat(index + 1)
                            
                            let yAxis = (vm.pastDayData(priceDates: vm.priceDates ?? []).max() ?? 0) - (vm.pastDayData(priceDates: vm.priceDates ?? []).min() ?? 0)
                            
                            let yPosition = (1 - CGFloat(vm.pastDayData(priceDates: vm.priceDates ?? [])[index] - (vm.pastDayData(priceDates: vm.priceDates ?? []).min() ?? 0)) / yAxis) * geo.size.height
                            
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            }
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                    
                    if vm.pastWeekSelected {
                        for index in vm.pastWeekData(priceDates: vm.priceDates ?? []).indices {
                            let xPosition = geo.size.width / CGFloat(vm.pastWeekData(priceDates: vm.priceDates ?? []).count) * CGFloat(index + 1)
                            
                            let yAxis = (vm.pastWeekData(priceDates: vm.priceDates ?? []).max() ?? 0) - (vm.pastWeekData(priceDates: vm.priceDates ?? []).min() ?? 0)
                            
                            let yPosition = (1 - CGFloat(vm.pastWeekData(priceDates: vm.priceDates ?? [])[index] - (vm.pastWeekData(priceDates: vm.priceDates ?? []).min() ?? 0)) / yAxis) * geo.size.height
                            
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            }
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                    
                    if vm.pastMonthSelected {
                        for index in vm.pastMonthData(priceDates: vm.priceDates ?? []).indices {
                            let xPosition = geo.size.width / CGFloat(vm.pastMonthData(priceDates: vm.priceDates ?? []).count) * CGFloat(index + 1)
                            
                            let yAxis = (vm.pastMonthData(priceDates: vm.priceDates ?? []).max() ?? 0) - (vm.pastMonthData(priceDates: vm.priceDates ?? []).min() ?? 0)
                            
                            let yPosition = (1 - CGFloat(vm.pastMonthData(priceDates: vm.priceDates ?? [])[index] - (vm.pastMonthData(priceDates: vm.priceDates ?? []).min() ?? 0)) / yAxis) * geo.size.height
                            
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            }
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                    
                    if vm.past3MonthsSelected {
                        for index in vm.past3MonthsData(priceDates: vm.priceDates ?? []).indices {
                            let xPosition = geo.size.width / CGFloat(vm.past3MonthsData(priceDates: vm.priceDates ?? []).count) * CGFloat(index + 1)
                            
                            let yAxis = (vm.past3MonthsData(priceDates: vm.priceDates ?? []).max() ?? 0) - (vm.past3MonthsData(priceDates: vm.priceDates ?? []).min() ?? 0)
                            
                            let yPosition = (1 - CGFloat(vm.past3MonthsData(priceDates: vm.priceDates ?? [])[index] - (vm.past3MonthsData(priceDates: vm.priceDates ?? []).min() ?? 0)) / yAxis) * geo.size.height
                            
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            }
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                    
                    if vm.pastYearSelected {
                        for index in vm.pastYearData(priceDates: vm.priceDates ?? []).indices {
                            let xPosition = geo.size.width / CGFloat(vm.pastYearData(priceDates: vm.priceDates ?? []).count) * CGFloat(index + 1)
                            
                            let yAxis = (vm.pastYearData(priceDates: vm.priceDates ?? []).max() ?? 0) - (vm.past3MonthsData(priceDates: vm.priceDates ?? []).min() ?? 0)
                            
                            let yPosition = (1 - CGFloat(vm.pastYearData(priceDates: vm.priceDates ?? [])[index] - (vm.pastYearData(priceDates: vm.priceDates ?? []).min() ?? 0)) / yAxis) * geo.size.height
                            
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            }
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                    
                    if vm.pastTotalSelected {
                        for index in vm.pastTotalData(priceDates: vm.priceDates ?? []).indices {
                            let xPosition = geo.size.width / CGFloat(vm.pastTotalData(priceDates: vm.priceDates ?? []).count) * CGFloat(index + 1)
                            
                            let yAxis = (vm.pastTotalData(priceDates: vm.priceDates ?? []).max() ?? 0) - (vm.pastTotalData(priceDates: vm.priceDates ?? []).min() ?? 0)
                            
                            let yPosition = (1 - CGFloat(vm.pastTotalData(priceDates: vm.priceDates ?? [])[index] - (vm.pastTotalData(priceDates: vm.priceDates ?? []).min() ?? 0)) / yAxis) * geo.size.height
                            
                            if index == 0 {
                                path.move(to: CGPoint(x: xPosition, y: yPosition))
                            }
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                }
                .trim(from: 0, to: percentage)
                //            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                //            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
                //            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
                //            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
                //            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
                .stroke(vm.pastDaySelected && vm.pastDayReturnPercentage > 0 ? Color.theme.green : (vm.pastWeekSelected && vm.pastWeekReturnPercentage > 0 ? Color.theme.green : (vm.pastMonthSelected && vm.pastMonthReturnPercentage > 0 ? Color.theme.green : (vm.past3MonthsSelected && vm.past3MonthsReturnPercentage > 0 ? Color.theme.green : (vm.pastYearSelected && vm.pastYearReturnPercentage > 0 ? Color.theme.green : vm.pastTotalSelected && vm.totalReturnPercentage > 0 ? Color.theme.green : Color.theme.red)))), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .shadow(color: vm.pastDaySelected && vm.pastDayReturnPercentage > 0 ? Color.theme.green : (vm.pastWeekSelected && vm.pastWeekReturnPercentage > 0 ? Color.theme.green : (vm.pastMonthSelected && vm.pastMonthReturnPercentage > 0 ? Color.theme.green : (vm.past3MonthsSelected && vm.past3MonthsReturnPercentage > 0 ? Color.theme.green : (vm.pastYearSelected && vm.pastYearReturnPercentage > 0 ? Color.theme.green : vm.pastTotalSelected && vm.totalReturnPercentage > 0 ? Color.theme.green : Color.theme.red)))), radius: 10, x: 0, y: 10)
                .shadow(color: vm.pastDaySelected && vm.pastDayReturnPercentage > 0 ? Color.theme.green : (vm.pastWeekSelected && vm.pastWeekReturnPercentage > 0 ? Color.theme.green : (vm.pastMonthSelected && vm.pastMonthReturnPercentage > 0 ? Color.theme.green : (vm.past3MonthsSelected && vm.past3MonthsReturnPercentage > 0 ? Color.theme.green : (vm.pastYearSelected && vm.pastYearReturnPercentage > 0 ? Color.theme.green : vm.pastTotalSelected && vm.totalReturnPercentage > 0 ? Color.theme.green : Color.theme.red)))), radius: 10, x: 0, y: 20)
                //            .shadow(color: pastDaySelected && vm.pastDayPriceChange > 0 ? Color.theme.green : (pastWeekSelected && vm.pastWeekPriceChange > 0 ? Color.theme.green : (pastMonthSelected && vm.pastMonthPriceChange > 0 ? Color.theme.green : (past3MonthsSelected && vm.past3MonthsPriceChange > 0 ? Color.theme.green : (pastYearSelected && vm.pastYearPriceChange > 0 ? Color.theme.green : Color.theme.red)))).opacity(0.2), radius: 10, x: 0, y: 30)
                //            .shadow(color: pastDaySelected && vm.pastDayPriceChange > 0 ? Color.theme.green : (pastWeekSelected && vm.pastWeekPriceChange > 0 ? Color.theme.green : (pastMonthSelected && vm.pastMonthPriceChange > 0 ? Color.theme.green : (past3MonthsSelected && vm.past3MonthsPriceChange > 0 ? Color.theme.green : (pastYearSelected && vm.pastYearPriceChange > 0 ? Color.theme.green : Color.theme.red)))).opacity(0.1), radius: 10, x: 0, y: 40)
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
                Text(getMaxY().formattedWithAbbreviations())
                            Spacer()
                            Text(((getMaxY() + getMinY()) / 2).formattedWithAbbreviations())
                            Spacer()
                Text(getMinY().formattedWithAbbreviations())
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
