//
//  BooksVC.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/10/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import UIKit

class BooksVC: UITableViewController {


    var booksArray = [Books]()
    
    var jsonEncoder = JSONEncoder()
    var jsonDecoder = JSONDecoder()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnAllBooksJson()
        tableView.reloadData()
        
    }
    
    
    func returnAllBooksJson()  ->([Books])  {
        let path = Bundle.main.path(forResource: "books", ofType: "json")
        let url2 = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url2)
            self.booksArray = try JSONDecoder().decode([Books].self, from: data)
            booksArray.sort(by: {$0.authorLast < $1.authorLast  })
        }
        catch   { print(error.localizedDescription)
        }
        
        
        return (booksArray)
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

