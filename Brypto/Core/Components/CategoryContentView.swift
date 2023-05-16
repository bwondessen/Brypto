//
//  CategoryContentView.swift
//  Brypto
//
//  Created by Bruke on 9/16/22.
//

import SwiftUI

struct CategoryContentView: View {
    let category: MarketCategoryDataModel
    @State private var showFullDescription: Bool = false
    
    let memeImages: [String] = ["https://static.wikia.nocookie.net/dogecoin/images/c/c9/Logo.png/revision/latest?cb=20180917222934", "https://cryptologos.cc/logos/shiba-inu-shib-logo.png?v=025", "https://cryptologos.cc/logos/baby-doge-coin-babydoge-logo.png?v=025"]
    let nftImages: [String] = ["https://cryptologos.cc/logos/internet-computer-icp-logo.png", "https://cryptologos.cc/logos/apecoin-ape-ape-logo.png?v=025", "https://cryptologos.cc/logos/the-sandbox-sand-logo.png"]
    let ethImages: [String] = ["https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Ethereum_logo_translucent.svg/1449px-Ethereum_logo_translucent.svg.png", "https://cryptologos.cc/logos/tether-usdt-logo.png?v=025", "https://altcoinsbox.com/wp-content/uploads/2023/01/bnb-binance-coin-logo-750x750.webp"]
    let cosmosImages: [String] = ["https://cryptologos.cc/logos/cosmos-atom-logo.png?v=025", "https://cryptologos.cc/logos/cronos-cro-logo.png?v=025", "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Terra-luna-luna-logo.png/1200px-Terra-luna-luna-logo.png?20220511125700"]
    
    var body: some View {
        //URL(string: category.top3Coins[index])
        //"ethereum-ecosystem" || category.id == "meme-token" || category.id == "cosmos-ecosystem" || category.id == "non-fungible-tokens-nft"
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    ForEach(0..<3) { index in
                        AsyncImage(url: category.id == "meme-token" ? URL(string: memeImages[index]) : (category.id == "non-fungible-tokens-nft" ? URL(string: nftImages[index]) : (category.id == "ethereum-ecosystem" ? URL(string: ethImages[index]) : (category.id == "cosmos-ecosystem" ? URL(string: cosmosImages[index]) : URL(string: category.top3Coins[index]))))) { image in
                            image.resizable().interpolation(.none)
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                    }
                }
                .padding(.bottom, 45)
                
                Text("Market stats")
                    .font(.headline.bold())
                    .foregroundColor(Color.theme.accent)
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Image(systemName: "chart.pie")
                            .foregroundColor(Color.theme.accent)
                        Text("Market cap")
                        Spacer()
                        Text(category.marketCap?.asCurrencyWith2Decimals() ?? "N/A")
                    }
                    .font(.body)
                    .foregroundColor(Color.theme.accent)
                    
                    HStack {
                        Image(systemName: "waveform.path.ecg")
                            .foregroundColor(Color.theme.accent)
                        Text("Market cap change")
                        Spacer()
                        Text(((category.marketCapChange24h?.asNumberString() ?? "N/A") + "%"))
                    }
                    .font(.body)
                    .foregroundColor(Color.theme.accent)
                    
                    HStack {
                        Image(systemName: "chart.bar.xaxis")
                            .foregroundColor(Color.theme.accent)
                        Text("Volume")
                        Spacer()
                        Text("\(category.volume24h ?? 0)")
                    }
                    .font(.body)
                    .foregroundColor(Color.theme.accent)
                }
                .padding(.bottom, 45)
                
                Text("Description")
                    .font(.headline.bold())
                    .foregroundColor(Color.theme.accent)
                    .padding(.bottom)
                
                Text(category.content?.isEmpty ?? false ? "Description not available" : category.content ?? "Description not available")
                    .lineLimit(showFullDescription ? nil : 5)
                    .font(.callout)
                    .foregroundColor(Color.theme.secondaryText)
                
                Button {
                    withAnimation(.easeInOut) {
                        showFullDescription.toggle()
                    }
                } label: {
                    Text(category.content?.isEmpty ?? false || category.content == nil ? "" : (showFullDescription ? "Less" : "Read more..."))
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                }
                //.accentColor(.blue)
                .foregroundColor(Color.theme.accentMain)
            }
            .padding()
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct CategoryContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryContentView()
//    }
//}
