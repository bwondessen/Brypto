//
//  AccountDetailsView.swift
//  Brypto
//
//  Created by Bruke on 9/28/22.
//

import SwiftUI
//import SwiftPieChart

struct AccountDetailsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @EnvironmentObject private var detailVM: DetailViewModel
    
    //    var randomColor: Color {
    //        let color: [Color] = [.red, .blue, .orange, .green, .purple, .yellow, .brown, .gray, .mint, .cyan].shuffled()
    //
    //        return color.randomElement() ?? .cyan
    //    }
    
    let aColor: [Color] = [.red, .blue, .orange, .green, .purple, .yellow, .brown, .gray, .mint, .cyan] // .shuffled()
    
    //    @AppStorage("totalDollarAmountInPortfolio") var totalDollarAmountInPortfolio: Double = 0
    
    //    @AppStorage("bio") var bio: String = ""
    
    @State private var index: Int = 1
    
    
    var body: some View {
        ScrollView {
            VStack {
                userAccountHeading
                investingInfoSection
                portfolioBreakdownHeader
                portfolioBreakdownCategoriesHeader
                portfolioBreakdownSection
            }
        }
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailsView()
    }
}

extension AccountDetailsView {
    private var userAccountHeading: some View {
        VStack(spacing: 10) {
            Image("lebron")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            //            Image(systemName: "face.smiling")
            //                .resizable()
            //                .frame(width: 60, height: 60)
            Text("@\(vm.userName)")
                .font(.headline.bold())
        }
        .padding(.vertical)
    }
    
    private var investingInfoSection: some View {
        VStack {
            VStack(spacing: 7.5) {
                HStack {
                    Text("Portfolio Value:")
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                    Text("\(vm.portfolioValue.asCurrencyWith2Decimals())")
                        .font(.headline.bold())
                        .foregroundColor(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Buying Power")
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                    Text(vm.buyingPower.asCurrencyWith2Decimals())
                        .font(.headline.bold())
                        .foregroundColor(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Total Return")
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                    Spacer()
                    HStack {
                        Text(vm.totalReturn.asCurrencyWith2Decimals())
                            .font(.headline.bold())
                            .foregroundColor(Color.theme.accent)
                        Text("(\(vm.totalReturnPercentage.asPercentString()))")
                            .font(.callout)
                            .foregroundColor(vm.totalReturnPercentage >= 0 ? Color.theme.accentMain : Color.theme.red)
                    }
                }
            }
        }
        .padding()
    }
    
    private var portfolioBreakdownHeader: some View {
        HStack {
            Text("Portfolio Breakdown")
            //Text("\(detailVM.categories)")
                .font(.title2.bold())
            Spacer()
        }
        .padding()
    }
    
    private var portfolioBreakdownCategoriesHeader: some View {
        HStack {
            VStack {
                Text("Diversity")
                Rectangle().frame(height: 3).foregroundColor(vm.valueSelected ? Color.theme.green : Color.clear)
            }
            .frame(width: 100, height: 10)
            .onTapGesture {
                vm.valueSelected = true
                vm.diversitySelected = false
                }
            //Spacer()
            VStack {
                Text("Value")
                Rectangle().frame(height: 3).foregroundColor(vm.diversitySelected ? Color.theme.green : Color.clear)
            }
                .frame(width: 100, height: 10)
                .onTapGesture {
                    vm.valueSelected = false
                    vm.diversitySelected = true
                }
        }
        .padding()
        .font(.headline)
        .foregroundColor(Color.theme.accent)
    }
    
//    diversitySelected ? $0.currentHoldingsValue : (returnSelected ? vm.getTotalPriceChange(portfolioCoins: vm.purchasedCoins) : $0.currentPrice))
    
    private var portfolioBreakdownSection: some View {
        VStack {
            PieChartView(
                values: vm.purchasedCoins.map({vm.valueSelected ? $0.currentHoldingsValue : ($0.currentHoldings ?? 0) }),
                names: vm.purchasedCoins.map({$0.name}),
                formatter: {value in
                    //String(format: "$%.2f", value)
                    String(value.asCurrencyWith2Decimals())
                },
                //colors: aColor,
                backgroundColor: Color.theme.background,
                widthFraction: 0.70,
                innerRadiusFraction: 0.55
            )
            //                    PieChartView(values: T##[Double], names: T##[String], formatter: T##(Double) -> String, colors: T##[Color], backgroundColor: T##Color, widthFraction: T##CGFloat, innerRadiusFraction: T##CGFloat)
        }
        .padding()
        .padding(.bottom)
    }
}
