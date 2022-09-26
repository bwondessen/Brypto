//
//  CryptoNewsView.swift
//  Brypto
//
//  Created by Bruke on 9/21/22.
//

import SwiftUI

struct CryptoNewsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
//    let randomCoin = Int.random(in: 0...50)
    
    var body: some View {
        NavigationView {
            VStack {
                newsHeader
                newsArticleView
            }
            .navigationBarHidden(true)
        }
    }
}

struct CryptoNewsView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoNewsView()
    }
}

extension CryptoNewsView {
    private var newsHeader: some View {
        Text("News")
            .font(.headline)
            .fontWeight(.heavy)
            .foregroundColor(Color.theme.accent)
            .padding()
    }
    
    private var newsArticleView: some View {
        List {
            ForEach(vm.marketNews) { newsArticle in
                Link(destination: URL(string: newsArticle.link) ?? URL(string: "https://dilbert.com/404")!) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(newsArticle.sourceID.capitalized)
                                .font(.headline)
                            Text(Date(coinGeckoString: newsArticle.pubDate).asShortDateString())
                                .font(.footnote)
                            Spacer()
                        }
                        HStack {
                            Text(newsArticle.description)
                                .font(.body)
                                .lineLimit(4)
                                .padding(.trailing)
                                .frame(height: 80)
                            
                            Spacer()
                            
                            AsyncImage(url: URL(string: newsArticle.imageURL ?? "https://images.cointelegraph.com/images/1434_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS91cGxvYWRzLzIwMjItMDYvNTk5NDRjMTMtODkzNC00ZjU5LWJiY2UtZDRiOWM5OTdjOTI1LmpwZw==.jpg")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .cornerRadius(5)
                            //.clipped()
                        }
                        //ChartViewMinimal(coin: vm.allCoins[randomCoin])
//                        Rectangle()
//                            .frame(height: 0.20)
//                            .foregroundColor(Color.theme.secondaryText)
                    }
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(.white)
//                            .shadow(radius: 3)
//                    )
                }
            }
            //.listRowSeparator(.hidden)
        }
        //.navigationTitle("News")        
    }
}
