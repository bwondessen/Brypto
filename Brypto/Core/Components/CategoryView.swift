//
//  CategoryView.swift
//  Brypto
//
//  Created by Bruke on 9/13/22.
//

import SwiftUI

struct CategoryView: View {
    let category: MarketCategoryDataModel
    
    let images = ["ethereum-ecosystem": "📈", "meme-token": "😂", "cosmos-ecosystem": "☄️", "non-fungible-tokens-nft": "👾"]
    
    var body: some View {
        HStack {
            Text(images[category.id] ?? "")
            //Image(systemName: images[category.id] ?? "")
                .font(.title)
            Text(category.name)
                .font(.subheadline.bold())
        }
        //.padding()
        //.background(.gray.opacity(0.10))
        //.cornerRadius(10)
        //.frame(maxWidth: .infinity)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: dev.category)
    }
}
