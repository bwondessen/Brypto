//
//  String.swift
//  Brypto
//
//  Created by Bruke on 8/30/22.
//

import Foundation

extension String {
    var removingHTMLOccurrances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
