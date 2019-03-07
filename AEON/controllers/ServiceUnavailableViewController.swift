//
//  ServiceUnavailableViewController.swift
//  AEONVCS
//
//  Created by mac on 3/6/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class ServiceUnavailableViewController: UIViewController {

    @IBOutlet weak var bbClose: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onClickCloseBtn(_ sender: UIBarButtonItem) {
//        weak var pvc = self.presentingViewController
//        self.dismiss(animated: true, completion: {
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            
       // })
    }
}
