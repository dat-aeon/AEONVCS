//
//  OtherCollectionViewCell.swift
//  AEONVCS
//
//  Created by Ant on 05/05/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit

class OtherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var images: UIImageView!
    var isPreviewing = false
    var imagefilename = ""
    var imagefiles = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func setDatas() {
            var imgString = ""
                    if self.imagefiles.count > 0 {
                        for i in imagefiles {
                            imgString = i
                        }
    //                    imgString = self.imagefiles[2]
                    }
            
                    if !self.isPreviewing {
                        if let urlstring = URL(string: imgString) {
                            DispatchQueue.main.async {
                                self.images.kf.indicatorType = .activity
                                self.images?.kf.setImage(with: urlstring)
                            }
                           
                            
                        }
                    } else {
                        if imgString != "" {
                            let imageData = NSData(base64Encoded: imgString, options: .ignoreUnknownCharacters)
                            let img = UIImage(data: imageData! as Data)
           
                            self.images.image = img
                        } else {
                            
                            self.images.image = UIImage(named: "")
                        }
                    }
                
        }
                func setDataWithoutImage() {
                 
                    self.images.image = UIImage(named: "")
                             
                       
                }
}
