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
        ivDropdown?.rotate(collapsed ? .pi : 0.0)
    }
    
    func setData(faqItem:FAQItem){
        self.faqItem = faqItem
        setCollapsed(collapsed: faqItem.isCollapsed)
        self.lblSubQuestion.text = faqItem.subQuestion
        
        let questionHeight = lblSubQuestion.heightForLabel(text: faqItem.subQuestion, width: self.frame.width)
        
        var questionFrame = self.lblSubQuestion.frame
        questionFrame.size.height = questionHeight
        self.lblSubQuestion.frame = questionFrame
        
        var questionHeaderFrame = self.lblSubQuestion.superview?.frame
        questionHeaderFrame!.size.height = questionHeight+32
        self.lblSubQuestion.superview?.frame = questionHeaderFrame!
        
        if faqItem.isCollapsed {
            self.lblAnswer.text = faqItem.answer
            let answerHeight = lblAnswer.heightForLabel(text: faqItem.answer, width: self.frame.width)
            
            self.ivDropdown.image = UIImage(named: "collapse")
            self.lblAnswer.isHidden = false
            self.lblAnswer?.visiblity(gone: false, dimension: CGFloat(answerHeight))
            
            var contentFrame = self.frame
            contentFrame.size.height = questionHeight+answerHeight+32
            self.frame = contentFrame
            
        }
        else {
           
            var contentFrame = self.frame
            contentFrame.size.height = questionHeight+32
            self.frame = contentFrame
            
            self.ivDropdown.image = UIImage(named: "expand")
            self.lblAnswer.isHidden = true
            self.lblAnswer?.visiblity(gone: true, dimension: CGFloat(0.0))
            
        }
        self.lblAnswer.layoutIfNeeded()
    }
    
}
protocol UITableViewCellDelegate {
    func toggleItemCell(cell:FAQTableViewCell,section:Int,position:Int,isCollapsed:Bool)
}
