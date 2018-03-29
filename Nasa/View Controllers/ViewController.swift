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
       
        
     
    }

    @IBAction func marsButton(_ sender: Any) {
        
        performSegue(withIdentifier: "showMarsViewController", sender: nil)
        
    }

    @IBAction func earthButton(_ sender: Any) {
        
        performSegue(withIdentifier: "showEarthImageViewController", sender: nil)
    }
    


}

