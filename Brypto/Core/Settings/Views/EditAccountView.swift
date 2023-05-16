////
////  EditAccountView.swift
////  Brypto
////
////  Created by Bruke on 9/7/22.
////
//
//import SwiftUI
//
//struct EditAccountView: View {
//    @EnvironmentObject private var vm: HomeViewModel
//
//    //@State private var showDeleteAccountAlert: Bool = false
//
//    var body: some View {
//        ZStack {
//            // background layer
//            Color.theme.background
//                .ignoresSafeArea()
//
//            // content layer
//            List {
//                Section {
//                    changeUserNameSection
//                    changePasswordSection
//                    //securitySection
//                }
//                .foregroundColor(Color.theme.accent)
//
////                Section {
////                    deleteSection
////                }
//            }
//            .listStyle(.insetGrouped)
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .font(.headline)
//        .tint(.blue)
//        .navigationTitle("Account")
////        .alert("Confirm account deletion", isPresented: $showDeleteAccountAlert) {
////            Button("Delete", role: .destructive) {
////                vm.deleteAccount()
////            }
////        } message: {
////            Text("Are you sure you want to delete your account? This action is permanent.")
////        }
//    }
//}
//
//struct EditAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditAccountView()
//    }
//}
//
//extension EditAccountView {
//    var changeUserNameSection: some View {
//        NavigationLink {
//            ChangeUserNameView()
//        } label: {
//            Text("Change username")
//        }
//    }
//
//    var changePasswordSection: some View {
//        NavigationLink {
//            ChangePasswordView()
//        } label: {
//            Text("Change password")
//        }
//    }
//
//    //    var securitySection: some View {
//    //        NavigationLink {
//    //            SecurityView()
//    //                .navigationBarBackButtonHidden(true)
//    //        } label: {
//    //            Text("Security")
//    //        }
//    //
//    //    }
//
//
////    var deleteSection: some View {
////        Button {
////            showDeleteAccountAlert = true
////        } label: {
////            Text("Delete account")
////                .font(.headline.bold())
////                .foregroundColor(Color.theme.red)
////                .padding()
////                .frame(maxWidth: .infinity)
////                .overlay(
////                    RoundedRectangle(cornerRadius: 10)
////                        .strokeBorder(Color.theme.red, lineWidth: 0.55)
////                )
////        }
////
////    }
//}
