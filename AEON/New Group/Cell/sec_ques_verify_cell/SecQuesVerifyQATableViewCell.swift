//
//  SecQuesVerifyQATableViewCell.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 6/13/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesVerifyQATableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var secQuesView: UIView!
    @IBOutlet weak var lbQuesNo: UILabel!
    @IBOutlet weak var ivQuestion: UIView!
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var lbAnsNo: UILabel!
    @IBOutlet weak var tfAnswer: UITextField!
    @IBOutlet weak var lbMessage: UILabel!
    
    // Error message Language control
    var answerMesgLocale : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ivQuestion.layer.borderWidth = 1
        self.ivQuestion.layer.cornerRadius = 4 as CGFloat
        self.ivQuestion.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        self.tfAnswer.delegate = self
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapRecognizer)
        
        
    }

    @objc func didTapView() {
        contentView.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data:UserQAList , err_message: String, answerCount : Int) {
        
        switch Locale.currentLocale {
        case .MY:
            self.lbQuestion.text = data.questionMM
            if err_message == Messages.ANSWER_LENGTH_ERROR {
                self.lbMessage.text = Messages.ANSWER_LENGTH_ERROR.localized + "\(answerCount)" + Messages.ANSWER_LENGTH_ERROR_MM.localized
            }
            break
        case .EN:
            self.lbQuestion.text = data.questionEN
            if err_message == Messages.ANSWER_LENGTH_ERROR {
                self.lbMessage.text = Messages.ANSWER_LENGTH_ERROR.localized
                
            }
            break
        }
    }
}
