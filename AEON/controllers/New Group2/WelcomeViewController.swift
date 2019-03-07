//
//  WelcomeViewController.swift
//  AEONVCS
//
//  Created by mac on 2/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseUIViewController {

    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lblWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.ivLogo.loadGif(asset: "DIR")
        self.lblWelcome.text = "welcome.label".localized
    }

}
