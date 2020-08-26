//
//  FAQHeaderView.swift
//  AEON
//
//  Created by AcePlus101 on 2/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FAQHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblFaqMainQuestion: UILabel!
    @IBOutlet weak var imgDropDown: UIImageView!
    
    var section = 0
    var delegate:UITableViewHeaderDelegate?
    
    var item: FAQHeaderListItem? {
        didSet {
            guard let item = item else {
                return
            }
            lblFaqMainQuestion?.text = item.question
            //                setCollapsed(collapsed: item.isCollapsed)
            
            //            imgDropDown?.rotate(.pi)
            if item.isCollapsed{
                self.imgDropDown.image = UIImage(named: "collapse")
            }else{
                self.imgDropDown.image = UIImage(named: "expand-small-p-icon")
            }
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setCollapsed(collapsed: Bool) {
        imgDropDown?.rotate(collapsed ? .pi : 0.0)
    }
}


extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
}

protocol UITableViewHeaderDelegate {
    func toggleSection(header:FAQHeaderView,section:Int)
}
