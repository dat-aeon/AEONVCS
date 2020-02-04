//
//  InstallationMainViewController.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 2/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class InstallationMainViewController: BaseUIViewController {

    @IBOutlet weak var vcTermsCondition: UIView!
    @IBOutlet weak var vcLanguage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isFirstOpen:Bool = UserDefaults.standard.bool(forKey: Constants.IS_ALREADY_ACCEPT)

        if isFirstOpen {
            toggleContainer(position: 2)
        } else {
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.MAIN_VIEW_CONTROLLER) as! UINavigationController
            navigationVC.modalPresentationStyle = .overFullScreen
            self.present(navigationVC, animated: true, completion: nil)
        }
    }

    func toggleContainer(position:Int){
        switch position {
        case 1:
            vcTermsCondition.alpha = 1
            vcLanguage.alpha = 0
            break
        case 2:
            vcTermsCondition.alpha = 0
            vcLanguage.alpha = 1
            break
        default:
            vcTermsCondition.alpha = 0
            vcLanguage.alpha = 1
            break
        }
    }
}
