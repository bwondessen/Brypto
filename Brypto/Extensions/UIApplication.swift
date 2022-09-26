//
//  UIApplication.swift
//  Brypto
//
//  Created by Bruke on 6/17/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
