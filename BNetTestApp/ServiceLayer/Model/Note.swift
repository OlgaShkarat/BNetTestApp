//
//  Note.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

struct NoteResponse: Codable {
    let status: Int
    let notes: [[Note]]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case notes = "data"
    }
}

struct Note: Codable {
    let id: String
    let note: String
    let createdDate: String
    let modifiedDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case note = "body"
        case createdDate = "da"
        case modifiedDate = "dm"
    }
}
