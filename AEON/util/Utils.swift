//
//  Utils.swift
//  AEON
//
//  Created by AcePlus101 on 2/3/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    static func showAlert(viewcontroller:UIViewController,title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    static func showAlert(viewcontroller:UIViewController,title:String,message:String,action:@escaping ()->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            action()
        })
        alert.addAction(okAction)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    func generateQRCode(data input:String) -> UIImage? {
        let data = input.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                let outputImage = UIImage(ciImage: output)
                return outputImage
            }
        }
        return nil
    }
}
