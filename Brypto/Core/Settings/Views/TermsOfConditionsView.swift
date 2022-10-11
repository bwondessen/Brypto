//
//  TermsOfConditionsView.swift
//  Brypto
//
//  Created by Bruke on 10/11/22.
//

import SwiftUI
import WebKit

struct TermsOfConditionsView: UIViewRepresentable {
    let htmlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

//struct TermsOfConditionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TermsOfConditionsView()
//    }
//}
