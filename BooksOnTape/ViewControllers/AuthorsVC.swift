//
//  AuthorsVCTableViewController.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/10/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//
import Foundation
import UIKit

class AuthorsVC: UITableViewController {
    
  
    var authorsArray = [Authors]()
  
    var jsonEncoder = JSONEncoder()
    var jsonDecoder = JSONDecoder()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnAllAuthorsJson()
       tableView.reloadData()
        
    }
    
    
    func returnAllAuthorsJson()  ->([Authors])  {
        let path = Bundle.main.path(forResource: "authors", ofType: "json")
        let url2 = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url2)
            self.authorsArray = try JSONDecoder().decode([Authors].self, from: data)
            authorsArray.sort(by: {($0.rating > $1.rating) && ($0.last <  $1.last) })
                }
        catch   { print("error")
        }
        
     
        return (authorsArray)
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
