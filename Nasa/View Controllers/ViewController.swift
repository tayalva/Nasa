//
//  ViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/22/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Nuke
import MessageUI



class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
      let networkCall = NetworkManager()
      var apodPhoto: ApodImage!

    
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var savePhotoButton: UIButton!
    @IBOutlet weak var emailPhotoButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
   
       errorLabel.isHidden = true
        networkRequest()
        
     
    }

    @IBAction func saveImageButton(_ sender: Any) {
        
        let imageData = UIImagePNGRepresentation(imageView.image!)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        
        savedLabel.alpha = 1.0
        
        UIView.animate(withDuration: 3, animations: {
            
            self.savedLabel.alpha = 0.0
            })
        
    }
    
    
    @IBAction func emailButton(_ sender: Any) {
        
        if !MFMailComposeViewController.canSendMail() {
            
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
            mail.setSubject("Today's APOD image from NASA!")
            mail.setMessageBody("<p>I thought you would enjoy this!<p>", isHTML: true)
            mail.addAttachmentData(imageData, mimeType: "image", fileName: "Postcard")
            present(mail, animated: true)
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
            
            OperationQueue.main.addOperation {
                
                self.errorLabel.isHidden = true
                self.photoLabel.isHidden = false
                self.savePhotoButton.isHidden = false
                self.emailPhotoButton.isHidden = false 
                Manager.shared.loadImage(with: URL(string: self.apodPhoto.hdurl)!, into: self.imageView)
                self.photoLabel.text = self.apodPhoto.title
            }
                
                
            } else {
                self.photoLabel.isHidden = true
                self.errorLabel.isHidden = false
                self.savePhotoButton.isHidden = true
                self.emailPhotoButton.isHidden = true
                
            }
            
        }
    }


}


