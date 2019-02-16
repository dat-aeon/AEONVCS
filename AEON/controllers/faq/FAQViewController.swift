//
//  FAQViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit

class FAQViewController: BaseUIViewController {
    @IBOutlet weak var tvFAQView: UITableView!
    var dataList = [FAQHeaderListItem]()
    
    //var faqDataList = [FAQCateoryDataBeanElement]()
    
    var showNavBar:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if showNavBar {
            self.view.backgroundColor = UIColor(netHex: 0xB70081)
            let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: 48))
            navBar.tintColor = UIColor.white
            navBar.barTintColor = UIColor(netHex: 0xB70081)
            navBar.backgroundColor = UIColor(netHex: 0xB70081)
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navBar.titleTextAttributes = textAttributes
            
            self.view.addSubview(navBar);
            
            let navItem = UINavigationItem(title: "FAQ");
            let closeItem = UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: nil, action: #selector(onClickCloseBtn))
            navItem.leftBarButtonItem = closeItem
            
            navBar.setItems([navItem], animated: false);
            
            self.tvFAQView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 16, right: 0);
            
        }
        
        FAQViewModel.init().getFAQData(siteActivationKey: "123456", success: { (resultEN,resultMM) in
            
            print("Result on Controller ::::::::::::::::: \(resultEN.count)")
            
            switch Locale.currentLocale {
            case .EN:
                self.dataList = resultEN
            case .MY:
                self.dataList = resultMM
            }
            self.tvFAQView.reloadData()
            
        }) { (error) in
            // Utils.showAlert(viewcontroller: self, title: "Login Error", message: error)
            }
        
        
        //dataList = FAQDataModel.init().getFAQHeaderListItemData()
        print("Data List size ::::::::::::::::: \(dataList.count)")
        tvFAQView.register(UINib(nibName: "FAQTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQTableViewCell")
        tvFAQView.register(UINib(nibName: "FAQHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FAQHeaderView")
        tvFAQView.dataSource = self
        tvFAQView.delegate = self
        
        tvFAQView.estimatedRowHeight = CGFloat(100.0)
        tvFAQView.rowHeight = UITableView.automaticDimension
        
        tvFAQView.estimatedSectionHeaderHeight = CGFloat(100.0)
        tvFAQView.sectionHeaderHeight = UITableView.automaticDimension
        
        }
    @objc func onClickCloseBtn(){
        self.dismiss(animated: true, completion: nil)
    }
//
//    func sizeHeaderToFit() {
//        let headerView = tvFAQView.tableHeaderView!
//
//        headerView.setNeedsLayout()
//        headerView.layoutIfNeeded()
//
//        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//
//        var frame = headerView.frame
//        frame.size.height = height
//        headerView.frame = frame
//
//        tvFAQView.tableHeaderView = headerView
//    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func reloadSections(section:Int) {
        self.tvFAQView?.beginUpdates()
        self.tvFAQView?.reloadSections([section], with: .automatic)
        self.tvFAQView?.endUpdates()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
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
            //            item.isCollapsed = collapsed
            //            header.setCollapsed(collapsed: collapsed)
            
            //            var i=0
            //            while i<dataList.count{
            //                self.dataList[i].isCollapsed = false
            //                i = i+1
            //            }
            
            // Adjust the number of the rows inside the section
            
            //            var i=0
            //            while i < tvFAQView.numberOfSections{
            //                self.dataList[i].isCollapsed = false
            //                i = i+1
            //            }
            
            //            var ii=0
            //            while ii < tvFAQView.numberOfRows(inSection: section){
            //                self.dataList[section].faqList[ii].isCollapsed = false
            //                let indexPath = IndexPath(row: ii, section: section)
            //                tvFAQView.reloadRows(at: [indexPath], with: .fade)
            //                ii = ii+1
            //            }
            
            self.dataList[section].isCollapsed = collapsed
            
            reloadSections(section: section)
            //            if item.isFirstLoading{
            //             self.dataList[section].isFirstLoading = false
            
            UIView.transition(with: tvFAQView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.tvFAQView.reloadData() })
            //            }
            //            let transition = CATransition()
            //            options: .transitionCrossDissolve,
            //            transition.type = CATransitionType.push
            //            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            //            transition.fillMode = CAMediaTimingFillMode.forwards
            //            transition.duration = 0.5
            //            transition.subtype = CATransitionSubtype.fromTop
            //            self.tvFAQView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
            //            // Update your data source here
            //            self.tvFAQView.reloadData()
            
        }
    }
}

extension FAQViewController:UITableViewCellDelegate{
    func toggleItemCell(cell:FAQTableViewCell,section:Int,position: Int,isCollapsed:Bool) {
        let item = dataList[section].faqList[position]
        let collapsed = !item.isCollapsed
        
        //        cell.setCollapsed(collapsed: collapsed)
        self.dataList[section].faqList[position].isCollapsed = collapsed
        //        let cell = self.tvFAQView.cellForRow(at: IndexPath(row: position, section: section)) as? FAQTableViewCell
        let indexPath = IndexPath(row: position, section: section)
        
        tvFAQView.reloadRows(at: [indexPath], with: .fade)
        
    }
}
