//
//  MarsViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/27/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Nuke

class MarsViewController: UIViewController {
    
    var marsArray: [MarsPhoto] = []
    var randomIndex = 0
    let networkCall = NetworkManager()
    var photosArray: [UIImage] = []
    var isDoneLoading = false

    @IBOutlet weak var marsImage: UIImageView!
    @IBOutlet weak var marsImage2: UIImageView!
    @IBOutlet weak var marsImage3: UIImageView!
    @IBOutlet weak var marsImage4: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        networkRequest()
    }


    
  
    func networkRequest() {
        
      
        networkCall.fetchMarsRover { ( fetchedInfo, error) in
            print(self.marsArray.count)
            
            if let fetchedInfo = fetchedInfo {
                
                self.marsArray = fetchedInfo
            }
            OperationQueue.main.addOperation {
              
                self.isDoneLoading = true
                self.collectionView.reloadData()
            }
            
            
        }
    }



}

extension MarsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        
        
      //  cell.imageView.image = nil
        
        
        
        if isDoneLoading == true {
            let item = marsArray[indexPath.row].imageUrl
        Manager.shared.loadImage(with: URL(string: item)!, into: cell.imageView)
        }
    
        return cell
    }
    
    
 
}


