//
//  EarthImageViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/29/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Nuke

class EarthImageViewController: UIViewController {
    
    let networkCall = NetworkManager()
    var earthPhoto: EarthImage!

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        networkRequest()
    }

    func networkRequest() {
        
        
        networkCall.fetchEarthImage(latitude: 33.655659, longitude: -118.003581, completion: {
            (fetchedInfo, error) in
         
            
            if let fetchedInfo = fetchedInfo {
                
                self.earthPhoto = fetchedInfo
            }
            OperationQueue.main.addOperation {
                
                
                Manager.shared.loadImage(with: URL(string: self.earthPhoto.url)!, into: self.imageView)
              
            }
            
            
        }
    )}
    



}
