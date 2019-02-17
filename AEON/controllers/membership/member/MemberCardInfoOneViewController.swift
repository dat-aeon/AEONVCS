//
//  MemberCardInfoOneViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class MemberCardInfoOneViewController: UIViewController {
    @IBOutlet weak var tvMemberCardInfo: UITableView!
    
    var registerResponse:RegisterResponse?
    var loginResponse:LoginResponse?
    
    var agreementNoList:[CustomerAgreementData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvMemberCardInfo.register(UINib(nibName: "MemberCardHeaderView", bundle: nil), forCellReuseIdentifier: "MemberCardHeaderView")
        self.tvMemberCardInfo.register(UINib(nibName: "MemberCardInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "MemberCardInfoTableViewCell")
        self.tvMemberCardInfo.dataSource = self
        self.tvMemberCardInfo.delegate = self
        
        let registerResponseString = UserDefaults.standard.string(forKey: Constants.REGISTER_RESPONSE)
        
        registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: JSON(parseJSON: registerResponseString ?? "").rawData())
        
        if let agreementList = registerResponse?.custAgreementListDtoList{
            self.agreementNoList = agreementList
        }
        let loginResponseString = UserDefaults.standard.string(forKey: Constants.LOGIN_RESPONSE)
        
        loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: JSON(parseJSON: loginResponseString ?? "").rawData())
        
        if let agreementList = loginResponse?.custAgreementListDtoList{
            self.agreementNoList = agreementList
        }
        
        
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
        return agreementNoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCardHeaderView") as! MemberCardHeaderView
            var photoUrl = ""
            var name = ""
            var customerNo = ""
            if let registerData = registerResponse{
                photoUrl = registerData.photoPath ?? ""
                name = registerData.name ?? ""
                customerNo = registerData.customerNo ?? ""
            }
            if let loginData = loginResponse{
                photoUrl = loginData.photoPath ?? ""
                name = loginData.name ?? ""
                customerNo = loginData.customerNo ?? ""
            }
            cell.setData(photoUrl: photoUrl,name: name,customerNo: customerNo)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCardInfoTableViewCell", for: indexPath) as! MemberCardInfoTableViewCell
        cell.setData(data:self.agreementNoList[indexPath.row])
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
