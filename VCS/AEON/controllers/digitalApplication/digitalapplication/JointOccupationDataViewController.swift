//
//  JointOccupationDataViewController.swift
//  testmaterial
//
//  Created by Ant on 10/01/2021.
//

import UIKit

class JointOccupationDataViewController: BaseUIViewController {

   
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var svLoanConfirmation: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.backBtn.isUserInteractionEnabled = true
        self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        
    }
    @objc override func keyboardWillChange(notification : Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification {
            svLoanConfirmation.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)

        } else {
            svLoanConfirmation.contentInset = UIEdgeInsets.zero
        }
        svLoanConfirmation.scrollIndicatorInsets = svLoanConfirmation.contentInset
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func nextBtnPress(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "AttachmentsViewController") as! AttachmentsViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
//    let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "AttachmentsViewController") as! AttachmentsViewController
//    navigationVC.modalPresentationStyle = .overFullScreen
//    self.present(navigationVC, animated: true, completion: nil)

}
