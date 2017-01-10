//
//  ImageViewController.swift
//  barksnap
//
//  Created by matt on 1/9/17.
//  Copyright © 2017 BoulevardLabs. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        print("view loaded in imageVC")
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        self.title = "Got'em!"
        
        if let validImage = self.image {
            self.imageView.image = validImage
        }
    
    }
    
    @IBAction func action(_ sender: UIBarButtonItem) {
       
        // image to share
        let shareImage = self.imageView.image
        
        // set up activity view controller
        let imageToShare = [ shareImage! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)

        
    }
    
    
    @IBAction func help(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Alert", message: "Make sure your volume is on! Aim at your dog, press and hold, and release when your dog looks over. Try again!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
