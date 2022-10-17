//
//  ChartDateLabelView.swift
//  Brypto
//
//  Created by Bruke on 10/17/22.
//

import SwiftUI

struct ChartDateLabelView: View {
    let date: String
    
    var body: some View {
        Text(date)
            .font(.footnote.bold())
            .padding(2)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 2)
            )
    }
}

struct ChartDateLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDateLabelView(date: "1D")
    }
}
