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
    
    let images = ["https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80", "https://images.unsplash.com/photo-1634542984003-e0fb8e200e91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80", "https://images.unsplash.com/photo-1634542984003-e0fb8e200e91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80", "https://images.unsplash.com/photo-1634542984003-e0fb8e200e91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80", "https://images.unsplash.com/photo-1634542984003-e0fb8e200e91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80", "https://images.unsplash.com/photo-1634542984003-e0fb8e200e91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80", "https://images.unsplash.com/photo-1634542984003-e0fb8e200e91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80", "https://plus.unsplash.com/premium_photo-1663931932637-e30332303b71?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80", "https://images.pexels.com/photos/6764232/pexels-photo-6764232.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.unsplash.com/photo-1622020457014-aed1cc44f25e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1744&q=80", "https://images.unsplash.com/photo-1622020457014-aed1cc44f25e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1744&q=80", "https://images.unsplash.com/photo-1622020457014-aed1cc44f25e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1744&q=80", "https://images.unsplash.com/photo-1622020457014-aed1cc44f25e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1744&q=80", "https://plus.unsplash.com/premium_photo-1663931932665-3fc739ced2ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80", "https://plus.unsplash.com/premium_photo-1663931932665-3fc739ced2ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80", "https://plus.unsplash.com/premium_photo-1663931932665-3fc739ced2ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"].shuffled()
    
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
                            
                            AsyncImage(url: URL(string: newsArticle.imageURL ?? images.randomElement() ?? "https://plus.unsplash.com/premium_photo-1663931932637-e30332303b71?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80")) { image in
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
