//
//  RoundLabel.swift
//  AEONVCS
//
//  Created by Ant on 06/04/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class RoundLabel: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 0{ 
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
