//
//  MemberCardInfoTwoViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class MemberCardInfoTwoViewController: BaseUIViewController {
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lbMemberNo: UILabel!
    @IBOutlet weak var lblMemberLabel: UILabel!
    @IBOutlet weak var ivBackgroundGif: UIImageView!
    
    var sessionInfo:SessionDataBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let customerType = UserDefaults.standard.string(forKey: Constants.CUSTOMER_TYPE)
        if customerType == Constants.MEMBER {
            //            print("MemberCardInfoTwoViewController:::::::::")
            
            let sessionInfoString = UserDefaults.standard.string(forKey: Constants.SESSION_INFO)
            
            sessionInfo = try? JSONDecoder().decode(SessionDataBean.self, from: JSON(parseJSON: sessionInfoString ?? "").rawData())
            
            var photoPath = Constants.PROFILE_PHOTO_URL
            
            if sessionInfo?.customerNo != nil{
                photoPath += (sessionInfo?.photoPath)!
                let photoUrl = URL(string: photoPath)
                //                print("MemberCardInfoTwoViewController photo URL \(String(describing: photoUrl))")
                self.ivProfile.kf.indicatorType = .activity
                self.ivProfile.kf.setImage(with: photoUrl)
                
            }
            
            print("memberNoValid : \(sessionInfo?.memberNoValid)")
            self.lblMemberLabel.text = "membership.card2.photo.label".localized
            self.lbMemberNo.text = sessionInfo!.memberNoValid! ? "\(sessionInfo?.memberNo ?? "")" : ""
            
            //self.ivBackgroundGif.loadGif(asset: "Aeon-Animate-1")
            self.ivBackgroundGif.loadGif(asset: "AEON-gif")
        }
    }

    @objc override func updateViews() {
        super.updateViews()
        self.lblMemberLabel.text = "membership.card2.photo.label".localized
        
    }
}
