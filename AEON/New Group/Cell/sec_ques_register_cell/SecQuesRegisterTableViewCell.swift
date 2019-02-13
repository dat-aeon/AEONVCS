//
//  SecQuesRegisterTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesRegisterTableViewCell: UITableViewCell {

    @IBOutlet weak var vsecQuesList: UIView!
    @IBOutlet weak var lblSecQuestion: UILabel!
    @IBOutlet weak var tfsecAnswer: UITextField!
    
    var secQuesList = ["1","2","3","4","5"]
    var selectedQues = "0"
    var questionList = [[String]]()
    var secQMy = [String]()
    var secQEng = [String]()
    
    var delegate: SecQuesRegisterDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.vsecQuesList.layer.borderWidth = 1
        self.vsecQuesList.layer.cornerRadius = 4 as CGFloat
        self.vsecQuesList.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
        
        
        self.vsecQuesList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickSecQuesList)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:[[String]]) {
        self.questionList = data
        
    }
    
    @objc func onClickSecQuesList(){
        let action = UIAlertController.actionSheetWithItems(items: secQuesList, currentSelection: selectedQues, action: { (value)  in
                self.selectedQues = value
            
                self.lblSecQuestion.text = self.selectedQues
                print(value)
            })
            action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            //Present the controller
           //self.present(action, animated: true, completion: nil)
        self.window?.rootViewController?.present(action, animated: true, completion: nil)
        
    }
}

protocol SecQuesRegisterDelegate {
    func onClickSecQuesList(secQuestion:String?, secAnswer:String?)
}
