//
//  ImageViewController.swift
//  barksnap
//
//  Created by matt on 1/9/17.
//  Copyright © 2017 BoulevardLabs. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var bar: UIToolbar!

    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    var watermarkedImage: UIImage?
    @IBOutlet weak var save: UIBarButtonItem!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        let logo = UIImage(named: "barksnap3.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .center
        self.navigationItem.titleView = imageView

        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0)
        
        //bar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0)

        //if image is coming in from other VC...
        if let validImage = self.image {

        //set imageview to valid image
            self.imageView.image = validImage
            
        //watermark...
        self.watermarkedImage = self.textToImage(drawText: "Barksnap.com", inImage: validImage, atPoint: CGPoint(x: 20, y: 20))
        }
    
    }
    
    
    func textToImage(drawText text: NSString, inImage image: UIImage, atPoint point: CGPoint) ->
        UIImage {
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
        
        // set up activity view controller
        let msg = "Snapped with Barksnap, the dog whistle camera app. www.barksnap.com #barksnap"
        
        let sharedObjects:[AnyObject] = [watermarkedImage!, msg as AnyObject]
        
        
        let activityViewController = UIActivityViewController(activityItems: sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)

    }
    
    @IBAction func save(_ sender: Any) {
        
        UIImageWriteToSavedPhotosAlbum(watermarkedImage!, nil, nil, nil);
        let alert = UIAlertController(title: "Alert", message: "Image saved!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: {action in _ = self.navigationController?.popViewController(animated: true) }))
        self.present(alert, animated: true, completion: nil)
        
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
