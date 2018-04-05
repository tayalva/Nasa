//
//  MarsDetailViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/28/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Nuke
import MessageUI

class MarsDetailViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    var marsArray: [MarsPhoto] = []
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    textField.delegate = self
        
        let item = marsArray[index].imageUrl
        Manager.shared.loadImage(with: URL(string: item)!, into: imageView)
    }


    @IBAction func addTextButton(_ sender: Any) {
        let item = marsArray[index].imageUrl
        Manager.shared.loadImage(with: URL(string: item)!, into: imageView)
        
       imageView.image = textToImage(drawText: textField.text!, inImage: imageView.image!, atPoint: CGPoint(x: 20, y: 20))
    }
    
 // emails the postcard to any email you want (only works on physcial device!)
    @IBAction func emailButton(_ sender: Any) {
        
        if !MFMailComposeViewController.canSendMail() {
            print("Darn. You can't send mail from this device")
            
            let alert = UIAlertController(title: "Ruh Roh!", message: "Your device doesn't allow for email to be sent!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dang", style: .default) { action in
                
            })
            
            self.present(alert, animated: true, completion: nil)
            
            return 
        } else {
            let imageData: Data = UIImagePNGRepresentation(imageView.image!)!
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["tay.smith@me.com"])
            mail.setSubject("Incoming from Mars!")
            mail.setMessageBody("<p>Here's a postcard from Mars!<p>", isHTML: true)
            mail.addAttachmentData(imageData, mimeType: "image", fileName: "Postcard")
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

}










