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
    var infoSection: some View {
        NavigationLink {
            InfoView()
        } label: {
            HStack {
                Image(systemName: "info.circle")
                Text("Info")
            }
        }
    }
    
    var accountSection: some View {
        NavigationLink {
            EditAccountView()
        } label: {
            HStack {
                Image(systemName: "person.crop.circle")
                Text("Account")
            }
        }
    }
    
    var themeSection: some View {
        Toggle("Alternative Theme", isOn: $vm.alternativeTheme)
    }
    
    var logOutSection: some View {
        Button("Log out \(vm.userName)") {
            showLogOutAlert = true
        }
        .tint(.blue)
    }
}
