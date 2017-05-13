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
        
        // MARK: 改变提示文字颜色\输入框背景
        
        // 1.根据key取出搜索框中的文本输入框
        let searchFiled = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        // 此时键盘的return 键盘为 search 样式，暗示用户，点击return键后，搜索结果
        searchFiled?.returnKeyType = .search
        // 设置键盘样式
        searchFiled?.keyboardType = .URL

        
        // 2.设置文本输入框背景颜色
        searchFiled?.backgroundColor = UIColor(red:0.11, green:0.45, blue:0.71, alpha:1.00)
        
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
        
        configNavigationBar()
        configUI()
        
    }
    
    
    /// 配置 UI 界面
    private func configUI() {
        
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
        
        
        // 设置导航栏背景色
        navigationController?.navigationBar.barTintColor = LightBlue
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        
        /* 右边的Item */
        
        /// 通讯录按钮
        let addressBook = UIButton()
        addressBook.setImage(UIImage(named: "home_contacts"), for: .normal)
        addressBook.sizeToFit()
        addressBook.addTarget(self, action: #selector(addressBookBtnClicked), for: .touchUpInside)
    
        /// 加号按钮
        let addBtn = UIButton()
        addBtn.setImage(UIImage(named: "ap_more"), for: .normal)
        addBtn.sizeToFit()
        addBtn.addTarget(self, action: #selector(addressBookBtnClicked), for: .touchUpInside)
        
        let addBtnItem = UIBarButtonItem(customView: addBtn)
        let addressBookItem = UIBarButtonItem(customView: addressBook)
        
        navigationItem.rightBarButtonItems = [addBtnItem, addressBookItem]
        

        
        
        
    }
    
    // 通讯录按钮点击事件
    @objc private func addressBookBtnClicked() {
        
    }
    

}











