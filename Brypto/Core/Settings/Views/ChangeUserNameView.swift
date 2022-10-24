//
//  ChangeUserNameView.swift
//  Brypto
//
//  Created by Bruke on 9/7/22.
//

import SwiftUI

struct ChangeUserNameView: View {
    @State private var newUserName: String = ""
    @State private var enteredPassword: String = ""
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("password") var password: String = ""
    
    @State private var changeSuccessful: Bool = false
    
    var body: some View {
        VStack {
            List {
                Section("Enter new username") {
                    TextField("Username", text: $newUserName)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section("Enter password") {
                    SecureField("Password", text: $enteredPassword)
                        .textFieldStyle(.roundedBorder)
                }
                
                Section {
                    Button {
                        userName = newUserName.lowercased()
                        changeSuccessful = true
                    } label: {
                        Text("Confirm")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.theme.accentMain)
                            .cornerRadius(10)
                            .padding()
                    }
                    .disabled(!passwordCheck() && !userNameCheck())
                }
                
                Section {
                    
                }
            }
        }
        .navigationBarTitle("Change username")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChangeUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUserNameView()
    }
}

extension ChangeUserNameView {
    func passwordCheck() -> Bool {
        if enteredPassword == password {
            return true
        } else {
            return false
        }
    }
    
    func userNameCheck() -> Bool {
        if newUserName == userName {
            return false
        } else {
            return true
        }
    }
}
