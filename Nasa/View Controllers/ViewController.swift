//
//  ViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/22/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Nuke




class ViewController: UIViewController {
    
    
      let networkCall = NetworkManager()
      var apodPhoto: ApodImage!
    
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        networkRequest()
        
     
    }

    @IBAction func marsButton(_ sender: Any) {
        
        performSegue(withIdentifier: "showMarsViewController", sender: nil)
        
    }

    @IBAction func earthButton(_ sender: Any) {
        
        performSegue(withIdentifier: "showEarthImageViewController", sender: nil)
    }
    
    
    func networkRequest() {
        
        
        networkCall.fetchApodImage { ( fetchedInfo, error) in
            
            if let fetchedInfo = fetchedInfo {
                
                self.apodPhoto = fetchedInfo
            }
            OperationQueue.main.addOperation {
                
                Manager.shared.loadImage(with: URL(string: self.apodPhoto.hdurl)!, into: self.imageView)
                self.photoLabel.text = self.apodPhoto.title
            
            }
            
            
        }
    }


}

