//
//  HomeController.swift
//  Alipay
//
//  Created by Liu Chuan on 2017/5/4.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UIViewController {
    
    
    // MARK: - 懒加载控件
    
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
}

// MARK: - 配置UI界面
extension HomeController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        configNavigationBar()
        
        // 添加控件
        view.addSubview(topView)
        view.addSubview(listView)
        
        // 使用 SnapKit 布局
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(115)
        }
        
        listView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(0)
        }
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
//        addressBook.sizeToFit()
        addressBook.frame = CGRect(origin: CGPoint.zero, size: size)
        addressBook.addTarget(self, action: #selector(addressBookBtnClicked), for: .touchUpInside)
        
        /// 加号按钮
        let addBtn = UIButton()
        addBtn.setImage(UIImage(named: "ap_more"), for: .normal)
//        addBtn.sizeToFit()
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
    
    // MARK: touchesBegan: 点击屏幕时,触发该方法
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 设置 searchBar 不再是第一响应
        //        searchBarController.searchBar.resignFirstResponder()
        
    }
    
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
        PlaceholderLabel?.textColor = UIColor.white
        
        // 1.5 设置文本输入框, 输入文本颜色
        searchFiled?.textColor = UIColor.white
        
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











