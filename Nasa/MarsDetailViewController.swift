//
//  MarsDetailViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/28/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Nuke

class MarsDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var marsArray: [MarsPhoto] = []
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     print(index)
        
        let item = marsArray[index].imageUrl
        Manager.shared.loadImage(with: URL(string: item)!, into: imageView)
    }


    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
