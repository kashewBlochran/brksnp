//
//  ViewController.swift
//  barksnap
//
//  Created by matt on 1/9/17.
//  Copyright © 2017 BoulevardLabs. All rights reserved.
//

import UIKit
import CameraManager
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var cameraButton: UIView!
    let cameraManager = CameraManager()
    
    @IBOutlet weak var helpText: UILabel!
    
    let myAttribute = [
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeColorAttributeName: UIColor.black,
        NSStrokeWidthAttributeName: -1.0
        ] as [String : Any]
    
    var myAttrString: NSAttributedString!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //help text
         myAttrString = NSAttributedString(string: "Press and hold!", attributes: myAttribute)
        helpText.attributedText = myAttrString
        
        //camera
        cameraManager.showAccessPermissionPopupAutomatically = true
        addCameraToView()
        
        //animation
//        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
//        pulseAnimation.duration = 1.0
//        pulseAnimation.toValue = NSNumber(value: 1.0)
//        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        pulseAnimation.autoreverses = true
//        pulseAnimation.repeatCount = FLT_MAX
//        
//        self.helpText.layer.add(pulseAnimation, forKey: nil)
    
    }

    var player: AVAudioPlayer?
    
    func playSound() {
        let url = Bundle.main.url(forResource: "whistle", withExtension: "wav")!
        
        //from site
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        cameraManager.resumeCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.stopCaptureSession()
    }
    
    
    fileprivate func addCameraToView()
    {
        
        print(cameraManager.addPreviewLayerToView(self.cameraView))
        
    }
    @IBAction func buttonDown(_ sender: UIButton) {
        
        print("button pressed")
        playSound()
        myAttrString = NSAttributedString(string: "Release!", attributes: myAttribute)
        helpText.attributedText = myAttrString
        
    }
    
    @IBAction func buttonRelease(_ sender: UIButton) {
        
        print("button released")
        //stop sound
        player?.stop()
        
        helpText.isHidden = true
        
        cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
            if let errorOccured = error {
                self.cameraManager.showErrorBlock("Error occurred", errorOccured.localizedDescription)
            }
            else {
                let vc: ImageViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageViewController
                if let validVC: ImageViewController = vc {
                    if let capturedImage = image {
                        validVC.image = capturedImage
                        self.navigationController?.pushViewController(validVC, animated: true)
                    }
                }
            }
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
