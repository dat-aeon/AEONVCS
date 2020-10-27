//
//  FreechatImageDetailViewController.swift
//  AEONVCS
//
//  Created by Ant on 02/06/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//

import UIKit
import Kingfisher
class FreechatImageDetailViewController: UIViewController {
var urlString = ""
    @IBOutlet weak var imageDetailView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        imageDetailView.kf.setImage(with: URL(string: urlString))
    }
    @IBAction func backBtnPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
}
extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
