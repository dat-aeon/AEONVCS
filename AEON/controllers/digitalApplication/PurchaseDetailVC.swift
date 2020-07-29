//
//  PurchaseDetailVC.swift
//  AEONVCS
//
//  Created by mac on 11/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class PurchaseDetailVC: BaseUIViewController {
    
    
    var purchaseInfo = PurchaseDetail()
     var imagefileArray = [String]()
  
   
    
    @IBOutlet weak var tbPurchase: UITableView!
    var imagefile = ""
 
    var inquiryAppID = 0
    var tokenInfo: TokenData?
    
    var pInfo = [PurchaseInfoProductDtoList]()
    var pProduct = PurchaseInfoProductDtoList()
    var purchaseInfoAttachement = PurchaseAttachmentDetailResponse()
    var isPreviewing = false
    var appinfoobj = ApplicationDetailResponse()
     var productTypeLists = [ProductTypeObj]()

    var purchasedetailProductOne = ["product_info.product_Category","product_info.productDescription","product_info.brand","prodcut_info.model","prodcut_info.price","prodcut_info.loantype"]
    var purchasedetailProductTwo = ["product_info.product_Category","product_info.productDescription","product_info.brand","prodcut_info.model","prodcut_info.price"]
    var purchasedetail = ["da.outlet_name","prodcut_info.purchase_Location","prodcut_info.cashdown","da.purchasedate","prodcut_info.invoice","da.agreement","da.finance_amt","da.finance_term","da.finance_term","da.compulsory_saving","da.settlement","da.member_card","prodcut_info.invoice_Photo", "da.cash_receipt", "da.agreement","da.Uloan","application_data.othernationality"]
    var purchaseImages = ["da.member_card","prodcut_info.invoice_Photo", "da.cash_receipt", "da.agreement","application_data.othernationality"]
    //,"application_data.othernationality"
    //var purchaseInfoAttachmentDtoList = ["da.member_card","prodcut_info.invoice_Photo", "Cash Receipt", "da.agreement","application_data.othernationality"]
    //,"da.member_card","prodcut_info.invoice_Photo", "Cash Receipt", "da.agreement","application_data.othernationality"
   

   
    override func viewDidLoad() {
        super.viewDidLoad()

   
//        tbPurchase.register(OtherImageTableViewCell.self, forCellReuseIdentifier: "OtherImageTableViewCell")
//        tbPurchase.register(UINib.init(nibName: "OtherImageTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherImageTableViewCell")
     
       getProductTypeList()
        self.setupView()
    self.doGetPurchaseDetailAPI()
    }
   
  
//    private func footerView() -> UIView {
//        var view = UIView(frame: CGRect(x: 0, y: 0, width: self.tbPurchase.frame.width, height: 150))
//        view.backgroundColor = UIColor.blue
//
//
//        return view
//    }
    override func updateViews() {
        super.updateViews()
        DispatchQueue.main.async {
             self.tbPurchase.reloadData()
        }
       
    }
    

    func setupView()
    {
        self.tbPurchase.delegate = self
        self.tbPurchase.dataSource = self
        self.tbPurchase.separatorStyle = .none

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
             self.doGetPurchaseDetailAPI()
        getProductTypeList()
        
       
    }
//    override func viewWillAppear(_ animated: Bool) {
//         self.doGetPurchaseDetailAPI()
//    }
   // var productTypeLists = ProductTypeObj()
    func getProductTypeList() {
        DAViewModel.init().getProductTypeList(success: { (result) in
            print("product list kms \(result)")
           
//            for i in result {
//                print("get producttypelist  >>> \(i)")
//                self.productTypeLists.productTypeId = i.productTypeId
//                self.productTypeLists.name = i.name
//
//            }
            
            for i in result {
                self.productTypeLists.append(i)
                
            }
            self.productTypeLists.append(contentsOf: result)
            print(self.productTypeLists)
        }) { (error) in
            print(error.description)
        }
    }
    var pOne = PurchaseInfoProductDtoList()
    var pTwo = PurchaseInfoProductDtoList()
    func doGetPurchaseDetailAPI() {
        
        let tokenInfoString = UserDefaults.standard.string(forKey: Constants.TOKEN_DATA)
        tokenInfo = try? JSONDecoder().decode(TokenData.self, from: JSON(parseJSON: tokenInfoString ?? "").rawData())
        
        DAViewModel.init().doInquiryPurchaseDetail(tokenInfo: tokenInfo!, inquiryAppId: self.inquiryAppID, success: { (purchaseDetailObj) in
            print("DetailObject \(purchaseDetailObj)")
            self.purchaseInfo = purchaseDetailObj
            let a = purchaseDetailObj.purchaseInfoProductDtoList
            
            if a!.count == 1 {
                let p1 = a?[0]
                self.pOne = p1!
                self.isPreviewing = true
                
            }else if a!.count == 2 {
                let p1 = a?[0]
                self.pOne = p1!
                let p2 = a?[1]
                 self.pTwo = p2!
               
            }
           
           let type_member_card = 1
            let type_uloan = 2
            let type_invoice = 3
            let type_other = 4
            let type_agreement = 5
            let type_cashReceipt = 6
            var photo = purchaseDetailObj.purchaseInfoAttachmentDtoList
            
            if let resultArr = purchaseDetailObj.purchaseInfoAttachmentDtoList {
                var tt = PurchaseAttachmentDetailResponse()
                for i in resultArr {
                    tt.filePath = i.filePath
                    tt.fileType = i.fileType
                    tt.daPurchaseInfoId = i.daPurchaseInfoId
                    tt.daPurchaseInfoAttachmentId = i.daPurchaseInfoAttachmentId
                    photo?.append(i)
                     
                    let fileTypes = tt.fileType
                    switch fileTypes {
                    case type_member_card:
                        print("\(type_member_card)")
                        print("kms filepath\(i.filePath)")
                    case type_uloan:
                        
                    print("\(type_uloan)")
                        
                    case type_invoice:
                        
                    print("\(type_invoice)")
                        
                    case type_other:
                    print("\(type_other)")
                    case type_agreement:
                    print("\(type_agreement)")
                    case type_cashReceipt:
                    print("\(type_cashReceipt)")
                    default:
                        break
                    }
                   DispatchQueue.main.async {
                        self.tbPurchase.reloadData()
                    }
                }
            }
           
            print("p1 kaungmyatsan \(self.pOne)")
            print("p1 kaungmyatsan \(self.pTwo)")
            if let arr = purchaseDetailObj.purchaseInfoProductDtoList?[0] {
                self.pProduct.productDescription = arr.productDescription
                 self.pProduct.brand = arr.brand
                self.pProduct.price = arr.price
                self.pProduct.model = arr.model
//                for i in arr {
//                   // self.pInfo.append(i)
//                    self.pProduct.productDescription = i.productDescription
//                    self.pProduct.brand = i.brand
//                    self.pProduct.price = i.price
//                    self.pProduct.model = i.model
//                }
                DispatchQueue.main.async {
                    self.tbPurchase.reloadData()
                }
            }else if let arr = purchaseDetailObj.purchaseInfoProductDtoList?[1] {
                self.pProduct.productDescription = arr.productDescription
                                self.pProduct.brand = arr.brand
                               self.pProduct.price = arr.price
                               self.pProduct.model = arr.model
                DispatchQueue.main.async {
                    self.tbPurchase.reloadData()
                }
            }
            
          //  self.pInfo.append(contentsOf: a!)
         //   print(self.purchaseInfo)
            
            DispatchQueue.main.async {
                               self.tbPurchase.reloadData()
                           }
        }) { (error) in
            print("doGetPurchaseDetailAPI : \(error)")
        }
       // self.tbPurchase.reloadData()
    }
    func getPurchaseDetailTitleProductOne(index: Int) -> String {


        var returnString = ""
       
        switch index {
        case 0:
            for i in productTypeLists {
                let ii = i.productTypeId ?? 0
                if pOne.daProductTypeId == ii {
                    returnString = i.name ?? ""
                }
            }
        case 1:
            returnString = pOne.productDescription ?? ""
        case 2:
            returnString = pOne.brand ?? ""
        case 3:
            returnString = pOne.model ?? ""
        case 4:
            returnString = "\(pOne.price ?? 0) MMK"
        case 5:

            switch pOne.daLoanTypeId {
            case 1:
                returnString = "Mobile"
            case 2:
            returnString = "Nonmobile"
            case 3:
                returnString = "Personal-Loan"
            case 4:
            returnString = "MotorCycle-Loan"
            default:
                returnString = ""
            }

        default:
            returnString = ""
        }

        return returnString
    }
    func getPurchaseDetailTitle(index: Int) -> String {


        var returnString = ""
        
        switch index {
        case 0:
           for i in productTypeLists {
                          let ii = i.productTypeId ?? 0
                          if pTwo.daProductTypeId == ii {
                              returnString = i.name ?? ""
                          }
                      }
        case 1:
            returnString = pTwo.productDescription ?? ""
        case 2:
            returnString = pTwo.brand ?? ""
        case 3:
            returnString = pTwo.model ?? ""
        case 4:
            returnString = "\(pTwo.price ?? 0.0) MMK"

        default:
            returnString = ""
        }

        return returnString
    }
    func getPurchaseDetailList(index: Int) -> String {


           var returnString = ""

           switch index {
           case 0:
            returnString = self.purchaseInfo.outletName ?? ""
           case 1:
               returnString = self.purchaseInfo.purchaseLocation ?? ""
           case 2:
               returnString = "\(self.purchaseInfo.cashDownAmount ?? 0) MMK"
           case 3:
            returnString = Utils.changeYMDDateformat(date: purchaseInfo.purchaseDate!)
           case 4:
            returnString = self.purchaseInfo.invoiceNo ?? ""
            case 5:
            returnString = self.purchaseInfo.agreementNo ?? ""
            case 6:
                returnString = "\(self.purchaseInfo.financeAmount ?? 0.0) MMK"
            case 7:
            returnString = "\(self.purchaseInfo.financeTerm ?? 0) Months"
            case 8:
            returnString = "\(self.purchaseInfo.processingFees ?? 0.0) MMK"
            case 9:
            returnString = "\(self.purchaseInfo.compulsoryAmount ?? 0.0) MMK"
            case 10:
            returnString = "\(self.purchaseInfo.settlementAmount ?? 0.0) MMK"
           
            

           default:
               returnString = ""
           }

           return returnString
       }
    @IBAction func tappedOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

extension PurchaseDetailVC: UITableViewDelegate, UITableViewDataSource {
   
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
           if isPreviewing {
               return 2
           }
           return 3
       }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Title \(section)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if isPreviewing {
            switch section {
            case 0:
                return self.purchasedetailProductOne.count
            case 1:
                return self.purchasedetail.count
            
            default:
                return 1
            }
        } else {
            switch section {
            case 0:
                return self.purchasedetailProductOne.count
            case 1:
                return self.purchasedetailProductTwo.count
            case 2:
                return self.purchasedetail.count
           
            
           
            default:
                return 1
            }
        }
        
//        var totalrow = 16
//        let attachmentfiles = self.purchaseInfo.purchaseInfoAttachmentDtoList
//        if attachmentfiles != nil {
//            let typeOne =  attachmentfiles!.filter { $0.fileType == 1 }
//            if typeOne.count > 0 {
//                totalrow += 1
//            }
//            let typeTwo =  attachmentfiles!.filter { $0.fileType == 2 }
//            if typeTwo.count > 0 {
//                totalrow += 1
//            }
//            let typeThree =  attachmentfiles!.filter { $0.fileType == 3 }
//            if typeThree.count > 0 {
//                totalrow += 1
//            }
//            let typeFour =  attachmentfiles!.filter { $0.fileType == 4 }
//            if typeFour.count > 0 {
//                totalrow += 1
//            }
//            let typeFive =  attachmentfiles!.filter { $0.fileType == 5 }
//            if typeFive.count > 0 {
//                totalrow += 1
//            }
//        }
//        return totalrow
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let baseview = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
           let header = UILabel(frame: CGRect(x: 20, y: 10, width: 500, height: 27))
        baseview.backgroundColor = UIColor(red: 187/255.0, green: 189/255.0, blue: 191/255.0, alpha: 1)
           if self.isPreviewing {
               switch section {
               case 0:
                   header.text = "product_info.product_One".localized
               case 1:
                   header.text = ""
              
                   
               default:
                   header.text = ""
               }
           } else {
               switch section {
               case 0:
                   header.text = "product_info.product_One".localized
               case 1:
                   header.text = "product_info.product_Two".localized
               case 2:
                header.text = ""
              
             
               default:
                   header.text = ""
               }
           }
           header.textColor = .black
           header.font = UIFont(name: "PyidaungsuBook-Bold", size: 20)
           baseview.addSubview(header)
           return baseview
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isPreviewing {
            if section == 1 {
                return 1
            }
            return 50
        }
            
    
        if section == 2 {
            return 1
        }else{
           return 50
        }
       
        }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           var currentsection = 2
           //        var  currentrow = 11
           if self.isPreviewing {
               currentsection = 1
               //            currentrow = 10
           }
           
           if indexPath.section == currentsection && indexPath.row > 10 {
               return 200
           }
           
           return 56
       }
    
    
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        print("\(indexPath.section),,,....\(indexPath.row)")
              var currentsection = 2
            let  currentrow = 15
              if self.isPreviewing {
                  currentsection = 1
               let currentrow = 10
              }
        if indexPath.section == currentsection && indexPath.row > currentrow {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "OtherImageTableViewCell", for: indexPath) as! OtherImageTableViewCell
                      let attachmentfiles = self.purchaseInfo.purchaseInfoAttachmentDtoList
                      
                      var imagefileArray = [String]()
                      var filteredArray = [PurchaseAttachmentDetailResponse]()
                      if attachmentfiles != nil {
                          if self.isPreviewing {
                              switch indexPath.row {
                              case 16:
                                  filteredArray =  attachmentfiles!.filter { $0.fileType == 4 }
                                  default:
                                  imagefile = ""
                          }
                          }else{
                            switch indexPath.row {
                                      case 16:
                                          filteredArray =  attachmentfiles!.filter { $0.fileType == 4 }
                                          default:
                                          imagefile = ""
                                  }
                          }
                          if !isPreviewing {
                                                   for attachment in filteredArray {
                                                       imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                                                       imagefileArray.append(imagefile)
                                                       
                                                   }
                                               } else {
                            for attachment in filteredArray {
                                                                                  imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                                                                                  imagefileArray.append(imagefile)
                                                                                  
                                                                              }
//                                                   for attachment in filteredArray {
//
//                                                       imagefile = "\(attachment.filePath ?? "")"
//                                                       //
//                                                       imagefileArray.append(imagefile)
//
//                                                   }
                                               }
                          //cell.cellLbltitle.text = subtitleString.localized
                                           if imagefileArray.count > 0 {
                                               print("index : \(indexPath.section) \(indexPath.row)")
                                               cell.isPreviewing = self.isPreviewing
                                               
                                               cell.imagefilename = imagefile
                                               cell.imagefiles = imagefileArray
                                              // cell.setData()
                                            cell.collectionImageView.reloadData()
                                           } else {
                                               
                                               cell.isPreviewing = self.isPreviewing
                                               cell.imagefilename = imagefile
                                               cell.imagefiles = imagefileArray
                                              // cell.setDataWithoutImage()
                                           }
                        
                      
                      return cell
                      print("\(indexPath.row)kk\(indexPath.section )")
                      
                      
                      print("kms")
            }
        }
              if indexPath.section == currentsection && indexPath.row > 10 {
                  
                  let subtitleString = self.purchasedetail[indexPath.row]
                  let cell = tableView.dequeueReusableCell(withIdentifier: "idUserCardTBCell", for: indexPath) as! cellPurchaseImages
                  
               let attachmentfiles = self.purchaseInfo.purchaseInfoAttachmentDtoList
                  var imagefile = ""
                 
                  var filteredArray = [PurchaseAttachmentDetailResponse]()
                  if attachmentfiles != nil {
                      if self.isPreviewing {
                          switch indexPath.row {
                              
                           case 11:
                              filteredArray =  attachmentfiles!.filter { $0.fileType == 1 }
                          case 12:
                              filteredArray =  attachmentfiles!.filter { $0.fileType == 3 }
                          case 13:
                              filteredArray =  attachmentfiles!.filter { $0.fileType == 6 }
                          case 14:
                              filteredArray =  attachmentfiles!.filter { $0.fileType == 5 }
                          case 15:
                              filteredArray =  attachmentfiles!.filter { $0.fileType == 2 }
//                          case 16:
                        //filteredArray =  attachmentfiles!.filter { $0.fileType == 4 }
//                          case 20:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 6 }
//                          case 23:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 7 }
//                          case 24:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 8 }
//                          case 25:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 9 }
                              
                          default:
                              imagefile = ""
                          }
                      } else {
                          switch indexPath.row {
                            
                            case 11:
                                filteredArray =  attachmentfiles!.filter { $0.fileType == 1 }
                            case 12:
                                filteredArray =  attachmentfiles!.filter { $0.fileType == 3 }
                            case 13:
                                filteredArray =  attachmentfiles!.filter { $0.fileType == 6 }
                            case 14:
                                filteredArray =  attachmentfiles!.filter { $0.fileType == 5 }
                            case 15:
                                filteredArray =  attachmentfiles!.filter { $0.fileType == 2 }
//                            case 16:
                           // filteredArray =  attachmentfiles!.filter { $0.fileType == 4 }
//                          case 22:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 6 }
//                          case 23:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 7 }
//                          case 24:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 8 }
//                          case 25:
//                              filteredArray =  attachmentfiles!.filter { $0.fileType == 9 }
                              
                          default:
                              imagefile = ""
                          }
                      }
                    print("kaungmyatsan filteredarray  > \(filteredArray)")
                      if !isPreviewing {
                          for attachment in filteredArray {
                              imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                              imagefileArray.append(imagefile)
                              
                          }
                      } else {
                        for attachment in filteredArray {
                            imagefile = "https://ass.aeoncredit.com.mm/daso/purchase-image-files/\(attachment.filePath ?? "")"
                            imagefileArray.append(imagefile)
                            
                        }
//                          for attachment in filteredArray {
//
//                              imagefile = "\(attachment.filePath ?? "")"
//                              //
//                              imagefileArray.append(imagefile)
//
//                          }
                      }
                  }
                  
                cell.cellLbltitle.text = subtitleString.localized
                  if imagefileArray.count > 0 {
                      print("index : \(indexPath.section) \(indexPath.row)")
                      cell.isPreviewing = self.isPreviewing
                   
                      cell.imagefilename = imagefile
                      cell.imagefiles = imagefileArray
                      cell.setData()
                 
                  } else {
                      
                      cell.isPreviewing = self.isPreviewing
                  
                      cell.imagefilename = imagefile
                      cell.imagefiles = imagefileArray
                      cell.setDataWithoutImage()
                    cell.setData()
                  }
               // cell.setData()
                
                  return cell
                  
              }
              
              let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.PURCHASE_LIST_CELL, for: indexPath) as! cellPurchaseList
              
              
              var subtitleString = ""
              var currentdata = [String]()
              
              if self.isPreviewing {
                  switch indexPath.section {
                      
                  case 0:
                     currentdata = self.purchasedetailProductOne
                      subtitleString = self.getPurchaseDetailTitleProductOne(index: indexPath.row)
                  case 1:
                    
                      currentdata = self.purchasedetail
                   subtitleString = self.getPurchaseDetailList(index: indexPath.row)
                      
                      
                  default:
                      currentdata = []
                  }
              } else {
                  
                  switch indexPath.section {
                      
                  case 0:
                      currentdata = self.purchasedetailProductOne
                      subtitleString = self.getPurchaseDetailTitleProductOne(index: indexPath.row)
                    
                  case 1:
                   
                        currentdata = self.purchasedetailProductTwo
                                            subtitleString = self.getPurchaseDetailTitle(index: indexPath.row)
                   
                    
                     
                  case 2:
                      currentdata = self.purchasedetail
                     subtitleString = self.getPurchaseDetailList(index: indexPath.row)
                  
                    
                  default:
                      currentdata = []
                  }
              }
//        switch indexPath.row {
//           
//        case 13:
//            print("kaung16")
//        default:
//            break
//        }
       
              cell.setData(purchasedetail: currentdata[indexPath.row].localized, subtitle: subtitleString)
              
              return cell
              
          }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("photo \(indexPath.section)")
        print("row    >>>>> \(indexPath.row)")
         let rowPosition = indexPath.row
        
//           let alert = CustomAlert(title: "", image: UIImage(named: "9")!)
//                  alert.show(animated: true)
      
       
        tbPurchase.reloadData()
        
                         
    }
}




//extension PurchaseDetailVC: UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCollectionViewCell", for: indexPath) as! OtherCollectionViewCell
//
//
//        return cell
//    }
//
//
//// MARK: UICollectionViewDataSource
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return  3//self.imagefiles.count
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//
//}

