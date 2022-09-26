//
//  ChangePasswordView.swift
//  Brypto
//
//  Created by Bruke on 9/7/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var newPassword: String = ""
    @State private var oldPassowrd: String = ""
    
    @AppStorage("passwrd") var password: String = ""
    
    var body: some View {
        VStack {
            List {
                Section("Enter old password") {
                    SecureField("Old password", text: $oldPassowrd)
                        .textFieldStyle(.roundedBorder)
                }
                
                Section("Enter new password") {
                    SecureField("New Passowrd", text: $newPassword)
                        .textFieldStyle(.roundedBorder)
                        .disabled(!passwordCheck())
                }
                
                Section {
                    Button {
                        password = newPassword
                    } label: {
                        Text("Confirm")
                            .font(.headline.bold())
                            .foregroundColor(Color("LaunchAccentColor"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.black)
                            .cornerRadius(10)
                            .padding()
                    }
                    .disableAutocorrection(!passwordCheck())
                    .disabled(!passwordCheck())
                }
            }
        }
        .navigationBarTitle("Change password")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}

extension ChangePasswordView {
    func passwordCheck() -> Bool {
        if oldPassowrd == password {
            return true
        } else {
            return false
        }
    }
}
