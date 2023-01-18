//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Deer on 6/11/1441 AH.
//  Copyright © 1441 Deer All rights reserved.
//

import Foundation

struct LoginResponse : Codable {
    let account : Account
    let session : Session

}

struct Account : Codable {
    let registered : Bool
    let key : String
}

struct Session : Codable {
    let id : String
    let expiration : String
    
}
