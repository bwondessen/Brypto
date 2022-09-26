//
//  UserModel.swift
//  Brypto
//
//  Created by Bruke on 9/6/22.
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    let fullName: String
    //let firstName: String
    //let lastName: String
    let userName: String
    let password: String
    let email: String
    let birthday: Date
}
