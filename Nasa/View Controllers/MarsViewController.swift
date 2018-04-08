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
    var cellIndex: Int!

   

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        networkRequest()
        
    }


 // Network request to display an array of the most recent mars rover photos (displayed in a collection view)
  
    func networkRequest() {
        
      
        networkCall.fetchMarsRover { ( fetchedInfo, error) in
            print(self.marsArray.count)
            
            if let fetchedInfo = fetchedInfo {
                
                self.marsArray = fetchedInfo
            
            OperationQueue.main.addOperation {
              self.collectionView.isHidden = false 
                self.isDoneLoading = true
                self.collectionView.reloadData()
            }
            
            } else {
                
                self.collectionView.isHidden = true
            }
        }
    }

    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "marsPhotoDetailSegue" {
        
            let detailVC = segue.destination as! MarsDetailViewController
            
           detailVC.index = cellIndex
            detailVC.marsArray = marsArray
     
        }
     }
    

}


// Collection view delegate methods


extension MarsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        if isDoneLoading == true {
            let item = marsArray[indexPath.row].imageUrl
            
// downloads image from URL into the image view via the Nuke dependecy
        Manager.shared.loadImage(with: URL(string: item)!, into: cell.imageView)
        }
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        
       performSegue(withIdentifier: "marsPhotoDetailSegue", sender: nil)
    }
 
}


