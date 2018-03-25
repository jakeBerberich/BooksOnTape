//
//  AuthorsVCTableViewController.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/10/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//
import Foundation
import UIKit
import CloudKit

class AuthorsVC: UITableViewController {
    
    var allRecords: [CKRecord] = []
 
    var authorRecord = Authors()
    
    var authorsArray = [Authors]()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
  
    }
    @IBAction func loadSubfile(_ sender: Any) {
           self.tableView.reloadData()
        loadAuthorArray()
        print(authorsArray.count)
        for authors in authorsArray {
            print(authors.last)
        }
    }
    
    func getData() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RemoteFunctions.RemoteRecords.authorsDB, predicate: predicate)
        let sort = NSSortDescriptor(key: "last", ascending: true)
        query.sortDescriptors = [sort]
        let operation = CKQueryOperation(query: query)
        let cloudContainer = CKContainer.default()
        let privateDatabase = cloudContainer.privateCloudDatabase
        
        operation.queuePriority = .veryHigh
        
        
        operation.recordFetchedBlock = { (record: CKRecord) in
            self.allRecords.append(record)
   
            print(record)
        }
        
        operation.queryCompletionBlock =  {
            cursor, error in
            if error !=  nil {
                print(error!.localizedDescription)
            } else {
                if cursor != nil {
                    print("total First records: \(self.allRecords.count)")
                    self.queryServer(cursor!)
                }
            }
        }
        privateDatabase.add(operation)
    }
    
    
    func queryServer(_ cursor: CKQueryCursor) {
        let operation = CKQueryOperation(cursor: cursor)
        let cloudContainer = CKContainer.default()
        let privateDatabase = cloudContainer.privateCloudDatabase
        
        operation.recordFetchedBlock = { (record: CKRecord) in
            self.allRecords.append(record)
            // print(record)
        }
        operation.queryCompletionBlock = {
            cursor, error in
            if error !=  nil {
                print(error!.localizedDescription)
            } else {
                if cursor != nil {
                    print("total records: \(self.allRecords.count)")
                    self.queryServer(cursor!)
                }
            }
        }
        privateDatabase.add(operation)
        
    }
    
    func loadAuthorArray () {
        for record in allRecords {
            
            authorRecord.authorID = (record.object(forKey: "authorID") as? Int)!
            authorRecord.first = (record.object(forKey: "first" ) as? String!)!
            authorRecord.last = (record.object(forKey: "last") as? String)!
            authorRecord.rating = (record.object(forKey: "rating") as? Int)!
            authorRecord.recentBooks = (record.object(forKey: "recentBooks") as? String)!
            authorRecord.deceased = (record.object(forKey: "deceased") as? String)!
            authorRecord.link = (record.object(forKey: "link") as? String)!
            authorRecord.authorPixAddress = (record.object(forKey: "authorPixAddress") as? String)!
            authorsArray.append(authorRecord)
            self.tableView.reloadData()
            print(authorsArray[0].first)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let showBooks  = UIContextualAction(style: .normal, title: "Show Books")  { (action, view, nil) in
            print("ShowBooks")
            
        }
        showBooks.backgroundColor = #colorLiteral(red: 0.09916844219, green: 0.277671814, blue: 0.9211903811, alpha: 1)
        
        let swipeConfig =  UISwipeActionsConfiguration(actions: [showBooks])
        swipeConfig.performsFirstActionWithFullSwipe = false
        return swipeConfig
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return authorsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

          let authorRow = self.authorsArray[indexPath.row]
        cell.textLabel?.text = (" \(authorRow.last), \(authorRow.first)")
        cell.detailTextLabel?.text = ("Rating: \(authorRow.rating)")
        return cell
    }


   
}
