//
//  ImagePicker.swift
//  AEONVCS
//
//  Created by Khin Yadanar Thein on 6/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit


public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

open class ImagePicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.mediaTypes = ["public.image"]
        
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            if type == .camera {
                self.pickerController.allowsEditing = false
                
            } else {
                self.pickerController.allowsEditing = false
            }
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        DispatchQueue.main.async {
            self.pickerController.sourceType = UIImagePickerController.SourceType.camera
            self.pickerController.allowsEditing = false
            
            let mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: (self.presentationController?.view.frame.size.width)!, height: (self.presentationController?.view.frame.size.height)!-200))
            let dimX = mainView.frame.size.width - mainView.frame.size.height
            let frame             = CGRect.init(x: dimX/2, y: 0, width: mainView.frame.size.height, height: mainView.frame.size.height)
            let blockView         = UIImageView.init(frame: frame)
            //blockView.contentMode = .scaleAspectFit
            blockView.image       = UIImage(named: "camera-grid")
            //mainView.backgroundColor = UIColor.blue
            //blockView.backgroundColor = UIColor.red
            let textFrame        = CGRect.init(x: 0, y: mainView.frame.size.height-50, width: mainView.frame.size.height, height: 50)
            let textView         = UILabel.init(frame: textFrame)
            textView.text        = "member.cameraglass".localized
            textView.textColor = UIColor.red
            textView.backgroundColor = UIColor.white
            textView.font = UIFont.systemFont(ofSize: 13)
            textView.numberOfLines = 0
            mainView.addSubview(blockView)
            mainView.addSubview(textView)
            self.pickerController.cameraOverlayView = mainView
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func presentMessageCamera(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Camera") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Gallery") {
            alertController.addAction(action)
        }
       
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
        
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
        
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
        
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            guard let originImage = info[.originalImage] as? UIImage else {
                return self.pickerController(picker, didSelect: nil)
            }
            return self.pickerController(picker, didSelect: originImage)
        }
        
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}
