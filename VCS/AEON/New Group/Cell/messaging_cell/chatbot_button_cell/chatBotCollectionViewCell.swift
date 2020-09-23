//
//  chatBotCollectionViewCell.swift
//  AEONVCS
//
//  Created by Ant on 16/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class chatBotCollectionViewCell: UICollectionViewCell {
   
   
    @IBOutlet weak var cellBackground: CardView!
    @IBOutlet weak var questionBtnLabel: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    let chatbotInfo = [ChatBotInfo]()
    var chatBotList: [ChatBotInfo] = []
    var button: Int = 0
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        update()
    }
    @IBAction func questionBtn(_ sender: UIButton) {
        print(sender.tag)
    }
    
    func setData(chatBotInfor: ChatBotInfo){
        self.questionLabel.text = chatBotInfor.question
    
    }
    func update(){
        cellBackground.backgroundColor = UIColor(red: 169, green: 27, blue: 88)
        
        self.questionBtnLabel.setTitle("message.ask".localized, for: UIControl.State.normal)
    }
//    func questionAndAnswerId(id: Int) {
//        button = id
//    }
}
