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
    @IBOutlet weak var textField: UITextField!
    
    
    var marsArray: [MarsPhoto] = []
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     print(index)
        
        let item = marsArray[index].imageUrl
        Manager.shared.loadImage(with: URL(string: item)!, into: imageView)
    }


    @IBAction func addTextButton(_ sender: Any) {
        let item = marsArray[index].imageUrl
        Manager.shared.loadImage(with: URL(string: item)!, into: imageView)
        
       imageView.image = textToImage(drawText: textField.text!, inImage: imageView.image!, atPoint: CGPoint(x: 20, y: 20))
        
        
    }
    
// Method to overlay text onto the image
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        
        
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 40)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
