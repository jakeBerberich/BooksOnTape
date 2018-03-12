//
//  RemoteFunctions.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/6/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import Foundation
class RemoteFunctions {
    
    var booksArray = [Books]()
    var authorsArray = [Authors]()
    
    var jsonEncoder = JSONEncoder()
    var jsonDecoder = JSONDecoder()
    
    enum RemoteRecords {
        static let booksDB = "Books"
        static let authorsDB = "Authors"
    }
    
    enum RemoteAuthor {
        static let authorID = "authorID"
        static let authorPixAddress = "authorPixAddress"
        static let deceased = "deceased"
        static let first = "first"
        static let last = "last"
        static let link = "link"
        static let rating = "rating"
        static let recentBooks = "recentBooks"
    }
    
    enum RemoteBook {
         static let authorFirst = "authorFirst"
        static let authorLast = "authorLast"
        static let format = "format"
        static let pixURL = "pixURL"
        static let rating = "rating"
        static let status = "status"
        static let title = "title"
    }
    
    
  //------------------------------------------------------------------------------------
    func returnAuthorsJson() ->  ([Authors]) {
        
//        let path = Bundle.main.path(forResource: "books", ofType: "json")
//        let url = URL(fileURLWithPath: path!)
//
//        do {
//            let data = try Data(contentsOf: url)
//            self.booksArray = try JSONDecoder().decode([Books].self, from: data)
//            booksArray.sort(by:{ $0.authorLast < $1.authorLast})
//        } catch   { print("error")
//
//        }
        //-------------
        let path2 = Bundle.main.path(forResource: "authors", ofType: "json")
        let url2 = URL(fileURLWithPath: path2!)
        
        do {
            let data = try Data(contentsOf: url2)
            self.authorsArray = try JSONDecoder().decode([Authors].self, from: data)
            
        } catch   { print("error")
        }
        
        return ( authorsArray)
    }
  //------------------------------------------------------------------------------------
    
}
