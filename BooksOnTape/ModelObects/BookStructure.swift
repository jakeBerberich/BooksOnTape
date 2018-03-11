//
//  BookStructure.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/6/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import Foundation
 

struct Books: Codable {
    let authorFirst: String
    let authorLast: String
    let title: String
    let series: String
    let fullName: String
    let status: String
    let pixURL: String
    let format: String
    let rating: Int
    
    
    private enum CodingKeys: String, CodingKey {
        case authorFirst = "Author First"
        case authorLast =  "Author Last"
        case title = "Title"
        case series = "Series"
        case fullName = "Full Name"
        case status = "Status"
        case pixURL = "PixURL"
        case format = "Format"
        case rating = "Rating"
    }
    
    init() {
        authorFirst = blanks
        authorLast = blanks
        title = blanks
        series = blanks
        fullName = blanks
        status = blanks
        pixURL = blanks
        format = blanks
        rating = 0
    }
}
