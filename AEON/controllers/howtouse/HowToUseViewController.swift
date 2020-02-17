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
    
    private var playerController: AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.imgBack.isUserInteractionEnabled = true
        self.imgMMlocale.isUserInteractionEnabled = true
        self.imgEnglocale.isUserInteractionEnabled = true
        
         self.imgBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.imgMMlocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapMMLocale)))
        self.imgEnglocale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapEngLocale)))
        
        
        self.lblHowtouseTitle.text = "howtouse.title.label".localized
        self.lblHowtouseDes.text = "howtouse.des.label".localized
         self.lblHowtouseDes.attributedText = Utils.setLineSpacing(data: lblHowtouseDes.text!)
        
        AboutUsViewModel.init().getVideoFilePath(siteActivationKey: Constants.SITE_ACTIVATION_KEY, success: { (result) in
                  
                  self.vdoPath = result.data.fileName
            
             var vdoUrl = "https://ass.aeoncredit.com.mm/daso/how-to-use-video/\(self.vdoPath)"
            
            if self.vdoView.superview != nil {
                self.addVideoPlayer(videoUrl: URL(string: vdoUrl
                    )!, to: self.vdoView)
            }
                  
              }) { (error) in
                  
              }
        
       if (UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME) == nil) {
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.FIRST_TIME_PHONE)
            self.lblBarName.text = ""
            self.lblBarMemberType.text = "Lv.1 : Application user"
        }else{
            self.lblBarPhNo.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_PHONE_NO)
                       self.lblBarName.text = UserDefaults.standard.string(forKey: Constants.USER_INFO_NAME)
             self.lblBarMemberType.text = "Lv.2 : Login user"
        }
       
    }
    
    @objc func onTapBack() {
       print("click")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onTapMMLocale() {
       print("click")
        super.NewupdateLocale(flag: 1)
        changeLocale()
    }
    @objc func onTapEngLocale() {
       print("click")
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

