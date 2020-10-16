//
//  SecQuesRegisterTableViewCell.swift
//  AEONVCS
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class SecQuesRegisterTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var vsecQuesList: UIView!
    
    //@IBOutlet weak var vsecQuesList: UIView!
    @IBOutlet weak var lblQuesNo: UILabel!
    @IBOutlet weak var lblSecQuestion: UILabel!
    @IBOutlet weak var lblAnsNo: UILabel!
    @IBOutlet weak var tfsecAnswer: UITextField!
    @IBOutlet weak var lbMessage: UILabel!
    
    // Error message Language control
    var answerMesgLocale : String?
    
    
    var secQuesList = [String]()
    var rowIndex: Int = 0
    
    var cellClickDelegate:SecQuesRegisterCellClickDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vsecQuesList.isUserInteractionEnabled = true
//        self.vsecQuesList.layer.borderWidth = 1
//        self.vsecQuesList.layer.cornerRadius = 4 as CGFloat
//        self.vsecQuesList.layer.borderColor = UIColor(red:205.0/255.0, green:205.0/255.0, blue:205.0/255.0, alpha: 1.0).cgColor
//        
//        
        self.vsecQuesList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickSecQuesList)))
        
        self.tfsecAnswer.delegate = self
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
    
    func setData(data:[String],answerCount:Int, row:Int) {
        self.secQuesList = data
        self.rowIndex = row
        
        //self.tfsecAnswer.setMaxLength(maxLength: answerCount)
        
    }
    
    @objc func onClickSecQuesList(){
        cellClickDelegate?.onClickSecQuesList(quesList: secQuesList,cell: self, row: self.rowIndex)
        
    }
}

protocol SecQuesRegisterCellClickDelegate {
    func onClickSecQuesList(quesList:[String],cell:SecQuesRegisterTableViewCell, row: Int)
}
