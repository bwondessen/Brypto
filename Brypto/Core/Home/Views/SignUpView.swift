//
//  SignUpView.swift
//  Brypto
//
//  Created by Bruke on 9/6/22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var enteredFullName: String = ""
    @State private var enteredUserName: String = "".lowercased()
    @State private var enteredPassword: String = ""
    @State private var enteredEmail: String = ""
    
    @AppStorage("fullName") var fullName: String = ""
    //@AppStorage("firstName") private var firstName: String
    //@AppStorage("lastName") private var lastName: String
    @AppStorage("userName") var userName: String = ""
    @AppStorage("password") var password: String = ""
    @AppStorage("email") var email: String = ""
    @State private var birthday: Date = Date()
        
    var body: some View {
        //NavigationView {
        VStack {
            welcomeSection
            loginInfo
            signUpButton
                .disabled(aunthenticateSignUp())
            orDivider
            loginButton
        }
        .navigationBarHidden(true)
        .background(
            Rectangle()
                .fill(.white)
                .cornerRadius(5)
                .shadow(radius: 5)
        )
        .padding()
        .padding()
        //}
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension SignUpView {
    var welcomeSection: some View {
        VStack {
            Image("logo-transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text("Welcome to Brypto!")
                .font(.largeTitle.bold())
                .foregroundColor(Color("AccentColor"))
            Text("Sign up to stay up to date with all things crypto.")
                .foregroundColor(Color.secondary)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
    
    var loginInfo: some View {
        VStack(spacing: -20) {
            Group {
                TextField("Email", text: $enteredEmail)
                DatePicker("Birthday 🎂", selection: $birthday, in: ...Date(), displayedComponents: [.date])
                TextField("Full Name", text: $enteredFullName)
                TextField("Username", text: $enteredUserName)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Password", text: $enteredPassword)
            }
            .disableAutocorrection(true)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    //.fill(.clear)
                    .stroke(Color.secondary, style: StrokeStyle(lineWidth: 2))
            )
        .padding()
        }
        .padding(.horizontal)
    }
    
    var signUpButton: some View {
        Button {
            let user = UserModel(fullName: enteredFullName, userName: enteredUserName, password: enteredPassword, email: enteredEmail, birthday: birthday)
            fullName = user.fullName
            userName = user.userName.lowercased()
            password = user.password
            email = user.email
            birthday = user.birthday
            completeSignUp()
        } label: {
            Text("Sign up")
                .font(.headline.bold())
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("LaunchAccentColor"))
                .cornerRadius(10)
                .padding()
        }
        .padding(.horizontal)
    }
    
    var orDivider: some View {
        HStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .foregroundColor(Color.secondary)
            Text("OR")
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .foregroundColor(Color.secondary)
        }
        .padding(.horizontal)
    }
    
    var loginButton: some View {
        NavigationLink {
            LoginView()
        } label: {
            Text("Login")
                .font(.headline.bold())
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("LaunchAccentColor"))
                .cornerRadius(10)
                .padding()
        }
        .padding(.horizontal)
    }
    
    func aunthenticateSignUp() -> Bool {
        if !enteredUserName.isEmpty && !enteredPassword.isEmpty && !enteredFullName.isEmpty && !enteredEmail.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func completeSignUp() {
        vm.signUp(enteredUserName: enteredUserName, enteredPassword: enteredPassword, enteredEmail: enteredEmail, enteredFullName: enteredFullName)
    }
}
