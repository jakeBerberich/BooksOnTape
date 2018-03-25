//
//  AuthorStructures.swift
//
//
//  Created by Jake Berberich on 3/6/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import Foundation
var blanks = " "

struct Authors: Codable {
    var authorID: Int
    var first: String
    var last: String
    var rating: Int
    var  recentBooks: String
    var deceased : String
    var  link: String
    var authorPixAddress: String
  


private enum CodingKeys: String, CodingKey {
     case authorID = "AuthorID"
    case first = "First"
    case last = "Last"
    case rating = "Rating"
    case recentBooks = "Recent Books"
    case deceased = "Deceased"
    case link = "Link"
    case authorPixAddress = "AuthorPix"
}

init() {
     authorID = 0
    first = blanks
    last = blanks
    rating = 0
    recentBooks = blanks
    deceased = blanks
    link = blanks
    authorPixAddress = blanks
}
}
