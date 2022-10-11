//
//  PrivacyPolicyView.swift
//  Brypto
//
//  Created by Bruke on 10/11/22.
//

import SwiftUI
import WebKit

struct PrivacyPolicyView: UIViewRepresentable {
    let htmlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

//struct PrivacyPolicyView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrivacyPolicyView()
//    }
//}
