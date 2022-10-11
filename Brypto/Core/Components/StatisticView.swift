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
                Text(vm.totalReturnPercentage.asPercentString())
                    .font(.subheadline)
                .bold()
                Spacer()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
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
