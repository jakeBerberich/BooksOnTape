//
//  GetFromCloudKit.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/18/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//  https://blog.frozenfirestudios.com/cloudkit-operations-319523a2a6d3

import UIKit
import CloudKit

class GetFromCloudKit: UIViewController {

    
    var allRecords: [CKRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    @IBAction func CloudKitData(_ sender: Any) {
        
        getData()
    }
    
    @IBAction func displayCount(_ sender: Any) {
        print(allRecords)
        print(allRecords.count)
    }
    
    func getData() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RemoteFunctions.RemoteRecords.booksDB, predicate: predicate)
        let cloudContainer = CKContainer.default()
        let privateDatabase = cloudContainer.privateCloudDatabase
        let operation = CKQueryOperation(query: query)
        
        operation.queuePriority = .veryHigh
        operation.resultsLimit = 20
        
        operation.recordFetchedBlock = { (record: CKRecord) in
            self.allRecords.append(record)
             print(record)
        }
        operation.queryCompletionBlock = {[weak self] (cursor: CKQueryCursor?, error: NSError?) in
            // There is another batch of records to be fetched
            print("completion block called with \(String(describing: cursor))")
          
            if let cursor = cursor  {
                let newOperation = CKQueryOperation(cursor: cursor)
                newOperation.recordFetchedBlock = operation.recordFetchedBlock
                newOperation.queryCompletionBlock = operation.queryCompletionBlock
               newOperation.resultsLimit = 10
                privateDatabase.add(newOperation)
                print("more records")
            }
                // There was an error
            else if let error = error {
                print("Error:", error)
            }
                
                // No error and no cursor means the operation was successful
            else {
                print("Finished with records:")
            }
            } as? (CKQueryCursor?, Error?) -> Void
            
//
    privateDatabase.add(operation)
        
    }

}
