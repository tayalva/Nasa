//
//  ViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/22/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let mars = MarsPhoto(imageUrl: "url dude", date: "date")
        
        print(mars)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

