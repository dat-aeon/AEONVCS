//
//  MemberAnnoucePopupViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 7/24/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MemberAnnouncePopupViewController: UIViewController {

    @IBOutlet weak var lbAnnounce: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var lbCallNowNotice: UILabel!
    @IBOutlet weak var btnCallNow: UIButton!
    
    var popupDelegate: AnnouncePopupButtonDelegate?
    var checkMemberResponse : CheckMemberResponse?
    var registerBean : RegisterRequestBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPopup), name: Notification.Name(rawValue: "dismissPopupMemberAnnounce"), object: nil)
    }
    
    @IBAction func onClickOkBtn(_ sender: UIButton) {
        popupDelegate?.onClickOkBtn(checkMemberReponse: checkMemberResponse!, registerBean: registerBean!)
    }
    
    @IBAction func onClickCallNow(_ sender: UIButton) {
        popupDelegate?.onClickCallNow()
    }
    
    @objc func dismissPopup() {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

protocol AnnouncePopupButtonDelegate {
    func onClickOkBtn(checkMemberReponse : CheckMemberResponse, registerBean : RegisterRequestBean)
    func onClickCallNow()
    
}
