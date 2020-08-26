//
//  NRCpopupViewController.swift
//  AEONVCS
//
//  Created by mac on 4/5/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class NRCpopupViewController: UIViewController {
    
    @IBOutlet weak var mainView: CardView!
    @IBOutlet weak var tvNrcData: UITableView!
    @IBOutlet weak var cvCancelBtn: CardView!
    
    var townshipList = [String]()
    
    var townshipDelegate :TownshipSelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvNrcData.register(UINib(nibName: CommonNames.NRC_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.NRC_TABLE_CELL)
        self.tvNrcData.dataSource = self
        self.tvNrcData.delegate = self
        self.tvNrcData.reloadData()
        self.tvNrcData.tableFooterView = UIView()
        
        self.cvCancelBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onClickCancel)))
    }
    
    @objc func onClickCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

protocol TownshipSelectDelegate {
    func onClickTownshipCode(townshipCode : String)
}


extension NRCpopupViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let count = self.couponList.count
        return self.townshipList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.NRC_TABLE_CELL, for: indexPath) as! NrcTableViewCell
        
        cell.lblDivision.text = townshipList[indexPath.row]
        return cell
    }
    
}

extension NRCpopupViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //print("selected township code", self.townshipList[indexPath.row])
        townshipDelegate?.onClickTownshipCode(townshipCode: self.townshipList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(50.0)
    }
}

