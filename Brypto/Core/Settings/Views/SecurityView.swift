//
//  SecurityView.swift
//  Brypto
//
//  Created by Bruke on 9/8/22.
//

import SwiftUI

struct SecurityView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @AppStorage("faceIDEnabled") private var faceIDEnabled: Bool = false
    @AppStorage("passcodeRequired") var passcodeRequired: Bool = false
    
    var body: some View {
        VStack {
            securityTitle
            
            List {
                Toggle("Enable Face ID", isOn: $faceIDEnabled)
                    .onChange(of: faceIDEnabled) { newValue in
                        vm.enableFaceID(faceIDEnabled: newValue)
                    }
                Toggle("Enable passcode", isOn: $passcodeRequired) 
            }
        }
        .navigationBarTitle("Security")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SecurityView()
        }
    }
}

extension SecurityView {
    var securityTitle: some View {
        Text("Protect your Byrpto account with additional layers of security.")
            .font(.body)
            .multilineTextAlignment(.center)
    }
}
