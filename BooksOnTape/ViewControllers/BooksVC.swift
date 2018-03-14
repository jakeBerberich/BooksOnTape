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


    var booksArray = [Books]()
    
    
    
    
    override func viewDidLoad() {
        
          super.viewDidLoad()
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RemoteFunctions.RemoteRecords.booksDB, predicate: predicate)
        ConnectionsDB.share.privateDB.perform(query, inZoneWith: nil  ) {
            records, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print(records?.count)
                for record in records! {
                    print(record.object(forKey: "title"))
                }
                
                OperationQueue.main.addOperation {
                    print(records?.count)
                
            }
            }
       
        }
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

