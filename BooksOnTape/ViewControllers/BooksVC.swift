//
//  BooksVC.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/10/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//
var saveBookArray = [Books]()

import UIKit
import CloudKit

class BooksVC: UITableViewController {

   let remoteFunctions = RemoteFunctions()
    var booksArray = [Books]()
    var selectedBookArray = [Books]()
    var booksRecord =  Books()
    var recordArray = [CKRecord]()
    var allRecords: [CKRecord] = []
    
// segue values
    var firstIn: String?
    var lastIn: String?
    
    
    
    public typealias YourFetchCompletionHandler = (_ records: [CKRecord]?, _ cursor: CKQueryCursor?) -> (Void)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if saveBookArray.count == 0 {
            fetchBooks()
        } else {
            booksArray = saveBookArray
            self.selectedBookArray = self.booksArray.filter({return $0.authorLast == self.lastIn})
                self.tableView.reloadData()
            print("array already loaded")
        }
    }
    
    
    
    @IBAction func load(_ sender: Any) {
//    self.tableView.reloadData()
//          booksArray.sort(by: {$0.authorLast < $1.authorLast})
//        if booksArray.count != 0 {
//            print("array already loaded \(booksArray.count) ")
//        }
   print(saveBookArray)
    }
    
    
    
    
    
    
    func fetchBooks(_ cursor: CKQueryCursor? = nil) {
        print("fetch Books:  \(cursor)")
        let cloudContainer = CKContainer.default()
        let privateDatabase = cloudContainer.privateCloudDatabase
        var operation: CKQueryOperation!
        if let cursor = cursor {
            operation = CKQueryOperation(cursor: cursor)
        } else {
            
             let predicate =   NSPredicate(value: true)
//            let predicate = NSPredicate(format: "authorLast = %@", lastIn!)
            
            let query = CKQuery(recordType: RemoteFunctions.RemoteRecords.booksDB, predicate: predicate)
            operation = CKQueryOperation(query: query)
        }
        operation.recordFetchedBlock = {
            (record) in
            self.allRecords.append(record)
            self.booksRecord.authorFirst  = ((record.object(forKey: "authorFirst" ) as! NSString) as String)
            self.booksRecord.authorLast  = ((record.object(forKey:   "authorLast") as! NSString) as String)
            self.booksRecord.title  = ((record.object(forKey:   "title") as! NSString) as String)
             self.booksRecord.series  = ((record.object(forKey: "series") as! NSString) as String)
              self.booksRecord.fullName  = ((record.object(forKey: "fullName") as! NSString) as String)
            self.booksRecord.status  = ((record.object(forKey: "status") as! NSString) as String)
            self.booksRecord.pixURL  = ((record.object(forKey: "pixURL") as! NSString) as String)
            self.booksRecord.format  = ((record.object(forKey: "format") as! NSString) as String)
            self.booksRecord.rating  = ((record.object(forKey: "rating") as! Int) as Int)
            //
            self.booksArray.append(self.booksRecord)
            //print(self.booksRecord)
            
        }
        
        
        operation.queryCompletionBlock = {
            (cursor, error) in
            if let error = error {
              print(error.localizedDescription)
            } else if let cursor = cursor {
                self.fetchBooks(cursor)
               // print("cursor has more")
            } else {
                print("complete")
                DispatchQueue.main.async {
                    self.selectedBookArray = self.booksArray.filter({return $0.authorLast == self.lastIn})
                    
                    saveBookArray = self.booksArray
                    print(self.selectedBookArray)
                    self.tableView.reloadData()
                }
            }
        }
        privateDatabase.add(operation)
    }
    
    
   
    
    
 
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return booksArray.count
        return selectedBookArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let bookRow = self.selectedBookArray[indexPath.row]
        // let bookRow = self.booksArray[indexPath.row]
        cell.textLabel?.text = (" \(bookRow.title)")
        cell.detailTextLabel?.text = ("Author: \(bookRow.authorLast),  \(bookRow.authorFirst)")
        return cell
    }
     
    
}

