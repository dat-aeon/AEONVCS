//
//  PhotoTakingViewController.swift
//  AEON
//
//  Created by Mobile User on 1/29/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class PhotoTakingViewController: UIViewController {

    @IBOutlet weak var btnTakePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.btnTakePhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickTakePhoto)))
    }
    
    @objc func onClickTakePhoto(){
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SecQuestConfirmViewController") as! UINavigationController
        self.present(navigationVC, animated: true, completion: nil)
    }


}
