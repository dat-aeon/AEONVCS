//
//  OtherImageTableViewCell.swift
//  AEONVCS
//
//  Created by Ant on 05/05/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import Kingfisher

class OtherImageTableViewCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

   
    @IBOutlet weak var otherTitleLabel: UILabel!
    @IBOutlet weak var collectionImageView: UICollectionView!
        var isPreviewing = false
        var imagefilename = ""
        var imagefiles = [String]()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print(imagefiles)
        print(imagefilename)
        // Configure the view for the selected state
    }
    var imageArray = [String] ()
       override func awakeFromNib() {
           super.awakeFromNib()
       
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        let flowLayout = UICollectionViewFlowLayout.init()
            flowLayout.itemSize = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
            flowLayout.scrollDirection = .horizontal
            self.collectionImageView?.collectionViewLayout = flowLayout

           self.collectionImageView.delegate = self
           self.collectionImageView.dataSource = self

         //  imageArray = ["1.jpeg","2.jpeg","3.jpeg","4.jpeg","5.jpeg","6.jpeg","7.jpeg","8.jpeg","9.jpeg","10.jpeg","1.jpeg"]
           // Initialization code
        
       }


       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imagefiles.count
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if let cell: OtherCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCollectionViewCell", for: indexPath) as? OtherCollectionViewCell
           {
            
            var imgString = ""
                               if self.imagefiles.count > 0 {
                                otherTitleLabel.text = "application_data.othernationality".localized
                                   for i in imagefiles {
                                       imgString = i
                                    
                                   }
               //                    imgString = self.imagefiles[2]
                               }
                       
                               if !self.isPreviewing {
                                 otherTitleLabel.text = "application_data.othernationality".localized
                                   if let urlstring = URL(string: imgString) {
                                       DispatchQueue.main.async {
                                        
                                        cell.images.kf.indicatorType = .activity
                                        
                                        cell.images.kf.setImage(with: URL(string: "\(self.imagefiles[indexPath.row])"))
                                        if self.imagefiles[indexPath.row] == nil {
                                            cell.images.image = UIImage(named: "sad_cloud_dark.png")
                                        }
                                      
                                       }
                                      
                                       
                                   }
                               } else {
                                   if imgString != "" {
                                     otherTitleLabel.text = "application_data.othernationality".localized
                                    DispatchQueue.main.async {
                                                                           
                                   cell.images.kf.indicatorType = .activity
                                                                           
                               cell.images.kf.setImage(with: URL(string: "\(self.imagefiles[indexPath.row])"))
                                if self.imagefiles[indexPath.row] == nil {
                               cell.images.image = UIImage(named: "sad_cloud_dark.png")
                                                                           }
                                                                         
                                                                          }
                                }
//                                       let imageData = NSData(base64Encoded: imgString, options: .ignoreUnknownCharacters)
//                                       let img = UIImage(data: imageData! as Data)
//
//                                    cell.images.image = img
//                                   } else {
//
//                                        cell.images.image = UIImage(named: "sad_cloud_dark.png")
//                                   }
                               }
           
              // let randomNumber = Int(arc4random_uniform(UInt32(imageArray.count)))
              // cell.images.image = UIImage(named: imageArray[randomNumber])
           // cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.size.width, height: cell.frame.size.height / 2)
            
               return cell
            
           
           }
        
           return UICollectionViewCell()
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
       
//        let padding: CGFloat = 25
//          let collectionCellSize = collectionView.frame.size.width - padding
        let size = CGSize(width: collectionView.frame.size.width / 2, height:  collectionView.frame.size.height)
           return size
       }
   
}
