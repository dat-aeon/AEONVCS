//
//  FAQViewController.swift
//  AEON
//
//  Created by Khin Yadanar Thein on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FAQViewController: BaseUIViewController {
    @IBOutlet weak var tvFAQView: UITableView!
    var dataList = [FAQHeaderListItem]()
    var dataListMM = [FAQHeaderListItem]()
    var dataListEN = [FAQHeaderListItem]()
    var localeFlag: UIBarButtonItem!
    var flag: UIImage!
    
    var isDidLoad = false
    //var faqDataList = [FAQCateoryDataBeanElement]()
    
    var showNavBar:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if showNavBar {
            self.view.backgroundColor = UIColor(netHex: 0xB70081)
            let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: 48))
            navBar.tintColor = UIColor.white
            navBar.barTintColor = UIColor(netHex: 0xB70081)
            navBar.backgroundColor = UIColor(netHex: 0xB70081)
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navBar.titleTextAttributes = textAttributes
            
            self.view.addSubview(navBar);
            
            let navItem = UINavigationItem(title: "FAQ");
            let closeItem = UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: nil, action: #selector(onClickCloseBtn))
            
            switch Locale.currentLocale {
            case .EN:
                self.flag = UIImage(named: "mm_flag")
            case .MY:
                self.flag = UIImage(named: "en_flag")
            }
            
            self.localeFlag = UIBarButtonItem(image: self.flag, style: .done, target: nil, action: #selector(onClickLocaleFlag))
            navItem.leftBarButtonItem = closeItem
            navItem.rightBarButtonItem = localeFlag
            navBar.setItems([navItem], animated: false);
            
            self.tvFAQView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 16, right: 0);
            
        }
        
        isDidLoad = true
        self.reloadFAQList()
        
        //dataList = FAQDataModel.init().getFAQHeaderListItemData()
//        print("Data List size ::::::::::::::::: \(dataList.count)")
        tvFAQView.register(UINib(nibName: CommonNames.FAQ_HEADER_TABLE_CELL, bundle: nil), forHeaderFooterViewReuseIdentifier: CommonNames.FAQ_HEADER_TABLE_CELL)
        tvFAQView.register(UINib(nibName: CommonNames.FAQ_TABLE_CELL, bundle: nil), forCellReuseIdentifier: CommonNames.FAQ_TABLE_CELL)
        tvFAQView.dataSource = self
        tvFAQView.delegate = self
        
        tvFAQView.estimatedRowHeight = CGFloat(50.0)
        tvFAQView.rowHeight = UITableView.automaticDimension
        
        tvFAQView.estimatedSectionHeaderHeight = CGFloat(100.0)
        tvFAQView.sectionHeaderHeight = UITableView.automaticDimension
        
    }
    @objc func onClickCloseBtn(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickLocaleFlag(){
        super.updateLocale()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isDidLoad {
            isDidLoad = false
        } else {
            self.reloadFAQList()
        }
    }
    func reloadFAQList() {
        // check network
        if Network.reachability.isReachable == false {
            Utils.showAlert(viewcontroller: self, title: Constants.NETWORK_CONNECTION_TITLE, message: Messages.NETWORK_CONNECTION_ERROR.localized)
            return
        }
        
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        FAQViewModel.init().getFAQData(siteActivationKey: Constants.site_activation_key, success: { (resultEN,resultMM) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
//            print("Result on Controller ::::::::::::::::: \(resultEN.count)")
            self.dataListEN = resultEN
            self.dataListMM = resultMM
            
            switch Locale.currentLocale {
            case .EN:
                self.flag = UIImage(named: "mm_flag")
                self.dataList = resultEN
            case .MY:
                self.flag = UIImage(named: "en_flag")
                self.dataList = resultMM
            }
            self.tvFAQView.reloadData()
            
        }) { (error) in
            
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            if error == Constants.SERVER_FAILURE {
                let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: CommonNames.SERVICE_UNAVAILABLE_VIEW_CONTROLLER) as! UINavigationController
                navigationVC.modalPresentationStyle = .overFullScreen
                self.present(navigationVC, animated: true, completion: nil)
                
            } else {
                Utils.showAlert(viewcontroller: self, title: Constants.FAQ_LOADING_ERROR_TITLE, message: error)
            }
            
        }
    }
    
    func reloadSections(section:Int) {
        self.tvFAQView?.beginUpdates()
        self.tvFAQView?.reloadSections([section], with: .automatic)
        self.tvFAQView?.endUpdates()
    }
    
    @objc override func updateViews() {
        super.updateViews()
        switch Locale.currentLocale {
        case .EN:
            self.flag = UIImage(named: "mm_flag")
            self.dataList = self.dataListEN
        case .MY:
            self.flag = UIImage(named: "en_flag")
            self.dataList = self.dataListMM
        }
        self.tvFAQView.reloadData()
    }
}

extension FAQViewController:UITableViewDataSource{
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
    
    
    
}

extension FAQViewController:UITableViewDelegate{
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

extension FAQViewController:UITableViewHeaderDelegate{
    func toggleSection(header: FAQHeaderView, section: Int) {
        let item = dataList[section]
        if item.isCollapsible {
            
            // Toggle collapse
            let collapsed = !item.isCollapsed
            
            self.dataList[section].isCollapsed = collapsed
            
            reloadSections(section: section)
            
            UIView.transition(with: tvFAQView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.tvFAQView.reloadData() })
         
        }
    }
}

extension FAQViewController:UITableViewCellDelegate{
    func toggleItemCell(cell:FAQTableViewCell,section:Int,position: Int,isCollapsed:Bool) {
        let item = dataList[section].faqList[position]
        let collapsed = !item.isCollapsed
        self.dataList[section].faqList[position].isCollapsed = collapsed
        let indexPath = IndexPath(row: position, section: section)
        
        tvFAQView.reloadRows(at: [indexPath], with: .fade)
        
    }
}
