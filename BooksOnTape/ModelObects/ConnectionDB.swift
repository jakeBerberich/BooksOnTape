//
//  ConnectionDB.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/12/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import Foundation
import CloudKit

class ConnectionsDB {
    
    static let share = ConnectionsDB()
    
    var container: CKContainer
    var publicDB: CKDatabase
    var privateDB: CKDatabase
    var sharedDB: CKDatabase
    
    private init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
        sharedDB = container.sharedCloudDatabase
    }
}
