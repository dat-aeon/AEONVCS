//
//  LoanChooseViewController.swift
//  AEONVCS
//
//  Created by Ant on 12/08/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class LoanChooseViewController: UIViewController {
    @IBOutlet weak var ploanView: CardView!
    
    @IBOutlet weak var sloanView: CardView!
   // @IBOutlet weak var backImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //backImage.isUserInteractionEnabled = true
       // self.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapBack)))
        self.sloanView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sloan)))
        self.ploanView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ploan)))
        
       
    }
    
    
  
    @objc func ploan() {
      
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PersonalLoanViewController") as! PersonalLoanViewController
       // LoanConfirmationVC
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    @objc func sloan() {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "SmallLoanViewController") as! SmallLoanViewController
       // LoanConfirmationVC
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func onTapBack() {
       print("click")
       
              
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let customViewController = storyboard.instantiateViewController(withIdentifier: "MainLoanApplyViewController") as! MainLoanApplyViewController
        customViewController.modalPresentationStyle = .overFullScreen
        self.present(customViewController, animated: true, completion: nil)
        
    }

}
