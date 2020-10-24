//
//  FAQMainViewController.swift
//  AEONVCS
//
//  Created by mac on 3/12/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FAQMainViewController: BaseUIViewController {

    @IBOutlet weak var tvFAQView: UITableView!
    @IBOutlet weak var bbCloseBtn: UIBarButtonItem!
    @IBOutlet weak var bbLocaleFlag: UIBarButtonItem!
    
    var dataList = [FAQHeaderListItem]()
    var dataListMM = [FAQHeaderListItem]()
    var dataListEN = [FAQHeaderListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // check network
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        self.title = "faq.title".localized
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        FAQViewModel.init().getFAQData(siteActivationKey: Constants.site_activation_key, success: { (resultEN,resultMM) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            print("Result on Controller ::::::::::::::::: \(resultEN.count)")
            self.dataListEN = resultEN
            self.dataListMM = resultMM
            
            switch Locale.currentLocale {
            case .EN:
                self.bbLocaleFlag.image = UIImage(named: "mm_flag")
                self.dataList = resultEN
            case .MY:
                self.bbLocaleFlag.image = UIImage(named: "en_flag")
                self.dataList = resultMM
            }
            self.title = "faq.title".localized
            self.tvFAQView.reloadData()
            
        }) { (error) in
            if error == Constants.SERVER_FAILURE {
                CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                 navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.FAQ_LOADING_ERROR_TITLE, message: error)
            }
            
        }
        
        
        //dataList = FAQDataModel.init().getFAQHeaderListItemData()
//        print("Data List size ::::::::::::::::: \(dataList.count)")
        tvFAQView.register(UINib(nibName: CommonNames.FAQ_HEADER_TABLE_CELL, bundle: nil), forHeaderFooterViewReuseIdentifier: CommonNames.FAQ_HEADER_TABLE_CELL)
        tvFAQView.register(UINib(nibName: CommonNames.FAQ_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.FAQ_TABLE_CELL)
        tvFAQView.dataSource = self
        tvFAQView.delegate = self
        
        tvFAQView.estimatedRowHeight = CGFloat(30.0)
        tvFAQView.rowHeight = UITableView.automaticDimension
        
        tvFAQView.estimatedSectionHeaderHeight = CGFloat(100.0)
        tvFAQView.sectionHeaderHeight = UITableView.automaticDimension
        
        tvFAQView.tableFooterView = UIView()
        self.tvFAQView.reloadData()
    }
    @IBAction func onClickCloseBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickLocaleFlag(_ sender: UIBarButtonItem) {
        super.updateLocale()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // check network
        if Network.reachability.isReachable == false {
            super.networkConnectionError()
            return
        }
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        FAQViewModel.init().getFAQData(siteActivationKey: Constants.site_activation_key, success: { (resultEN,resultMM) in
            
//            print("Appear FAQViewController ::::::::::::::::: \(resultEN.count)")
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            self.dataListEN = resultEN
            self.dataListMM = resultMM
            
            switch Locale.currentLocale {
            case .EN:
                self.bbLocaleFlag.image = UIImage(named: "mm_flag")
                self.dataList = resultEN
            case .MY:
                self.bbLocaleFlag.image = UIImage(named: "en_flag")
                self.dataList = resultMM
            }
            self.tvFAQView.reloadData()
            
        }) { (error) in
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                 navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.LOADING_ERROR_TITLE, message: "FAQ : " + error)
            }
        }
    }
    
    func reloadSections(section:Int) {
        DispatchQueue.main.async {
            self.tvFAQView?.beginUpdates()
            self.tvFAQView?.reloadSections([section], with: .automatic)
            self.tvFAQView?.endUpdates()
           
        }
       
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            bbLocaleFlag.image = UIImage(named: "mm_flag")
            self.dataList = self.dataListEN
        case .MY:
            bbLocaleFlag.image = UIImage(named: "en_flag")
            self.dataList = self.dataListMM
        }
        self.title = "faq.title".localized
        self.tvFAQView.reloadData()
    }
}

extension FAQMainViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = dataList[section]
        if item.isCollapsed {
            return item.rowCount
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonNames.FAQ_TABLE_CELL, for: indexPath) as! FAQTableViewCell
        cell.section = indexPath.section
        cell.position = indexPath.row
        cell.delegate = self
        cell.setData(faqItem: dataList[indexPath.section].faqList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = dataList[section]
        if item.isCollapsed {
            return UITableView.automaticDimension
        } else {
            return 0.0
        }
    }
    
}

extension FAQMainViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FAQHeaderView.identifier) as? FAQHeaderView {
            
            let item = dataList[section]
            
            headerView.item = item
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }
    
}

extension FAQMainViewController:UITableViewHeaderDelegate{
    func toggleSection(header: FAQHeaderView, section: Int) {
        DispatchQueue.main.async {
            let item = self.dataList[section]
            if item.isCollapsible {
             
                    // Toggle collapse
                    let collapsed = !item.isCollapsed
                    
                    self.dataList[section].isCollapsed = collapsed
                    
                    self.reloadSections(section: section)
                    
                    UIView.transition(with: self.tvFAQView,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tvFAQView.reloadData() })
              
                
             
              
            }
          
        }
        
        
    }
}

extension FAQMainViewController:UITableViewCellDelegate{
    func toggleItemCell(cell:FAQTableViewCell,section:Int,position: Int,isCollapsed:Bool) {
        DispatchQueue.main.async {
            let item = self.dataList[section].faqList[position]
            let collapsed = !item.isCollapsed
            self.dataList[section].faqList[position].isCollapsed = collapsed
            let indexPath = IndexPath(row: position, section: section)
          
                self.tvFAQView.reloadRows(at: [indexPath], with: .fade)
            self.tvFAQView.reloadData()
        }
      
        
        
        
    }
}
