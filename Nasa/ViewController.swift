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
    
    @IBOutlet weak var marsImage: UIImageView!
    var marsArray: [MarsPhoto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        networkRequest()
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let networkCall = NetworkManager()
    func networkRequest() {
        
        networkCall.fetchMarsRover { ( fetchedInfo, error) in
            
            if let fetchedInfo = fetchedInfo {
                
                self.marsArray = fetchedInfo
            }
            OperationQueue.main.addOperation {
                Manager.shared.loadImage(with: URL(string: self.marsArray[0].imageUrl)!, into: self.marsImage)
            }
            

        }
    }
/*
    func downloadImage() {
    
        let imageUrl = URL(string: marsArray[0].imageUrl)
        print(imageUrl)
        let session = URLSession(configuration: .default)
        let downloadTask = session.dataTask(with: imageUrl!) { (data, response, error) in
            
            if let error = error {
                print("Error downloading picture")
            } else {
                
                if let response = response as? HTTPURLResponse {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        
                        OperationQueue.main.addOperation {
                            self.marsImage.image = image
                        }
                      
                    } else {
                        
                        print("not image dummy")
                    }
                }
            }
            
            
            
        }
        
        downloadTask.resume()
    }
*/
}

