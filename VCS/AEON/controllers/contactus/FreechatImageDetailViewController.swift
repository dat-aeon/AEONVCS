//
//  FreechatImageDetailViewController.swift
//  AEONVCS
//
//  Created by Ant on 02/06/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import Kingfisher
class FreechatImageDetailViewController: UIViewController {
var urlString = ""
    @IBOutlet weak var imageDetailView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetailView.kf.setImage(with: URL(string: urlString))
    }
    @IBAction func backBtnPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
   
}
