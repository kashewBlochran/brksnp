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
    var watermarkedImage: UIImage?
    @IBOutlet weak var toolbar: UIToolbar!
    override func viewDidLoad() {
        
        print("view loaded in imageVC")
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 73.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        

        
        self.toolbar.barTintColor = UIColor(red: 0.0/255.0, green: 68.0/255.0, blue: 178.0/255.0, alpha: 1.0)

        //self.title = "Got'em!"
        
        //if image is coming in from other VC...
        if let validImage = self.image {
        
        //watermark image...
            watermarkedImage = textToImage(drawText: "Barksnap.com", inImage: validImage, atPoint: CGPoint(x: 20, y: 20))

        //set imageview to valid image
            self.imageView.image = watermarkedImage
        }
    
    }
    
    func textToImage(drawText text: NSString, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 200)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ] as [String : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
