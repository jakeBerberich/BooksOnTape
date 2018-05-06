//
//  FirstViewController.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/6/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import UIKit
import CloudKit

class FirstViewController: UIViewController {
  
    
    var booksArray = [Books]()
    var authorsArray = [Authors] ()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        
    }
  
    @IBAction func loadAuthorsToCloud(_ sender: Any) {
  //    loadBooks()
   //loadAuthors()
    }
    
    func loadBooks() {
       
        for books in booksArray {
            let recordBooks = CKRecord(recordType: "Books")
            
            
            recordBooks[RemoteFunctions.RemoteBook.authorFirst] = books.authorFirst as NSString
            recordBooks[RemoteFunctions.RemoteBook.authorLast] = books.authorLast as NSString
            recordBooks[RemoteFunctions.RemoteBook.format] = books.format as NSString
            recordBooks[RemoteFunctions.RemoteBook.pixURL] = books.pixURL as NSString
            recordBooks[RemoteFunctions.RemoteBook.rating] = books.rating as NSNumber
            recordBooks[RemoteFunctions.RemoteBook.status] = books.status as NSString
            recordBooks[RemoteFunctions.RemoteBook.title] = books.title as NSString
            recordBooks[RemoteFunctions.RemoteBook.series] = books.series as NSString
            recordBooks[RemoteFunctions.RemoteBook.fullName] = books.fullName as NSString
            print(recordBooks)
             
            
            ConnectionsDB.share.privateDB.save(recordBooks) {
                record, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    func loadAuthors() {
        for authors in authorsArray {
           // let record = CKRecord(recordType: RemoteFunctions.RemoteRecords.authorsDB)
            let record = CKRecord(recordType: "Authors")
            
            record[RemoteFunctions.RemoteAuthor.authorID] = authors.authorID as NSNumber
            record[RemoteFunctions.RemoteAuthor.first] = authors.first as NSString
            record[RemoteFunctions.RemoteAuthor.last] = authors.last as NSString
            record[RemoteFunctions.RemoteAuthor.rating] = authors.rating as NSNumber
            record[RemoteFunctions.RemoteAuthor.recentBooks] = authors.recentBooks as NSString
            record[RemoteFunctions.RemoteAuthor.deceased] = authors.deceased as NSString
              record[RemoteFunctions.RemoteAuthor.link] = authors.link as NSString
            record[RemoteFunctions.RemoteAuthor.authorPixAddress] = authors.authorPixAddress as NSString
            print(record)
    
            ConnectionsDB.share.privateDB.save(record) {
                record, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    

    func getJson() {
        
        let path = Bundle.main.path(forResource: "books", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        print(url)
        // --------- decode json
        do {
            let data = try Data(contentsOf: url)
            print(data)
            self.booksArray = try JSONDecoder().decode([Books].self, from: data)
            
        }
        catch{ print(error.localizedDescription)
        }
        // ----------end decode json
    }  // end get Json
    
    
}

