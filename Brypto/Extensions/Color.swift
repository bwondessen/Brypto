//
//  Color.swift
//  Brypto
//
//  Created by Bruke on 6/8/22.
//

import Foundation
import SwiftUI

extension Color {
    static var theme = ColorThemeMain()
    //static let theme = ColorThemeAlternative()
    static let launch = LaunchTheme()
}

struct ColorThemeMain {
    let accent = Color("AccentColor")
    let accentMain = Color("AccentColorMain")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct ColorThemeAlternative {
    let accent = Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))
    let background = Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))
    let green = Color(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
    let red = Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
    let secondaryText = Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1))
}

//
//struct ColorTheme2 {
//    let accent = Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))
//    let background = Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))
//    let green = Color(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
//    let red = Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
//    let secondaryText = Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1))
//}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
