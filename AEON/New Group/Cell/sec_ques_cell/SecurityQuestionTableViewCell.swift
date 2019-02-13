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
    @IBOutlet weak var lbQuesNo: UILabel!
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var lbAnsNo: UILabel!
    @IBOutlet weak var tfAnswer: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:SecurityQuestion) {
        self.lbQuesNo.text = "Q" + data.index
        self.lbQuestion.text = data.questionEng
        self.lbAnsNo.text = "Ans"+data.index
    }
}
