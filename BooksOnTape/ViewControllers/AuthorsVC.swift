//
//  AuthorsVCTableViewController.swift
//  BooksOnTape
//  https://www.youtube.com/watch?v=RSxfGGdA8QE

// https://www.youtube.com/watch?v=NolPQP2E1O0//  Created by Jake Berberich on 3/10/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//
import Foundation
import UIKit
import CloudKit

class AuthorsVC: UITableViewController {
    
    var allRecords: [CKRecord] = []
 
    var authorRecord = Authors()
    
    var authorsArray = [Authors]()
    var selectedIndex: IndexPath = [0,0]
    var segueFirst: String = "jake"
    var segueLast: String = "berberich"
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAuthors()
    
  
    }
    @IBAction func loadSubfile(_ sender: Any) {
           self.tableView.reloadData()
        loadAuthorArray()
        print(authorsArray.count)
        for authors in authorsArray {
            print(authors.last)
        }
    }
    
    func fetchAuthors(_ cursor: CKQueryCursor? = nil) {
        let cloudContainer = CKContainer.default()
        let privateDatabase = cloudContainer.privateCloudDatabase
        var operation: CKQueryOperation!
        let predicate = NSPredicate(value: true)
       // let query = CKQuery(recordType: RemoteFunctions.RemoteRecords.authorsDB, predicate: predicate)
      
        if let cursor = cursor {
            operation = CKQueryOperation(cursor: cursor)
        } else {
            
            let predicate =   NSPredicate(value: true)
            
            let query = CKQuery(recordType: RemoteFunctions.RemoteRecords.authorsDB, predicate: predicate)
            operation = CKQueryOperation(query: query)
        }
        
        operation.recordFetchedBlock = { (record: CKRecord) in
            self.allRecords.append(record)
            print(record)
        }
        
        operation.queryCompletionBlock =  {
            cursor, error in
            if let error = error {
                print(error.localizedDescription)
            } else  if let cursor = cursor {
                    self.fetchAuthors(cursor)
                    print("cursor has more Authors")
            } else {
                        print("all Authors Retrieved")
                        DispatchQueue.main.async {
                            self.loadAuthorArray()
                            self.tableView.reloadData()
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
        }
        authorsArray.sort(by: {$0.last < $1.last})
    }
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showBooks" {
    print("segue fired")
        // print(booksArray)
        let indexPath = self.tableView.indexPathForSelectedRow
        let destinationVC = segue.destination as! BooksVC
       
        destinationVC.firstIn = segueFirst
        destinationVC.lastIn = segueLast
        
    }
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let showBooks = UITableViewRowAction(style: .default, title: "Show Books") {(action, index) in
            print ("index \(index)")
            print("\(self.authorsArray[indexPath.row].last)")
            self.selectedIndex = indexPath
            self.segueLast = self.authorsArray[indexPath.row].last
            self.segueFirst = self.authorsArray[indexPath.row].first
            self.performSegue(withIdentifier: "showBooks", sender: self)
        }
        showBooks.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return[showBooks]
    }
    
    
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let showBooks  = UIContextualAction(style: .normal, title: "Show Books")  { (action, view, nil) in
//            print("ShowBooks")
//        }
//   showBooks.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//    let config = UISwipeActionsConfiguration(actions: [showBooks])
//        config.performsFirstActionWithFullSwipe = false
//        return config
//    }
   
}
