//
//  HomeTopView.swift
//  Alipay
//
//  Created by Liu Chuan on 2017/5/4.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 顶部功能按钮视图
class HomeTopView: UIView {

    /// 按钮数据数组
    fileprivate let buttonsInfo = [["imageName": "home_scan", "title": "扫一扫"],
                                   ["imageName": "home_pay", "title": "付款"],
                                   ["imageName": "shoukuan", "title": "收钱"],
                                   ["imageName": "home_card", "title": "卡包"],
    ]
    
    var btn: HomeTopViewButton = {
        let btn = HomeTopViewButton()
        return btn
    }()
    
    /// 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    override func awakeFromNib() {
    
    }
    
    /// 设置UI界面
    fileprivate func setupUI() {
        
        setupHomeTopViewWithBtn()   
    }
    
    /// 设置首页功能按钮视图的按钮
    private func setupHomeTopViewWithBtn() {
        
        // 定义临时变量
        let btnWidth: CGFloat = 80
        let btnHeight: CGFloat = 80
        let btnY: CGFloat = 0
        
        // margin:按钮之间的间距 =  视图的宽度 - 4个按钮的宽度 / 5
        let margin = (screenW - 4 * btnWidth) / 5
        
        for i in 0..<buttonsInfo.count {
            
            // 如果i大于按钮数组的个数, 就跳出循环体
            if i >= buttonsInfo.count { break }
            
            // 0>. 从数组字典中获取图片名称\标题
            let dict = buttonsInfo[i]
            
            // 如何没有找到对应字典, 继续执行循环体
            guard let imageName = dict["imageName"], let title = dict["title"] else { continue }
            
            // 1>. 创建按钮, 并设置其相关属性
            let column = i % 4                          // 列: 每行4个按钮
            let btnX = CGFloat(column + 1) * margin + CGFloat(column) * btnWidth
            
            btn = HomeTopViewButton.homeTopViewButton(imageName: imageName, title: title)
            btn.tag = i
            btn.frame = CGRect(x: btnX, y: btnY, width: btnWidth, height: btnHeight)
            btn.addTarget(self, action: #selector(btnclicked(_:)), for: .touchUpInside)
            
            
            // 2>. 添加按钮到视图中
            addSubview(btn)
        }
 
        
    }
    
    
    /// 按钮点击事件
    @objc private func btnclicked(_ btn: UIButton) {
        
        // 获取 根视图控制器上 添加的所有控制器
        let controllers = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers
        
        // 获取首页控制器
        let HomeVC = controllers![0].childViewControllers[0]
        
        switch btn.tag {
        case 0:
            
            print("\(btn.titleLabel!.text!) - \(btn.tag)")
           
            // 获取storyboard 二维码控制器
            let storyBoard = UIStoryboard(name: "QRCodeController", bundle: nil)
            let qrcodeVC = storyBoard.instantiateInitialViewController()
            
            HomeVC.present(qrcodeVC!, animated: true, completion: nil)      // motal展现
            
            // 非 motal 展现
            //rootVC?[0].navigationController?.pushViewController(qrcodeVC!, animated: true)
           // _ = navigationController?.pushViewController(qrcVC!, animated: true)

        case 1:
            print("\(btn.titleLabel!.text!) - \(btn.tag)")
        case 2:
            print("\(btn.titleLabel!.text!) - \(btn.tag)")
        case 3:
            print("\(btn.titleLabel!.text!) - \(btn.tag)")
        default:
            print("点击了......")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
