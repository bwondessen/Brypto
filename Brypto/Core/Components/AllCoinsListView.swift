//
//  AllCoinsListView.swift
//  Brypto
//
//  Created by Bruke on 9/14/22.
//

import SwiftUI

struct AllCoinsListView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        VStack {
            columnsTitle
            
            List {
                ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 0, leading: -10, bottom: 10, trailing: 0))
                        .onTapGesture {
                            segue(coin: coin)
                        }
                    //.frame(width: UIScreen.main.bounds.width)
                        .listRowBackground(Color.theme.background)
                        .onTapGesture {
                            segue(coin: coin)
                        }
                        .swipeActions {
                            Button {
                                vm.updateBookmark(coin: coin, isBookmarked: isBookmarked)
                            } label: {
                                Image(systemName: vm.bookmaredCoins.contains(where: { $0.id == coin.id }) ? "bookmark.slash" : "bookmark")
                            }
                            .tint(Color("AccentColor"))
                            
                        }
                }
                .listRowSeparator(.hidden)
            }
            //.listRowSeparator(.hidden)
        }
        .navigationTitle("All coins")
        .navigationBarTitleDisplayMode(.inline)
        //.navigationBarHidden(true)
        .background(
            NavigationLink(
                isActive: $showDetailView,
                destination: { DetailLoadingView(coin: $selectedCoin) },
                label: { EmptyView() })
        )
        //.padding()
    }
}

//struct AllCoinsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCoinsListView()
//    }
//}

extension AllCoinsListView {
    private var columnsTitle: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0.0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            //Spacer()
            
            //                HStack(spacing: 4) {
            //                    Text("Holdings")
            //                    Image(systemName: "chevron.down")
            //                        .opacity( (vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0 )
            //                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0.0 : 180))
            //                }
            //                .onTapGesture {
            //                    withAnimation(.default) {
            //                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
            //                    }
            //                }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity( (vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0.0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 5.0, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360.0 : 0.0), anchor: .center)
        }
        .font(.caption)
        .foregroundColor(Color.theme.accent)
        .padding(.horizontal)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.theme.accent.opacity(0.05))
        )
        .listRowBackground(Color.theme.background)
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
}


