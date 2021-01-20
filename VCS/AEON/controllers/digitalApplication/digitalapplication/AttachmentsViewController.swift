//
//  AttachmentsViewController.swift
//  testmaterial
//
//  Created by Ant on 10/01/2021.
//


import UIKit
import AVFoundation
import SwiftyJSON
protocol ImageAndCaptionDelegate: class {
func userDidEnterInformation(image: UIImage)
}

class AttachmentsViewController: BaseUIViewController {
    weak var delegate: ImageAndCaptionDelegate? = nil
    var isNrcFront = false
    var imgNrcFront = UIImage()
    
    var isNRCBack = false
    var imgNrcBack = UIImage()
    
    var isIncomeProof = false
    var imgIncomeProof = UIImage()
    
    var isResidenceProof = false
    var imgResidenceProof = UIImage()
    
    var isGuarantorNrcFront = false
    var imgGuarantorNrcFront = UIImage()
    
    var isGuarantorNrcBack = false
    var imgGuarantorNrcBack = UIImage()
    
    var isHousehold = false
    var imgHousehold = UIImage()
    
    var isApplicantFoto = false
    var imgApplicantFoto = UIImage()
    
    var isCustomerSignature = false
    var imgCustomerSignature = UIImage()
    
    var isGuarantorSignature = false
    var imgGuarantorSignature = UIImage()
    
    var isNrcFrontChoosen = false
    var isNrcBackChoosen = false
    var isIncomeProofChoosen = false
    var isResidenceProofChoosen = false
    var isGuarantorNrcFrontChoosen = false
    var isGuarantorNrcBackChoosen = false
    var isHouseholdChoosen = false
    var isApplicantFotoChoosen = false
    var isCustomerSignatureChoosen = false
    var isGuarantorSignatureChoosen = false
    let myPickerController = UIImagePickerController()
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var cameraNrcFrontView: UIView!
    @IBOutlet weak var nrcFrontImageView: UIImageView!
    @IBOutlet weak var galleryViewBtn: UIView!
    @IBOutlet weak var removeViewBtn: UIView!
    
    
    @IBOutlet weak var nrcBackCameraView: UIView!
    @IBOutlet weak var nrcBackGalleryView: UIView!
    @IBOutlet weak var nrcBackRemoveView: UIView!
    
    @IBOutlet weak var guarantornrcFrontCameraView: UIView!
    @IBOutlet weak var guarantornrcFrontGalleryView: UIView!
    @IBOutlet weak var guarantornrcFontRemoveView: UIView!
    
    @IBOutlet weak var guarantornrcBackCameraView: UIView!
    @IBOutlet weak var guarantornrcBackGalleryView: UIView!
    @IBOutlet weak var guarantornrcBackRemoveView: UIView!
    
    @IBOutlet weak var residentProofAttachmentCameraView: UIView!
    @IBOutlet weak var residentProofAttachmentGalleryView: UIView!
    @IBOutlet weak var residentProofAttachmentRemoveView: UIView!
    
    @IBOutlet weak var incomeProofAttachmentCameraView: UIView!
    @IBOutlet weak var incomeProofAttachmentGalleryView: UIView!
    @IBOutlet weak var incomeProofAttachmentRemoveView: UIView!
    
    
    @IBOutlet weak var houseHoleCameraView: UIView!
    @IBOutlet weak var houseHoleGalleryView: UIView!
    @IBOutlet weak var houseHoleRemoveView: UIView!
    
    @IBOutlet weak var applicantsPhotoCameraView: UIView!
    @IBOutlet weak var applicantsPhotoGalleryView: UIView!
    @IBOutlet weak var applicantsPhotoRemoveView: UIView!
    
    @IBOutlet weak var customerSignatureCameraView: UIView!
    @IBOutlet weak var customerSignatureGalleryView: UIView!
    @IBOutlet weak var customerSignatureRemoveView: UIView!
    
    
    @IBOutlet weak var guarantorSignatureCameraView: UIView!
    @IBOutlet weak var guarantorSignatureGalleryView: UIView!
    @IBOutlet weak var guarantorSignatureRemoveView: UIView!
    
    
    @IBOutlet weak var joinNrcFrontCameraView: UIView!
    @IBOutlet weak var joinNrcFrontGalleryView: UIView!
    @IBOutlet weak var joinNrcFrontRemoveView: UIView!
    
    
    @IBOutlet weak var joinNrcBackCameraView: UIView!
    @IBOutlet weak var joinNrcBackGalleryView: UIView!
    @IBOutlet weak var joinNrcBackRemoveView: UIView!
    
    @IBOutlet weak var joinResidentProofCameraView: UIView!
    @IBOutlet weak var joinResidentProofGalleryView: UIView!
    @IBOutlet weak var joinResidentProofRemoveView: UIView!
    
    @IBOutlet weak var joinIncomeProofCameraView: UIView!
    @IBOutlet weak var joinIncomeProofGalleryView: UIView!
    @IBOutlet weak var joinIncomeProofRemoveView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewBtn.layer.cornerRadius = 10
        submitBtn.layer.cornerRadius = 10
        backBtn.isUserInteractionEnabled = true
        galleryViewBtn.isUserInteractionEnabled = true
        removeViewBtn.isUserInteractionEnabled = true
        cameraNrcFrontView.isUserInteractionEnabled = true
        nrcBackCameraView.isUserInteractionEnabled = true
        self.nrcBackCameraView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nrcBackCamera)))
        self.galleryViewBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nrcFrontgalleryView)))
        self.cameraNrcFrontView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nrcFront)))
        self.backBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        self.removeViewBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nrcfrontremove)))
       uiSetUp()
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectfoto(notification:)), name: NSNotification.Name(rawValue: "didSelectFoto"), object: nil)
    }
    @objc func nrcfrontremove(){
        nrcFrontImageView.image = UIImage(named: "photo-camera")
    }
    @objc func nrcFrontgalleryView(){
        var imagePicker: UIImagePickerController!
        imagePicker =  UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        self.isNrcFront = true
     
    }
    @objc func nrcBackCamera(){
        var imagePicker: UIImagePickerController!
        imagePicker =  UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        self.isNRCBack = true
    }
    
    
    @objc func nrcFront(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        self.camera()
        self.isNrcFront = true
    }
    func callNotification(image: UIImage) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectFoto"), object: self, userInfo: ["img": image])
    
        }
    @objc func didSelectfoto(notification: Notification) {
        print("didSelectfoto")
        if let dict = notification.userInfo as? Dictionary<String, Any> {
            
            if let image = dict["img"] as? UIImage {
               
                    print("didSelectfoto resize")
                nrcFrontImageView.image = image
            }
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            guard let originImage = info[.originalImage] as? UIImage else {
                self.callNotification(image: UIImage())
                return
            }
            self.callNotification(image: originImage)
            return
        }
         self.callNotification(image: image)
        return
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          //  dismiss(animated: true, completion: nil)
        }
    @IBAction func previewBtnPress(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    @IBAction func submitBtnPress(_ sender: UIButton) {
        let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterApplicationsViewController") as! RegisterApplicationsViewController
        navigationVC.modalPresentationStyle = .overFullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    func camera()
       {
           if UIImagePickerController.isSourceTypeAvailable(.camera){
               
               self.myPickerController.delegate = self;
                self.myPickerController.sourceType = .camera
               self.present( self.myPickerController, animated: true, completion: nil)
           }
           
       }
       
       func photoLibrary()
       {
           
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
               
                self.myPickerController.delegate = self;
                self.myPickerController.sourceType = .photoLibrary
               self.present( self.myPickerController, animated: true, completion: nil)
           }
       }
 
    
    
    func doResizeAndAssignImages(image: UIImage) {
        
        // print("image is not null")
        // resize image
        var resizeImage = UIImage()
        let jpegData = image.jpegData(compressionQuality: 2.0)
        let jpegSize: Int = jpegData?.count ?? 0
        print("original size of image in KB: %f ", Double(jpegSize) / 1024.0)
        //            print("original image width & height", image!.size.width, image!.size.height)
        
        if jpegSize == 0 {
            Utils.showAlert(viewcontroller: self, title: "Image is invalid.", message: "Please choose again.")
            //return
        } else {
            
            if jpegSize <= Constants.LOW_QUALITY_IMAGE_250 {
                resizeImage = image.resizeWithPercent(percentage: 1.0)!
                
            } else if jpegSize > Constants.LOW_QUALITY_IMAGE_250 && jpegSize <= Constants.MEDIUM_QUALITY_IMAGE_500 {
                resizeImage = image.resizeWithPercent(percentage: 0.8)!
                
            } else if jpegSize > Constants.MEDIUM_QUALITY_IMAGE_500 && jpegSize <= Constants.HIGH_QUALITY_IMAGE_1500 {
                resizeImage = image.resizeWithPercent(percentage: 0.7)!
                
            } else {
                resizeImage = image.resizeWithPercent(percentage: 0.1)!
               // resizeImage = image.resizeWithPercent(percentage: 0.2)!
                
            }
            let rejpegData = resizeImage.jpegData(compressionQuality: 0.2)
            let rejpegSize: Int = rejpegData?.count ?? 0
            print("resize size of image in KB: %f ", Double(rejpegSize) / 9500.0)
            
            if self.isNrcFront {
                self.imgNrcFront = resizeImage
                self.isNrcFront = false
                self.isNrcFrontChoosen = true
                
                //                self.imgNrcFrontIcon.image = UIImage(named: "success")
                //                self.lblNrcFrontInside.text = "Ready to upload"
                
                self.addAfterImageCapturingView()
            }
            
            if self.isNRCBack {
                self.imgNrcBack = resizeImage
                self.isNRCBack = false
                self.isNrcBackChoosen = true
                
                //                self.imgNrcBackIcon.image = UIImage(named: "success")
                //                self.lblNrcBackInside.text = "Ready to upload"
                
            //    self.addAfterImageCapturingViewNRCBACK()
            }
            
            if self.isIncomeProof {
                self.imgIncomeProof = resizeImage
                self.isIncomeProof = false
                self.isIncomeProofChoosen = true
                
                //                self.imgIncomeProofIcon.image = UIImage(named: "success")
                //                self.lblIncomeProofInside.text = "Ready to upload"
                
            //    self.addAfterImageCapturingViewIncomeProof()
            }
            
            if self.isResidenceProof {
                self.imgResidenceProof = resizeImage
                self.isResidenceProof = false
                self.isResidenceProofChoosen = true
                
                //                self.imgResidenceProofIcon.image = UIImage(named: "success")
                //                self.lblResidenceProofInside.text = "Ready to upload"
             //   self.addAfterImageCapturingViewResidenceProof()
            }
            
            if self.isGuarantorNrcFront {
                self.imgGuarantorNrcFront = resizeImage
                self.isGuarantorNrcFront = false
                self.isGuarantorNrcFrontChoosen = true
                
                //                self.imgGuarantorFrontIcon.image = UIImage(named: "success")
                //                self.lblGuarantorFrontInside.text = "Ready to upload"
                
             //   self.addAfterImageCapturingViewGuarantor()
            }
            
            if self.isGuarantorNrcBack {
                self.imgGuarantorNrcBack = resizeImage
                self.isGuarantorNrcBack = false
                self.isGuarantorNrcBackChoosen = true
                
                //                self.imgGuarantorBackIcon.image = UIImage(named: "success")
                //                self.lblGuarantorBackInside.text = "Ready to upload"
                
           //     self.addAfterImageCapturingViewGuarantorBack()
            }
            
            if self.isHousehold {
                self.imgHousehold = resizeImage
                self.isHousehold = false
                self.isHouseholdChoosen = true
                
                //                self.imgHousholdIcon.image = UIImage(named: "success")
                //                self.lblHouseholdInside.text = "Ready to upload"
                
           //     self.addAfterImageCapturingViewHousehold()
            }
            
            if self.isApplicantFoto {
                self.imgApplicantFoto = resizeImage
                self.isApplicantFoto = false
                self.isApplicantFotoChoosen = true
                
                //                self.imgApplicantfotoIcon.image = UIImage(named: "success")
                //                self.lblApplicantFotoInside.text = "Ready to upload"
                
         //       self.addAfterImageCapturingViewApplicantFoto()
            }
            
            if self.isCustomerSignature {
                self.imgCustomerSignature = resizeImage
                self.isCustomerSignature = false
                self.isCustomerSignatureChoosen = true
                
                //                self.imgCusSignatureIcon.image = UIImage(named: "success")
                //                self.lblCusSignatureInside.text = "Ready to upload"
                
             //   self.addAfterImageCapturingViewCustomerSignature()
            }
            if self.isGuarantorSignature {
                self.imgGuarantorSignature = resizeImage
                self.isGuarantorSignature = false
                self.isGuarantorSignatureChoosen = true
                
            //    self.addAfterImageCapturingViewGuarantorSignature()
            }
        
            
        }
        
    }
    
    
    
    
        func addAfterImageCapturingView() {
           
    
            self.nrcFrontImageView.image = self.imgNrcFront
    
       
    
    
        }
    
    
    
    
    
    
    
    func uiSetUp() {
        self.cameraNrcFrontView.layer.borderWidth = 1
        self.cameraNrcFrontView.layer.borderColor = UIColor.blue.cgColor
        self.galleryViewBtn.layer.borderWidth = 1
        self.galleryViewBtn.layer.borderColor = UIColor.blue.cgColor
        self.removeViewBtn.layer.borderWidth = 1
        self.removeViewBtn.layer.borderColor = UIColor.red.cgColor
        
        self.nrcBackCameraView.layer.borderWidth = 1
        self.nrcBackCameraView.layer.borderColor = UIColor.blue.cgColor
        self.nrcBackGalleryView.layer.borderWidth = 1
        self.nrcBackGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.nrcBackRemoveView.layer.borderWidth = 1
        self.nrcBackRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.guarantornrcFrontCameraView.layer.borderWidth = 1
        self.guarantornrcFrontCameraView.layer.borderColor = UIColor.blue.cgColor
        self.guarantornrcFrontGalleryView.layer.borderWidth = 1
        self.guarantornrcFrontGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.guarantornrcFontRemoveView.layer.borderWidth = 1
        self.guarantornrcFontRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.guarantornrcBackCameraView.layer.borderWidth = 1
        self.guarantornrcBackCameraView.layer.borderColor = UIColor.blue.cgColor
        self.guarantornrcBackGalleryView.layer.borderWidth = 1
        self.guarantornrcBackGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.guarantornrcBackRemoveView.layer.borderWidth = 1
        self.guarantornrcBackRemoveView.layer.borderColor = UIColor.red.cgColor
        
        
        
        self.residentProofAttachmentCameraView.layer.borderWidth = 1
        self.residentProofAttachmentCameraView.layer.borderColor = UIColor.blue.cgColor
        self.residentProofAttachmentGalleryView.layer.borderWidth = 1
        self.residentProofAttachmentGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.residentProofAttachmentRemoveView.layer.borderWidth = 1
        self.residentProofAttachmentRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.incomeProofAttachmentCameraView.layer.borderWidth = 1
        self.incomeProofAttachmentCameraView.layer.borderColor = UIColor.blue.cgColor
        self.incomeProofAttachmentGalleryView.layer.borderWidth = 1
        self.incomeProofAttachmentGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.incomeProofAttachmentRemoveView.layer.borderWidth = 1
        self.incomeProofAttachmentRemoveView.layer.borderColor = UIColor.blue.cgColor
        
        
        self.houseHoleCameraView.layer.borderWidth = 1
        self.houseHoleCameraView.layer.borderColor = UIColor.blue.cgColor
        self.houseHoleGalleryView.layer.borderWidth = 1
        self.houseHoleGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.houseHoleRemoveView.layer.borderWidth = 1
        self.houseHoleRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.applicantsPhotoCameraView.layer.borderWidth = 1
        self.applicantsPhotoCameraView.layer.borderColor = UIColor.blue.cgColor
        self.applicantsPhotoGalleryView.layer.borderWidth = 1
        self.applicantsPhotoGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.applicantsPhotoRemoveView.layer.borderWidth = 1
        self.applicantsPhotoRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.customerSignatureCameraView.layer.borderWidth = 1
        self.customerSignatureCameraView.layer.borderColor = UIColor.blue.cgColor
        self.customerSignatureGalleryView.layer.borderWidth = 1
        self.customerSignatureGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.customerSignatureRemoveView.layer.borderWidth = 1
        self.customerSignatureRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.guarantorSignatureCameraView.layer.borderWidth = 1
        self.guarantorSignatureCameraView.layer.borderColor = UIColor.blue.cgColor
        self.guarantorSignatureGalleryView.layer.borderWidth = 1
        self.guarantorSignatureGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.guarantorSignatureRemoveView.layer.borderWidth = 1
        self.guarantorSignatureRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.joinNrcFrontCameraView.layer.borderWidth = 1
        self.joinNrcFrontCameraView.layer.borderColor = UIColor.blue.cgColor
        self.joinNrcFrontGalleryView.layer.borderWidth = 1
        self.joinNrcFrontGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.joinNrcFrontRemoveView.layer.borderWidth = 1
        self.joinNrcFrontRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.joinNrcBackCameraView.layer.borderWidth = 1
        self.joinNrcBackCameraView.layer.borderColor = UIColor.blue.cgColor
        self.joinNrcBackGalleryView.layer.borderWidth = 1
        self.joinNrcBackGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.joinNrcBackRemoveView.layer.borderWidth = 1
        self.joinNrcBackRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.joinResidentProofCameraView.layer.borderWidth = 1
        self.joinResidentProofCameraView.layer.borderColor = UIColor.blue.cgColor
        self.joinResidentProofGalleryView.layer.borderWidth = 1
        self.joinResidentProofGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.joinResidentProofRemoveView.layer.borderWidth = 1
        self.joinResidentProofRemoveView.layer.borderColor = UIColor.red.cgColor
        
        self.joinIncomeProofCameraView.layer.borderWidth = 1
        self.joinIncomeProofCameraView.layer.borderColor = UIColor.blue.cgColor
        self.joinIncomeProofGalleryView.layer.borderWidth = 1
        self.joinIncomeProofGalleryView.layer.borderColor = UIColor.blue.cgColor
        self.joinIncomeProofRemoveView.layer.borderWidth = 1
        self.joinIncomeProofRemoveView.layer.borderColor = UIColor.red.cgColor
        
    }

}
extension AttachmentsViewController {
   
}
