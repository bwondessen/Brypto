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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    ForEach(0..<3) { index in
                        AsyncImage(url: URL(string: category.top3Coins[index])) { image in
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
                .accentColor(.blue)
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
