//
//  BooksVC.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/10/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import UIKit
import CloudKit

class BooksVC: UITableViewController {

   let remoteFunctions = RemoteFunctions()
    var booksArray = [Books]()
    var booksRecord =  Books()
    var recordArray = [CKRecord]()
    var allRecords: [CKRecord] = []
  var authorLast = "Child"
    
    @IBAction func load(_ sender: Any) {
    self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let cloudContainer = CKContainer.default()
        let privateDatabase = cloudContainer.privateCloudDatabase
        
        let predicate = NSPredicate(format: "authorLast == %@",  authorLast)
        let query = CKQuery(recordType: RemoteFunctions.RemoteRecords.booksDB, predicate: predicate)
        let sort = NSSortDescriptor(key: "title" , ascending: true)
        query.sortDescriptors = [sort]
        let queryOperation = CKQueryOperation (query: query)
        
        queryOperation.recordFetchedBlock = {
            (record: CKRecord) in
            self.allRecords.append(record)
        }
         
        
     
        queryOperation.recordFetchedBlock = {
            record in
            print(record.object(forKey: "title"))

            self.recordArray.append(record)
            print(self.recordArray.count)

            self.booksRecord.authorFirst  = ((record.object(forKey: "authorFirst" ) as! NSString) as String)
            self.booksRecord.authorLast  = ((record.object(forKey:   "authorLast") as! NSString) as String)
            self.booksRecord.title  = ((record.object(forKey:   "title") as! NSString) as String)

            // self.booksRecord.series  = ((record.object(forKey: "series") as! NSString) as String)
            //  self.booksRecord.fullName  = ((record.object(forKey: "fullName") as! NSString) as String)
            self.booksRecord.status  = ((record.object(forKey: "status") as! NSString) as String)

            self.booksRecord.pixURL  = ((record.object(forKey: "pixURL") as! NSString) as String)
            self.booksRecord.format  = ((record.object(forKey: "format") as! NSString) as String)
            self.booksRecord.rating  = ((record.object(forKey: "rating") as! Int) as Int)
            //
            self.booksArray.append(self.booksRecord)
            print(self.booksRecord)
        }
        
        privateDatabase.add(queryOperation)
        print(self.booksArray)
        
        print("count a loop")
    
    }
    
    
    
 
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return booksArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let bookRow = self.booksArray[indexPath.row]
        cell.textLabel?.text = (" \(bookRow.title)")
        cell.detailTextLabel?.text = ("Author: \(bookRow.authorLast),  \(bookRow.authorFirst)")
        return cell
    }
     
    
}

