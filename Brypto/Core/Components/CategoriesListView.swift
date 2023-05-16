//
//  CategoriesListView.swift
//  Brypto
//
//  Created by Bruke on 9/15/22.
//

import SwiftUI

struct CategoriesListView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    //let categry: MarketCategoryDataModel
    //let coin: CoinModel
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Categories")
                    .font(.title.bold())
                Text("Discover and compare new asset categories")
                    .font(.subheadline)
                    .foregroundColor(Color.theme.secondaryText)
            }
            .padding(.bottom)
            
            ForEach(vm.marketCategories) { category in
                NavigationLink {
                    CategoryContentView(category: category)
                } label: {
                    HStack {
                        Image(systemName: vm.icons.randomElement() ?? "bonjour")
                            .padding()
                            .frame(width: 50, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.theme.accent, lineWidth: 0.25)
                            )
                        Text(category.name)
                            .font(.subheadline.bold())
                    }
                .padding(.bottom)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
    }
}

//struct CategoriesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesListView(coin: dev.coin)
//    }
//}

extension CategoriesListView {
//    private func segue(category: MarketCategoryDataModel) {
//        selectedCategory = category
//        showCategoryContentView.toggle()
//    }
}


//HStack {
//    ForEach(vm.allCoins) { coin in
//        ForEach(0..<3) { index in
//            if category.top3Coins[index].lowercased().contains(coin.name.lowercased()) {
//                CoinImageView(coin: coin)
//                    .frame(maxWidth: 30,  maxHeight: 30)
//            }
//        }
//    }
//}



// Market categories
/*
 ForEach(vm.marketCategories) { category in
     VStack(alignment: .leading) {
         Text(category.name)
             .font(.headline.bold())
             //.underline()
         
         HStack(spacing: 20) {
             ForEach(category.top3Coins, id: \.self) { coinURL in
                 VStack {
                     AsyncImage(url: URL(string: coinURL)) { image in
                         image.resizable()
                     } placeholder: {
                         ProgressView()
                     }
                     .frame(width: 50, height: 50)
                     
                     //Text(coin.symbol.uppercased())
                 }
                 .onTapGesture {
                     //segue(coin: coin)
                 }
             }
         }
     }
 }
 .listRowSeparator(.hidden)
 .padding(.bottom, 35)
 */
