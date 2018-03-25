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
}
