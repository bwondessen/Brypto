//
//  XMarkButton.swift
//  Brypto
//
//  Created by Bruke on 6/19/22.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }

    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
