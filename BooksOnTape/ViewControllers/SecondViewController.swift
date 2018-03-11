//
//  SecondViewController.swift
//  BooksOnTape
//
//  Created by Jake Berberich on 3/6/18.
//  Copyright © 2018 Jake Berberich. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var urlName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
  var urlKey = "https://images-na.ssl-images-amazon.com/images/I/41xmArru3rL.SX316.SY316.jpg"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   

    @IBAction func openURL(_ sender: Any) {
        if let url = URL(string: urlKey)
        {
            do{
                let data = try Data(contentsOf: url)
                self.imageView.image = UIImage(data: data)
            }
            catch let err{
                print("error : \(err.localizedDescription)")
            }
        }    }
    
}

