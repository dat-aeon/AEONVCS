//
//  cellPurchaseImages.swift
//  AEONVCS
//
//  Created by mac on 11/6/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class cellPurchaseImages: UITableViewCell {
   
     
    var isPreviewing = false
    @IBOutlet weak var cellLbltitle: UILabel!
    var imagefilename = ""
  
    var imagefiles = [String]()
    var photoTitleName = [String]()
    
    @IBOutlet weak var cellimgview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    func setData() {
      
       
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
                            self.cellimgview.kf.indicatorType = .activity
                            if self.photoTitleName.count > 0 {
                                for p in self.photoTitleName {
                                    self.cellLbltitle.textColor = UIColor.black
                                    self.cellLbltitle.text = p.localized
                                }
                            }

                            self.cellimgview?.kf.setImage(with: urlstring)
                      self.cellimgview?.kf.setImage(with: urlstring)

                        }
//                        let dataDecoded:NSData = NSData(base64Encoded: imgString, options: NSData.Base64DecodingOptions(rawValue: 0))!
//                        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
//                        cellimgview.image = decodedimage
                        
                    }
                } else {
//                    if let urlstring = URL(string: imgString) {
//                                          DispatchQueue.main.async {
//                                              self.cellimgview.kf.indicatorType = .activity
//                                            if self.photoTitleName.count > 0 {
//                                                                           for p in self.photoTitleName {
//                                                                               self.cellLbltitle.text = p.localized
//                                                                           }
//                                                                       }
//                                              self.cellimgview?.kf.setImage(with: urlstring)
//                                          }
//
//
//                                      }
//                    let dataDecoded = NSData(base64Encoded: imgString , options: .ignoreUnknownCharacters)
//                    let decodedimage:UIImage = UIImage(data: (dataDecoded as Data?)!)!
//                                           cellimgview.image = decodedimage ?? UIImage(named: "")
                    
                    if imgString != "" {
                        let imageData = NSData(base64Encoded: imgString, options: .ignoreUnknownCharacters)
                        let img = UIImage(data: ((imageData) as? Data)!)

                        self.cellimgview.image = img
                    } else {

                        self.cellimgview.image = UIImage(named: "")
                    }
                }
            
    }
            func setDataWithoutImage() {
             
                self.cellimgview.image = UIImage(named: "")
                         
                   
            }
}
//
//     var collectionView: UICollectionView!
//        var imageview : UIImageView!
//
//        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
//            layout.itemSize = CGSize(width: 100, height: 50)
//    //        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    //        layout.minimumInteritemSpacing = 5.0
//    //        layout.minimumLineSpacing = 5.0
//
//            collectionView = UICollectionView(frame: CGRect(x: 0, y: self.cellLbltitle.frame.origin.y + self.cellLbltitle.frame.size.height + 2, width: self.frame.size.width, height: 50), collectionViewLayout: layout)
//            collectionView.delegate = self
//            collectionView.dataSource = self
//            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//            collectionView.backgroundColor = UIColor.clear
//
//        self.addSubview(collectionView)
//    }
//
//    //    -(id)initWithCoder:(NSCoder *)aDecoder
//    //    {
//    //        self = [super initWithCoder:aDecoder];
//    //        if (self) {
//    //           // Do your custom initialization here
//    //        }
//    //        return self;
//    //    }
//
//
//
//        required init?(coder aDecoder: NSCoder) {
//            super.init(coder: aDecoder)
//
//            let layout = UICollectionViewFlowLayout()
//                layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
//                layout.itemSize = CGSize(width: 200, height: 150)
//
//    //        layout.minimumInteritemSpacing = 5.0
//    //        layout.minimumLineSpacing = 5.0
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
//
//                collectionView = UICollectionView(frame: CGRect(x: 0, y: 60, width: self.frame.size.width, height: 150), collectionViewLayout: layout)
//                collectionView.delegate = self
//                collectionView.dataSource = self
//                collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//                collectionView.backgroundColor = UIColor.clear
//
//            self.addSubview(collectionView)
//
//    //        self.imageview = UIImageView(frame: CGRect(x: 5, y: 5, width: 198, height: 148))
//    //               self.imageview.contentMode = .scaleAspectFit
//        }
//
//
//
//
//
//
//
//
//    }
//    /*
//    var collectionView: UICollectionView!
//    var imageview : UIImageView!
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//    super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
//        layout.itemSize = CGSize(width: 100, height: 50)
////        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
////        layout.minimumInteritemSpacing = 5.0
////        layout.minimumLineSpacing = 5.0
//
//        collectionView = UICollectionView(frame: CGRect(x: 0, y: self.cellLbltitle.frame.origin.y + self.cellLbltitle.frame.size.height + 2, width: self.frame.size.width, height: 50), collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//        collectionView.backgroundColor = UIColor.clear
//
//    self.addSubview(collectionView)
//}
//
////    -(id)initWithCoder:(NSCoder *)aDecoder
////    {
////        self = [super initWithCoder:aDecoder];
////        if (self) {
////           // Do your custom initialization here
////        }
////        return self;
////    }
//
//
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
//            layout.itemSize = CGSize(width: 200, height: 150)
//
////        layout.minimumInteritemSpacing = 5.0
////        layout.minimumLineSpacing = 5.0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
//
//            collectionView = UICollectionView(frame: CGRect(x: 0, y: 60, width: self.frame.size.width, height: 150), collectionViewLayout: layout)
//            collectionView.delegate = self
//            collectionView.dataSource = self
//            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//            collectionView.backgroundColor = UIColor.clear
//
//        self.addSubview(collectionView)
//
////        self.imageview = UIImageView(frame: CGRect(x: 5, y: 5, width: 198, height: 148))
////               self.imageview.contentMode = .scaleAspectFit
//    }
//
//    */
//
//
//extension cellPurchaseImages: UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
//
//// MARK: UICollectionViewDataSource
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return  self.imagefiles.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
//
//        var imageVIEW = UIImageView(frame: CGRect(x: 5, y: 5, width: 198, height: 148))
////        imageView?.contentMode = .scaleAspectFit
//        var imgString = ""
//        if self.imagefiles.count > 0 {
//            imgString = self.imagefiles[indexPath.item]
//        }
////        imageview.image = UIImage(named: imgString)
////        print("img string : \(imgString)")
////        imageview.kf.setImage(with: imgString)
//        if !self.isPreviewing {
//            if let urlstring = URL(string: imgString) {
////                self.imageview?.kf.setImage(with: urlstring)
////                imageVIEW.image = self.imageview.image
//
//            }
//        } else {
//            if imgString != "" {
//                let imageData = NSData(base64Encoded: imgString, options: .ignoreUnknownCharacters)
//                let img = UIImage(data: imageData! as Data)
////                self.imageview?.image = img//UIImage(named: "success")
//                imageVIEW.image = img//self.imageview.image
//            } else {
//
//               // imageview?.image = UIImage(named: "success")
//                imageVIEW.image =  UIImage(named: "success")
//            }
//        }
////        imageView?.layer.cornerRadius = 3
////        imageView?.clipsToBounds = true
//        if self.imagefiles.count > 0 {
////            cell.addSubview(self.imageview)
//            cell.addSubview(imageVIEW)
//        }
//
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150, height: 100)
//    }
//
//}
