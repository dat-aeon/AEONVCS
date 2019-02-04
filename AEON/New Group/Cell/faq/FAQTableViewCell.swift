//
//  FAQTableViewCell.swift
//  AEON
//
//  Created by AcePlus101 on 2/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSubQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var ivDropdown: UIImageView!
    
    var faqItem = FAQItem() {
        didSet {
            //            guard let item = faqItem.isCollapsed else {
            //                return
            //            }
            //            lblFaqMainQuestion?.text = item.question
            //            setCollapsed(collapsed: !faqItem.isCollapsed)
        }
    }
    var section:Int = 0
    var position:Int = 0
    var delegate:UITableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc private func didTapHeader() {
        setCollapsed(collapsed: !faqItem.isCollapsed)
        delegate?.toggleItemCell(cell:self,section: section,position: position,isCollapsed: faqItem.isCollapsed)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    func setCollapsed(collapsed: Bool) {
        //         if faqItem.isCollapsed {
        //            self.lblAnswer.isHidden = false
        //        }else{
        //            self.lblAnswer.isHidden = true
        //        }
        ivDropdown?.rotate(collapsed ? .pi : 0.0)
    }
    
    func setData(faqItem:FAQItem){
        self.faqItem = faqItem
        setCollapsed(collapsed: faqItem.isCollapsed)
        self.lblSubQuestion.text = faqItem.subQuestion
        self.lblAnswer.text = faqItem.answer
        
        let questionHeight = lblSubQuestion.heightForLabel(text: faqItem.subQuestion, width: self.frame.width)
        let answerHeight = lblAnswer.heightForLabel(text: faqItem.answer, width: self.frame.width)
        
        var questionFrame = self.lblSubQuestion.frame
        questionFrame.size.height = questionHeight
        self.lblSubQuestion.frame = questionFrame
        
        var questionHeaderFrame = self.lblSubQuestion.superview?.frame
        questionHeaderFrame!.size.height = questionHeight+32
        self.lblSubQuestion.superview?.frame = questionHeaderFrame!
        //        self.lblAnswer?.visiblity(gone: true, dimension: CGFloat(0.0))
        //
        //        var contentFrame = self.frame
        //        contentFrame.size.height = questionHeight+16
        //        self.frame = contentFrame
        
        if faqItem.isCollapsed {
            //            var labelFrame = self.lblAnswer.frame
            //            labelFrame.size.height = answerHeight
            //            self.lblAnswer.frame = labelFrame
            //
            self.ivDropdown.image = UIImage(named: "collapse")
            //            ivDropdown?.rotate(.pi)
            self.lblAnswer?.visiblity(gone: false, dimension: CGFloat(answerHeight))
            
            var contentFrame = self.frame
            contentFrame.size.height = questionHeight+answerHeight+32
            self.frame = contentFrame
            
        }
        else {
            //            var labelFrame = self.lblAnswer.frame
            //            labelFrame.size.height = 0
            //            self.lblAnswer.frame = labelFrame
            
            var contentFrame = self.frame
            contentFrame.size.height = questionHeight+32
            self.frame = contentFrame
            
            self.ivDropdown.image = UIImage(named: "expand")
            //        ivDropdown?.rotate(0.0)
            self.lblAnswer?.visiblity(gone: true, dimension: CGFloat(0.0))
            
            
        }
    }
    
}
protocol UITableViewCellDelegate {
    func toggleItemCell(cell:FAQTableViewCell,section:Int,position:Int,isCollapsed:Bool)
}
