//
//  SettingsView.swift
//  Brypto
//
//  Created by Bruke on 9/6/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    //@State var alternativeTheme: Bool
    
    @State private var showLogOutAlert: Bool = false
    
    @AppStorage("faceIDEnabled") private var faceIDEnabled: Bool = false
    @AppStorage("passcodeRequired") var passcodeRequired: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    infoSection
                }
                .navigationBarTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .foregroundColor(Color.theme.accent)
                
                Section {
                    accountSection
                }
                .navigationBarTitle("Account")
                .navigationBarTitleDisplayMode(.inline)
                .foregroundColor(Color.theme.accent)
                
                Section {
                    securitySection
                }
                
                Section {
                    logOutSection
                }
            }
            .listStyle(.insetGrouped)
        }
        .alert("Confirm log out", isPresented: $showLogOutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Log out", role: .destructive) {
                vm.logOut()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var infoSection: some View {
        NavigationLink {
            InfoView()
        } label: {
            HStack {
                Image(systemName: "info.circle")
                VStack(alignment: .leading) {
                    Text("Info")
                        .font(.headline)
                    Text("About, contact, terms of service")
                        .font(.footnote.italic())
                }
            }
        }
    }
    
    private var accountSection: some View {
        NavigationLink {
            EditAccountView()
        } label: {
            HStack {
                Image(systemName: "person.crop.circle")
                VStack(alignment: .leading) {
                    Text("Account")
                        .font(.headline)
                    Text("Change password & username")
                        .font(.footnote.italic())
                }
            }
        }
    }
    
    private var securitySection: some View {
        NavigationLink {
            SecurityView()
        } label: {
            HStack {
                Image(systemName: "lock")
                VStack(alignment: .leading) {
                    Text("Security")
                        .font(.headline)
                    Text("Enable Face ID & password")
                        .font(.footnote.italic())
                }
            }
        }
    }
    
    private var themeSection: some View {
        Toggle("Alternative Theme", isOn: $vm.alternativeTheme)
    }
    
    private var logOutSection: some View {
        Button {
            showLogOutAlert = true
        } label: {
            Text("Log out")
                .font(.headline.bold())
                .foregroundColor(Color.theme.accent)
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.theme.accent, lineWidth: 0.55)
                )
        }
    }
}
