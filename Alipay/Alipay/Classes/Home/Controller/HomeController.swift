//
//  HomeController.swift
//  Alipay
//
//  Created by Liu Chuan on 2017/5/4.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import SnapKit


/// 自定义导航栏完全不透明时的偏移量边界(根据需求设定)
private let alphaChangeBoundary = screenW * (212 / 375) - 64

/// 功能按钮视图高度
private let topViewH: CGFloat = 115


class HomeController: UIViewController {
    
    
    /// 按钮数据数组
    fileprivate let buttonsInfo = [["imageName": "pay_mini", "title": ""],
                                   ["imageName": "search_mini", "title": ""],
                                   ["imageName": "scan_mini", "title": ""],
   ]

    
    
    
    
    
    // MARK: - 懒加载
    /// 顶部功能按钮视图
    fileprivate lazy var topView: HomeTopView = {
        let topView = HomeTopView()
        topView.backgroundColor = LightBlue
        return topView
    }()

    /// 功能列表界面
    fileprivate lazy var listView: UIView = {
        let listView = UIView()
        listView.backgroundColor = UIColor.orange
        return listView
    }()


    /// 覆盖导航栏
    fileprivate lazy var coverNavView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: navigationH + statusH))
        view.backgroundColor = LightBlue
        
        let payButton = UIButton(type: UIButtonType.custom)
        payButton.setImage(#imageLiteral(resourceName: "pay_mini"), for: UIControlState.normal)
        payButton.sizeToFit()
  
        
        var newFrame = payButton.frame
        newFrame.origin.y = 30
        newFrame.origin.x = 10
        newFrame.size.width = newFrame.size.width + 10
        payButton.frame = newFrame
        
        let scanButton = UIButton(type: UIButtonType.custom)
        scanButton.setImage(#imageLiteral(resourceName: "scan_mini"), for: UIControlState.normal)
        scanButton.sizeToFit()
        
        
        newFrame.origin.x = newFrame.origin.x + 40 + newFrame.size.width
        scanButton.frame = newFrame

        let searchButton = UIButton(type: UIButtonType.custom)
        searchButton.setImage(#imageLiteral(resourceName: "search_mini"), for: UIControlState.normal)
        searchButton.sizeToFit()
        newFrame.origin.x = newFrame.origin.x + 40 + newFrame.size.width
        searchButton.frame = newFrame
        
        view.addSubview(scanButton)
        view.addSubview(payButton)
        view.addSubview(searchButton)
        
        view.alpha = 0
        return view
    }()
 

    lazy var navView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 64))
        view.backgroundColor = darkBlue
        return view
        
    }()

    /// 表格视图
    fileprivate lazy var tableView: UITableView = { [weak self] in
        
        let tableView = UITableView(frame: (self?.view.bounds)!, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self

        // 设置表格顶部间距, 使得HaderView不被遮挡
        tableView.contentInset = UIEdgeInsets(top: topViewH, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        
        return tableView
        
    }()
    
    /// 搜索栏
    fileprivate lazy var searchBarController : UISearchController = {
       
        let searchController = UISearchController(searchResultsController: nil)
        
        // 设置搜索框的风格
//        searchController.searchBar.barStyle = UIBarStyle.blackTranslucent
        
        // 开始输入时，背景是否变暗
        searchController.dimsBackgroundDuringPresentation = false
        
        // 开始搜索时, 是否隐藏导航栏
        searchController.hidesNavigationBarDuringPresentation = false
        
        // 设置搜索框的提示文字, 后面加上空格, 使得放大镜\文字都 居左显示
        searchController.searchBar.placeholder = "蚂蚁森林                                                    "
        //向下的箭头
//        searchController.searchBar.showsSearchResultsButton = true
        
        // 自动调整搜索框大小
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.delegate = self
        
        // MARK: 改变提示文字颜色\输入框背景
        
        // 1.根据key取出搜索框中的文本输入框
        let searchFiled = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        // 此时键盘的return 键盘为 search 样式，暗示用户，点击return键后，搜索结果
        searchFiled?.returnKeyType = .search
        // 设置键盘样式
        searchFiled?.keyboardType = .URL

        // 2.设置文本输入框背景颜色
        searchFiled?.backgroundColor = textFieldBackgroundColor
        
        // 3.然后取出文本输入框的提示文字
        let PlaceholderLabel = searchFiled?.value(forKey: "placeholderLabel") as? UILabel
        
        // 4.设置提示文字颜色\字体大小
        PlaceholderLabel?.textColor = UIColor.white
        PlaceholderLabel?.font = UIFont.systemFont(ofSize: 13)
        
        // 设置 textfield 放大镜不显示
        // searchFiled?.leftViewMode = UITextFieldViewMode.never
        
        // 设置 searchBar 放大镜图标
        searchController.searchBar.setImage(UIImage(named: "ap_titlebar_search_content"), for: .search, state: .normal)
        
        return searchController

    }()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    
    // 视图即将可见时, 调用
    override func viewWillAppear(_ animated: Bool) {
        //界面将显示隐藏系统导航栏，添加自定义导航栏，防止从后面界面pop回此界面时导航栏显示有问题
//        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.view.insertSubview(coverNavView, at: 1)
        
    }
    
    
    // 视图即将消失时, 调用
    override func viewWillDisappear(_ animated: Bool) {
        
        //界面将要消失时，显示系统导航栏，移除自定义的导航栏
        coverNavView.removeFromSuperview()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        //调用此方法,解决滑动返回的bug
        performSelector(onMainThread: #selector(delayHidden), with: animated, waitUntilDone: false)
        
    }
    
    
    @objc private func delayHidden() {
         navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

// MARK: - 配置UI界面
extension HomeController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        configNavigationBar()
        layoutView()
        
    }
    
    
    /// 布局界面
    private func layoutView() {
        
        // 添加控件
        view.addSubview(tableView)
        view.insertSubview(topView, aboveSubview: tableView)
        
//        view.addSubview(navView)
//        view.addSubview(topView)
//        view.addSubview(listView)
//        view.addSubview(coverNavView)


        // 使用 SnapKit 布局
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(topViewH)
        }
        
//        listView.snp.makeConstraints { (make) in
//            make.left.bottom.right.equalToSuperview()
//            make.top.equalTo(topView.snp.bottom).offset(0)
//        }
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 设置导航栏LOGO
        navigationItem.titleView = searchBarController.searchBar
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        
        /* 右边的Item */
        
        /// 尺寸
        let size = CGSize(width: 30, height: 30)
        
        /// 通讯录按钮
        let addressBook = UIButton()
        addressBook.setImage(UIImage(named: "home_contacts"), for: .normal)
        addressBook.frame = CGRect(origin: CGPoint.zero, size: size)
        addressBook.addTarget(self, action: #selector(addressBookBtnClicked), for: .touchUpInside)
        
        /// 加号按钮
        let addBtn = UIButton()
        addBtn.setImage(UIImage(named: "ap_more"), for: .normal)
        addBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        addBtn.addTarget(self, action: #selector(addBtnClicked(_:)), for: .touchUpInside)
        
        let addBtnItem = UIBarButtonItem(customView: addBtn)
        let addressBookItem = UIBarButtonItem(customView: addressBook)
        
        navigationItem.rightBarButtonItems = [addBtnItem, addressBookItem]
    }
 
}

// MARK: - 事件监听
extension HomeController {
    
    // 通讯录按钮点击事件
    @objc fileprivate func addressBookBtnClicked() {
     
        print("点击了导航栏上的按钮")
    }
    
    /// 加号按钮点击事件
    @objc fileprivate func addBtnClicked(_ sender: UIButton) {
        print("点击了+号按钮!!!")
        
        // 以popover的方式, 展现一个视图控制器
        // 1.创建弹出控制器
        let popVC = PopViewController()
        
        // 设置转场动画的样式
        popVC.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // 如果sourceView是UIBarButtonItem类型，必须要有下面这一句.
        // 这里的sender是UIButton类型的，所已不需要上面那一句
        popVC.popoverPresentationController?.sourceView = sender
        
        //popVC.popoverPresentationController?.barButtonItem = sender
        
        // 设置箭头的位置，原点可以参照某一个控件的尺寸设置，宽高通常用于设置附加的偏移量，通常传入0即可
        // 指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
        popVC.popoverPresentationController?.sourceRect = sender.bounds
        
        
        // 取消箭头
        //popVC.popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
        
        // 设置转场动画的代理
        popVC.popoverPresentationController?.delegate = self
        
        popVC.popoverPresentationController?.backgroundColor = UIColor.white
        
        // 弹出控制器
        present(popVC, animated: true, completion: nil)

    }
}


// MARK: - 遵守 UIPopoverPresentationControllerDelegate 协议
extension HomeController: UIPopoverPresentationControllerDelegate {
    // 模态动画的样式
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // 不使用系统默认的展现样式！
        return UIModalPresentationStyle.none
    }
    // 弹框消失时调用的方法
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    // 点击蒙版是否消失，默认为true
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    
}

// MARK: - 遵守 UISearchBarDelegate 协议
extension HomeController : UISearchBarDelegate {
    

    // MARK: searchBarShouldBeginEditing: 当点击搜索框进行编辑时,触发该方法
    // false: searchBar 成为第一响应者  true: searchBar 不成为第一响应者
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        print("............点击了搜索框")
        
        // MARK: 为搜索控制器添加导航栏
        
        // 1.0 创建搜索控制器
        let search = SearchViewController()
        
        search.view.backgroundColor = UIColor.groupTableViewBackground
        
        // MARK: 改变弹出控制器 搜索框 提示文字颜色\输入框背景
        
        // 1.1 根据key取出搜索框中的文本输入框
        let searchFiled = search.searchBar.value(forKey: "searchField") as? UITextField
        
        // 1.2 设置文本输入框背景颜色
        searchFiled?.backgroundColor = textFieldBackgroundColor
        
        // 1.3 然后取出文本输入框的提示文字
        let PlaceholderLabel = searchFiled?.value(forKey: "placeholderLabel") as? UILabel
        
        // 1.4 设置提示文字颜色
        PlaceholderLabel?.textColor = .white
        
        // 1.5 设置文本输入框, 输入文本颜色
        searchFiled?.textColor = .white
        
        // 2.0 设置 搜索控制器 为导航控制器的 根控制器
        let nav = UINavigationController(rootViewController: search)
        
        // 2.1 设置导航控制器相关属性
        nav.navigationBar.barTintColor = LightBlue
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.tintColor = UIColor.white
        
        // 3.跳转到导航控制器
        // 模态跳转到控制器
        self.navigationController?.present(nav, animated: true, completion: nil)
        
        // 非模态跳转
        //  navigationController?.pushViewController(search, animated: true)
        // 延迟1秒执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC))/Double(NSEC_PER_SEC) , execute: {
            
            // searchBar 成为第一响应, 从而弹出键盘
            search.searchBar.becomeFirstResponder()
        })
        
        return false
    }
    
    
}


// MARK: - 遵守 UITableViewDelegate 协议
extension HomeController: UITableViewDelegate {

/*
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
         contentOffset: 即偏移量,contentOffset.y = 内容的顶部和frame顶部的差值,contentOffset.x = 内容的左边和frame左边的差值.
         contentInset:  即内边距,contentInset = 在内容周围增加的间距(粘着内容),contentInset的单位是UIEdgeInsets
         
         */
        // 偏移量: -200 + 顶部边距: 200, 等于0
//        let offsetY = scrollView.contentOffset.y + scrollView.contentInset.top
        
        
    
    //let offsetY = scrollView.contentOffset.y
        
      //  print(offsetY)
    

/*
        if offsetY <= 115 && offsetY > 0 {
        
        
//        if offsetY > 0 {
            
            
            topView.frame.size.height = 115
            topView.frame.origin.y = -offsetY
            coverNavView.frame.origin.y = -64
            
            let topViewMinY = 115 - navigationH - statusH
            
            // 取最小值
            topView.frame.origin.y =  -min(topViewMinY, offsetY)

            
            let progress = 1 - (offsetY / topViewMinY)
            topView.alpha = progress
            coverNavView.alpha = progress
            navigationController?.navigationBar.alpha = progress

 /*
            topView.frame = topView.frame
            topView.frame.origin.y = 0
            
 */
            
            //处理透明度
            let alpha = (1 - offsetY / 115 * 2.5 ) > 0 ? (1 - offsetY / 115 * 2.5 ) : 0
            
            if alpha > 0.5 {
                topView.alpha = alpha * 2 - 1
                coverNavView.alpha = 0
            } else {
                topView.alpha = 0
                coverNavView.alpha = 1 - alpha * 2
            }

            
        } else if offsetY <= 0 {
            topView.frame = topView.frame
            topView.frame.origin.y = 0
            topView.alpha = 1
            coverNavView.alpha = 0
            coverNavView.frame.origin.y = -64
            
        }
    }
    
    
    
*/
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            
            let offsetY = scrollView.contentOffset.y
            print(offsetY)
            
            if offsetY >= 0 && offsetY <= alphaChangeBoundary {
                coverNavView.backgroundColor = LightBlue.withAlphaComponent(offsetY / alphaChangeBoundary)
            }else if offsetY > alphaChangeBoundary {
                coverNavView.backgroundColor = LightBlue
            }else {
                coverNavView.backgroundColor = LightBlue.withAlphaComponent(0)
            }
            
            if offsetY <= 0 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.coverNavView.alpha = 0
                    self.topView.alpha = 1
                    //self.topView.btn.isHidden = false
                    self.topView.frame.size.height = topViewH
                })
                
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                
            }else{
               
                UIView.animate(withDuration: 0.25, animations: {
                    self.coverNavView.alpha = 1
                    self.topView.alpha = 0
                    //self.topView.btn.isHidden = true
                    self.topView.frame.size.height = 0
                    
                })
                
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
            
        }

    }



// MARK: - 遵守 UITableViewDataSource 协议
extension HomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}






