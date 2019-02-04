//
//  CuponViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class CouponViewController: UIViewController {
    
    @IBOutlet weak var tvCoupon: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvCoupon.register(UINib(nibName: "CouponTableViewCell", bundle: nil), forCellReuseIdentifier: "CouponTableViewCell")
        
        self.tvCoupon.dataSource = self
        self.tvCoupon.delegate = self
        
        self.tvCoupon.estimatedRowHeight = CGFloat(160.0)
        self.tvCoupon.rowHeight = UITableView.automaticDimension
        

    }

}

extension CouponViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell", for: indexPath) as! CouponTableViewCell
        return cell
    }
    
    
}

extension CouponViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alertController = UIAlertController(title: "Enter Your Password", message: nil, preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = "Enter your password"
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (okAction) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
