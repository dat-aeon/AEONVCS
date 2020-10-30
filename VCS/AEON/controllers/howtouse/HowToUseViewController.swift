//
//  HowToUseViewController.swift
//  AEONVCS
//
//  Created by mac on 2/6/20.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HowToUseViewController: BaseUIViewController {

    @IBOutlet weak var vdoView: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgMMlocale: UIImageView!
    @IBOutlet weak var imgEnglocale: UIImageView!
    
    @IBOutlet weak var lblHowtouseDes: UILabel!
    @IBOutlet weak var lblHowtouseTitle: UILabel!
    
    @IBOutlet weak var lblBarMemberType: UILabel!
    @IBOutlet weak var lblBarPhNo: UILabel!
    @IBOutlet weak var lblBarName: UILabel!
    
    var vdoPath : String = ""
     var logoutTimer: Timer?
    private var playerController: AVPlayerViewController?
    var player = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
       videoCall()
         self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
        
        
        self.lblHowtouseTitle.text = "howtouse.title.label".localized
        self.lblHowtouseDes.text = "howtouse.des.label".localized
         self.lblHowtouseDes.attributedText = Utils.setLineSpacing(data: lblHowtouseDes.text!)
        
        
        
       if (UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME) == nil) {
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
            self.lblBarName.text = ""
            self.lblBarMemberType.text = "Lv.1 : Application user"
        }else{
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                       self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
             self.lblBarMemberType.text = "Lv.2 : Login user"
        }
        
        if lblBarMemberType.text == "Lv.2 : Login user" {
                   print("kms ssssssssss>>>>>>")
             logoutTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
               }
       
    }
    func videoCall() {
        AboutUsViewModel.init().getVideoFilePath(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
                  
                  self.vdoPath = result.data.fileName
            
           //  var vdoUrl = "https://ass.aeoncredit.com.mm/daso/how-to-use-video/\(self.vdoPath)"
            let vdoUrl = Constants.video_url + self.vdoPath
            if self.vdoView.superview != nil {
             
                let videoPlayerURL = AVPlayer(url: URL(string: vdoUrl)!)
                self.player = videoPlayerURL
                self.addVideoPlayer(videoUrl: URL(string: vdoUrl
                    )!, to: self.vdoView)
            }
                  
              }) { (error) in
                  
              }
    }
   @objc func runTimedCode() {
                multiLoginGet()
            // print("kms\(logoutTimer)")
            }
    func multiLoginGet(){
               let customerId = (UserDefaults.standard.string(forKey: Constants.USER_INFO_CUSTOMER_ID) ?? "0")
            var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
           MultiLoginModel.init().makeMultiLogin(customerId: customerId
                   , loginDeviceId: deviceID, success: { (results) in
                 //  print("kaungmyat san multi >>>  \(results)")
                   
                   if results.data.logoutFlag == true {
                       print("success stage logout")
                       // create the alert
                              let alert = UIAlertController(title: "Alert", message: "Another Login Occurred!", preferredStyle: UIAlertController.Style.alert)

                              // add an action (button)
                       alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                           self.logoutTimer?.invalidate()
                           let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: CommonNames.MAIN_NEW_VIEW_CONTROLLER) as! MainNewViewController
                           navigationVC.modalPresentationStyle = .overFullScreen
                           self.present(navigationVC, animated: true, completion:nil)
                           
                       }))

                              // show the alert
                              self.present(alert, animated: true, completion: nil)
                       
                       
                   }
               }) { (error) in
                   print(error)
               }
           }
    @objc func onTapBack() {
//        DispatchQueue.main.async {
//            self.player.pause()
//        }
//      print(player.play())
       videoCall()
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
      
        super.NewupdateLocale(flag: 1)
        changeLocale()
    }
    @objc func onTapEngLocale() {
      
        super.NewupdateLocale(flag: 2)
        changeLocale()
    }
    
    func changeLocale()  {
        self.lblHowtouseTitle.text = "howtouse.title.label".localized
        self.lblHowtouseDes.text = "howtouse.des.label".localized
    }
    
        
    @IBAction func closeTap(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func addVideoPlayer(videoUrl: URL, to view: UIView) {
            playerController = AVPlayerViewController()
            playerController?.player = AVPlayer(url: videoUrl)
            playerController!.view.frame = view.bounds
    
            view.addSubview(playerController!.view)
        }

}

