//
//  Localizable.swift
//  AEON
//
//  Created by AcePlus101 on 2/4/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import Foundation
import UIKit

private enum Key {
    static var text = "text"
    static var title = "title"
    static var placeholder = "placeholder"
    static var prompt = "prompt"
}

protocol Localizable {
    func localize()
}

extension UITextField: Localizable {
    
    @IBInspectable var localizedPlaceholder: String {
        get { return associated(&Key.placeholder) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.placeholder)
            localizePlaceholder()
            localizeFont()
        }
    }
    
    @IBInspectable var localizedText: String {
        get { return associated(&Key.text) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.text)
            localizeText()
            localizeFont()
        }
    }
    
    func localize() {
        localizeFont()
        localizePlaceholder()
        localizeText()
    }
    private func localizeFont() {
        //        font = font?.themeFont
    }
    private func localizePlaceholder() {
        if !localizedPlaceholder.isEmpty { placeholder = localizedPlaceholder.localized }
    }
    private func localizeText() {
        if !localizedText.isEmpty { text = localizedText.localized }
    }
}

extension UITextView: Localizable {
    
    @IBInspectable var localizedText: String {
        get { return associated(&Key.text) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.text)
            localize()
        }
    }
    
    func localize() {
        localizeFont()
        if !localizedText.isEmpty { text = localizedText.localized }
    }
    private func localizeFont() {
        //        font = font?.themeFont
    }
}

extension UIBarItem: Localizable {
    
    @IBInspectable var localizedTitle: String {
        get { return associated(&Key.title) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.title)
            localize()
        }
    }
    
    func localize() {
        localizeFont()
        if !localizedTitle.isEmpty { title = localizedTitle.localized }
    }
    private func localizeFont() {
        //        UITabBarItem   .updateFont()
        //        UIBarButtonItem.updateFont()
    }
}

extension UILabel: Localizable {
    
    @IBInspectable var localizedText: String {
        get { return associated(&Key.text) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.text)
            localize()
        }
    }
    
    func localize() {
        localizeFont()
        if !localizedText.isEmpty { text = localizedText.localized }
    }
    
    private func localizeFont() {
        //        font = font?.themeFont
    }
}

extension UINavigationItem: Localizable {
    
    @IBInspectable var localizedTitle: String {
        get { return associated(&Key.title) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.title)
            localizeTitle()
            localizeFont()
        }
    }
    
    @IBInspectable var localizedPrompt: String {
        get { return associated(&Key.prompt) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.prompt)
            localizePrompt()
            localizeFont()
        }
    }
    
    func localize() {
        //        localizeFont()
        localizeTitle()
        localizePrompt()
    }
    private func localizeFont() {
        //        UITabBarItem   .updateFont()
        //        UIBarButtonItem.updateFont()
    }
    private func localizeTitle() {
        if !localizedTitle.isEmpty { title = localizedTitle.localized }
    }
    private func localizePrompt() {
        if !localizedPrompt.isEmpty { prompt = localizedPrompt.localized }
    }
}

extension UIButton: Localizable {
    
    @IBInspectable var localizedTitle: String {
        get { return associated(&Key.title) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.title)
            localize()
        }
    }
    
    @objc func localize() {
        localizeFont()
        if !localizedTitle.isEmpty {
            titleLabel?.text = localizedTitle.localized
            setTitle(localizedTitle.localized, for: UIControl.State())
        }
    }
    private func localizeFont() {
        //        titleLabel?.font = titleLabel?.font.themeFont
    }
}

extension UISearchBar: Localizable {
    
    @IBInspectable var localizedPrompt: String {
        get { return associated(&Key.prompt) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.prompt)
            localizePrompt()
        }
    }
    
    @IBInspectable var localizedPlaceholder: String {
        get { return associated(&Key.placeholder) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.placeholder)
            localizePlaceholder()
        }
    }
    
    func localize() {
        localizePrompt()
        localizePlaceholder()
    }
    private func localizePrompt() {
        if !localizedPrompt.isEmpty { prompt = localizedPrompt.localized }
    }
    private func localizePlaceholder() {
        if !localizedPlaceholder.isEmpty { placeholder = localizedPlaceholder.localized }
    }
}

extension UISegmentedControl: Localizable {
    
    @IBInspectable var localized: Bool {
        get { return true }
        set {
            if newValue {
                var titles = [String]()
                for index in 0..<numberOfSegments {
                    guard let key = titleForSegment(at: index) else { break }
                    titles.append(key)
                }
                localizedTitles = titles
            } else {
                localizedTitles = []
            }
        }
    }
    
    private var localizedTitles: [String] {
        get { return associated(&Key.title) ?? [] }
        set {
            associate(newValue as AnyObject?, &Key.title)
            localize()
        }
    }
    
    func localize() {
        localizeFont()
        guard !localizedTitles.isEmpty else { return }
        
        for index in 0..<min(numberOfSegments, localizedTitles.count) {
            setTitle(localizedTitles[index].localized, forSegmentAt: index)
        }
    }
    
    private func localizeFont() {
        //        setTitleTextAttributes([NSAttributedString.Key.font: UIFont.segmentedControlItem()], for: .normal)
    }
}

extension UIViewController: Localizable {
    
    @IBInspectable var localizedTitle: String {
        get { return associated(&Key.title) ?? "" }
        set {
            associate(newValue as AnyObject?, &Key.title)
            localize()
        }
    }
    
    @objc func localize() {
        // Bars
        if let navTitleView = navigationItem.titleView {
            localizeView(navTitleView)
        }
        navigationItem.localize()
        navigationItem.leftBarButtonItems? .forEach{ $0.localize() }
        navigationItem.rightBarButtonItems?.forEach{ $0.localize() }
        tabBarItem.localize()
        
        // Self
        localizeView(view)
        
        // View controllers
        children.forEach{ $0.localize() }
        presentedViewController?.localize()
        
        if !localizedTitle.isEmpty { title = localizedTitle.localized }
    }
    
    private func localizeView(_ view: UIView) {
        if let localizable = view as? Localizable {
            localizable.localize()
        }
        view.subviews.forEach{ localizeView($0) }
    }
}

extension UIApplication: Localizable {
    
    func localize() {
        windows.forEach { $0.rootViewController?.localize() }
    }
}
extension NSObject {
    func associated<T>(_ key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }
    func associate(_ value: AnyObject?, _ key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

