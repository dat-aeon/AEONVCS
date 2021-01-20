//
//  LoanConfirmationViewController.swift
//  AEONVCS
//
//  Created by Ant on 11/01/2021.
//  Copyright © 2021 AEON microfinance. All rights reserved.
//

import UIKit

class LoanConfirmationViewController: UIViewController {

    @IBOutlet weak var cb1: CheckBox!
    override func viewDidLoad() {
        super.viewDidLoad()

        cb1.style = .square
        cb1.borderStyle = .square
       
        print(cb1.tag)
    }
    @IBAction func nextBtnPress(_ sender: UIButton) {
        print("click")
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplicationDataVC") as! ApplicationDataVC
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    @IBAction func previewBtnView(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
