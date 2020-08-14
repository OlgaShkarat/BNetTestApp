//
//  Session.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    let status: Int
    let data: Session?
}

struct Session: Codable {
    let id: String?
    let session: String?
}
