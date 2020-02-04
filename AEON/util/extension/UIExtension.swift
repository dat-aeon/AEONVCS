//
//  UIExtension.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/2/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit
extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
extension UILabel {
    
    func heightForLabel(text:String,width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
}

extension UITextField{
    func showError(message:String){
        self.layer.backgroundColor = UIColor(red:255.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0).cgColor
        self.attributedPlaceholder = NSAttributedString(string: message,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

    }
    func setMaxLength(maxLength:Int) {
        self.tag = maxLength
        addTarget(self, action: #selector(textfieldChanged(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc private func textfieldChanged(_ textField: UITextField) {
        guard let text = text else { return }
        let trimmed = text.prefix(textField.tag)
        self.text = String(trimmed)
        
    }
}
extension UIView {
    
    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutConstraint.Attribute = .height) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIViewController:NSURLConnectionDelegate{
//    private func connection(_ connection: NSURLConnection, willSendRequestFor challenge: URLAuthenticationChallenge) {
//        let protectionSpace: URLProtectionSpace = challenge.protectionSpace
//
//        let sender = challenge.sender
//
//        if (protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
//            let trust = challenge.protectionSpace.serverTrust
//            
//            var credential: URLCredential? = nil
//            if let trust = trust {
//                credential = URLCredential(trust: trust)
//            }
//
//            if let credential = credential {
//                sender?.use(credential, for: challenge)
//            }
//        } else {
//            sender?.performDefaultHandling!(for: challenge)
//        }
//    }
    
}

extension UIAlertController {
    static func actionSheetWithItems<A : Equatable>(items : [(title : String, value : A)], currentSelection : A? = nil, action : @escaping (A) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for (var title, value) in items {
            if let selection = currentSelection, value == selection {
                // Note that checkmark and space have a neutral text flow direction so this is correct for RTL
                title = "✔︎ " + title
            }
            controller.addAction(
                UIAlertAction(title: title, style: .default) {_ in
                    action(value)
                }
            )
        }
        return controller
    }
    static func actionSheetWithItems(items : [(String)], currentSelection : String? = nil, action : @escaping (String) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for ( title) in items {
            controller.addAction(
                UIAlertAction(title: title, style: .default) {_ in
                    action(title)
                }
            )
        }
        return controller
    }
    static func actionSheetWithItems(items : [(String)], action : @escaping (String) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for ( title) in items {
            controller.addAction(
                UIAlertAction(title: title, style: .default) {_ in
                    action(title)
                }
            )
        }
        return controller
    }
}

public extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case iPhoneXR
        case Unknown
    }
    var screenType: ScreenType {
        guard iPhone else { return .Unknown}
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 1792:
            return .iPhoneXR
        case 2208, 1920:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        default:
            return .Unknown
        }
    }
    
}
