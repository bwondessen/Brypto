//
//  SettingsView.swift
//  Brypto
//
//  Created by Bruke on 8/30/22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    let emailURL = URL(string: "mailto:bwondessen23@gmail.com")!
    let twitterURL = URL(string: "https://www.twitter.com/bwondessen")!
    let githubURL = URL(string: "https://github.com/bwondessen")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let defaultURL = URL(string: "https://www.gogle.com")!
    
    var body: some View {
        NavigationView {
            ZStack {
                // background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                // content layer
                List {
                    develperSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .font(.headline)
            .tint(.blue)
            .navigationTitle("Info")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                    }
//                }
//            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

extension InfoView {
    private var develperSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Bruke Wondessen. It serves as a way to bookmark cryptocurrency while being updated on the latest crypto related news. This app is written in SwiftUI and benefits from multi-threading, publishers/subscribers, and data persistence. This app also makes use of the MVVM architecture, Combine, and Core Data!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Contact Developer 👨‍💻", destination: emailURL)
            Link("My Twitter 📱", destination: twitterURL)
            Link("My Github 👾", destination: githubURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The crypocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visist CoinGecko 🦎", destination: coinGeckoURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn more", destination: defaultURL)
        }
    }
}
