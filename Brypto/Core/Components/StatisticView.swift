//
//  StatisticView.swift
//  Brypto
//
//  Created by Bruke on 6/18/22.
//

import SwiftUI

struct StatisticView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(stat.title == "Balance" ? .primary : Color.theme.secondaryText)
            Text(stat.value)
                .font(stat.title == "Balance" ? .title : .headline.bold())
                .fontWeight(.semibold)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.footnote)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
//                Text(stat.percentageChange?.asPercentString() ?? "")
                Text((vm.pastDaySelected ? vm.pastDayReturn : (vm.pastWeekSelected ? vm.pastWeekReturn : (vm.pastMonthSelected ? vm.pastMonthReturn : (vm.past3MonthsSelected ? vm.past3MonthsReturn : (vm.pastYearSelected ? vm.pastYearReturn : vm.totalReturn))))).asCurrencyWith2Decimals())
                    .font(.subheadline.bold())
                Text("(\((vm.pastDaySelected ? vm.pastDayReturnPercentage : (vm.pastWeekSelected ? vm.pastWeekReturnPercentage : (vm.pastMonthSelected ? vm.pastMonthReturnPercentage : (vm.past3MonthsSelected ? vm.past3MonthsReturnPercentage : (vm.pastYearSelected ? vm.pastYearReturnPercentage : vm.totalReturn))))).asPercentString()))")
                    .font(.footnote.bold())
                Text(vm.pastDaySelected ? "Today" : (vm.pastWeekSelected ? "Past Week" : (vm.pastMonthSelected ? "Past Month" : (vm.past3MonthsSelected ? "Past 3 Months" : (vm.pastYearSelected ? "Past Year" : "All Time")))))
                    .font(.footnote.bold())
                    .foregroundColor(Color.theme.accent)
                Spacer()
            }
            .foregroundColor((vm.pastDayReturnPercentage > 0 || vm.pastDayReturnPercentage > 0 || vm.pastWeekReturnPercentage > 0 || vm.pastMonthReturnPercentage > 0 || vm.past3MonthsReturnPercentage > 0 || vm.pastYearReturnPercentage > 0 || vm.totalReturnPercentage > 0) ? Color.theme.green : Color.theme.red)
//            .opacity((vm.pastDayReturnPercentage == nil || vm.pastDayReturnPercentage == nil || vm.pastWeekReturnPercentage == nil || vm.pastMonthReturnPercentage == nil || vm.past3MonthsReturnPercentage == nil || vm.pastYearReturnPercentage == nil || vm.totalReturnPercentage == nil) ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat1)
            
            StatisticView(stat: dev.stat2)
            
            StatisticView(stat: dev.stat3)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
