//
//  SecurityQuestionTableViewCell.swift
//  AEON
//
//  Created by Mobile User on 1/26/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecurityQuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var secQuesView: UIView!
    @IBOutlet weak var ivQuestion: UIView!
    @IBOutlet weak var lbQuesNo: UILabel!
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var lbAnsNo: UILabel!
    @IBOutlet weak var tfAnswer: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivQuestion.layer.borderWidth = 1
        self.ivQuestion.layer.cornerRadius = 4 as CGFloat
        self.ivQuestion.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:UserQAList) {
        self.lbQuesNo.text = "Q:"
        self.lbAnsNo.text = "Ans:"
        switch Locale.currentLocale {
        case .MY:
            self.lbQuestion.text = data.questionMM
            break
        case .EN:
            self.lbQuestion.text = data.questionEN
            break
        }
        self.tfAnswer.text = data.answer
    }
}
