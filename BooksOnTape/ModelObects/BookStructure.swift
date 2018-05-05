//
//  BookStructure.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/6/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import Foundation
 

struct Books: Codable {
    var authorFirst: String
    var authorLast: String
    var title: String
    var series: String
    var fullName: String
    var status: String
    var pixURL: String
    var format: String
    var rating: Int
    
    
    private enum CodingKeys: String, CodingKey {
        case authorFirst = "AuthorFirst"
        case authorLast =  "AuthorLast"
        case title = "Title"
        case series = "Series"
        case fullName = "FullName"
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
