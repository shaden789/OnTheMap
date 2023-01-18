//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Deer on 6/11/1441 AH.
//  Copyright © 1441 Deer All rights reserved.
//

import Foundation

struct StudentLocationList : Codable {
    var results: [StudentLocation]
}

struct StudentLocation : Codable {
    
    let createdAt : String
    let firstName : String
    let lastName : String
    let latitude : Double
    let longitude : Double
    let mapString : String
    let mediaURL : String
    let objectId : String
    let uniqueKey : String
    let updatedAt : String
    
    enum CodingKeys: String, CodingKey{
       
        case createdAt
        case firstName
        case lastName
        case latitude
        case longitude
        case mapString
        case mediaURL
        case objectId
        case uniqueKey
        case updatedAt
    }
    
}
