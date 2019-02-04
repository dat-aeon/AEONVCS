//
//  MemberCardInfoOneViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class MemberCardInfoOneViewController: UIViewController {
    @IBOutlet weak var tvMemberCardInfo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvMemberCardInfo.register(UINib(nibName: "MemberCardHeaderView", bundle: nil), forCellReuseIdentifier: "MemberCardHeaderView")
        self.tvMemberCardInfo.register(UINib(nibName: "MemberCardInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "MemberCardInfoTableViewCell")
        self.tvMemberCardInfo.dataSource = self
        self.tvMemberCardInfo.delegate = self
    }

}
extension MemberCardInfoOneViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCardHeaderView") as! MemberCardHeaderView
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCardInfoTableViewCell", for: indexPath) as! MemberCardInfoTableViewCell
        return cell
    }
    
}
extension MemberCardInfoOneViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return CGFloat(200.0)
        }
        return CGFloat(150.0)
    }
}
