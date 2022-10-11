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
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            List {
                develperSection
                    .listRowBackground(Color.theme.background.opacity(0.5))
                applicationSection
                    .listRowBackground(Color.theme.background.opacity(0.5))
            }
            .listStyle(.plain)
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

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

extension InfoView {
    private var develperSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Brypto is a new and exciting way to learn to invest in Crypto! Brypto is a paper trading app, which means that it simulates the Crypto market so that you can practice investing without any financial risk. The buying power you have is not real money and you do not legally own the coins purchased with it. The best way to learn is by doing, so let's get started investing - the sky is the limit!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            .listRowSeparator(.hidden)
            Link("👨‍💻 Contact Developer", destination: emailURL)
            //Link("My Twitter 📱", destination: twitterURL)
            //Link("My Github 👾", destination: githubURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application").listRowSeparator(.hidden)) {
            NavigationLink("Terms of Conditions") {
                TermsOfConditionsView(htmlString: TermsOfConditionsHTML.terms)
                    .navigationBarTitle("Terms of Conditions")
                    .navigationBarTitleDisplayMode(.inline)
            }
            NavigationLink("Privacy Policy") {
                PrivacyPolicyView(htmlString: PrivacyPolicyHTML.policy)
                    .navigationBarTitle("Privacy Policy")
                    .navigationBarTitleDisplayMode(.inline)
            }
            //Link("Terms of Service", destination: defaultURL)
            //Link("Privacy Policy", destination: defaultURL)
            //Link("Company Website", destination: defaultURL)
            //Link("Learn more", destination: defaultURL)
        }
    }
}
