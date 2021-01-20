//
//  JointApplicationDataViewController.swift
//  testmaterial
//
//  Created by Ant on 10/01/2021.
//

import UIKit

class JointApplicationDataVC: BaseUIViewController {

    @IBOutlet weak var agentNameLabel: UILabel!
    @IBOutlet weak var agentNameTf: UITextField!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var agentNameErrorLabel: UILabel!
    
    @IBOutlet weak var svLoanConfirmation: UIScrollView!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    @IBOutlet weak var dateOfBirthTf: UITextField!
    
    @IBOutlet weak var dateOfBirthErrorLabel: UILabel!
    
    
    @IBOutlet weak var NRCNoLabel: UILabel!
    @IBOutlet weak var NRCNoTf: UITextField!
    @IBOutlet weak var NRCErrorLabel: UILabel!
    
    
    @IBOutlet weak var faterNameLabel: UILabel!
    @IBOutlet weak var fatherNameTf: UITextField!
    @IBOutlet weak var fatherNameErrorLabel: UILabel!
    
    
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var educationTf: UITextField!
    
    @IBOutlet weak var educationErrorLabel: UILabel!
    
    
    
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var myanmarLabel: UILabel!
    @IBOutlet weak var myanmarBtnLabel: UIButton!
    
    @IBOutlet weak var noSelectedImageView: UIImageView!
    @IBOutlet weak var otherLabel: UILabel!
    
    @IBOutlet weak var otherBtnPress: UIButton!
    
    @IBOutlet weak var otherDescriptionTf: UITextField!
    
    @IBOutlet weak var otherErrorMessageLabel: UILabel!
    
    
    
    
    
    
    @IBOutlet weak var nextBtnLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtnLabel.layer.cornerRadius = 10
        self.backBtn.isUserInteractionEnabled = true
        self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func nextBtnPress(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "JointOccupationDataViewController") as! JointOccupationDataViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
