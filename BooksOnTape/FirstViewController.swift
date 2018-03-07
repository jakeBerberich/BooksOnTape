//
//  FirstViewController.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/6/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var booksArray = [Books]()
    var authorsArray = [Authors] ()

    override func viewDidLoad() {
        super.viewDidLoad()
       getJson()
        print(authorsArray)
    }
  

    func getJson() {
        
        let path = Bundle.main.path(forResource: "authors", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        print(url)
        // --------- decode json
        do {
            let data = try Data(contentsOf: url)
            print(data)
            self.authorsArray = try JSONDecoder().decode([Authors].self, from: data)
            
        }
        catch{ print(error.localizedDescription)
        }
        // ----------end decode json
    }  // end get Json
    
    
}

