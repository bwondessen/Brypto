//
//  InvestingView.swift
//  Brypto
//
//  Created by Bruke on 10/12/22.
//

import SwiftUI

struct InvestingView: View {
    var body: some View {
        VStack {
            List {
                Section {
                    editBuyingPowerSection
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationTitle("Investing")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InvestingView_Previews: PreviewProvider {
    static var previews: some View {
        InvestingView()
    }
}

extension InvestingView {
    private var editBuyingPowerSection: some View {
        NavigationLink {
            EditBuyingPowerView()
                .navigationBarBackButtonHidden(true)
        } label: {
            Text("Edit Buying Power")
        }
    }
}
