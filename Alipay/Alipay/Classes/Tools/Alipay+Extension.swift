//
//  Alipay+Extension.swift
//  Alipay
//
//  Created by Liu Chuan on 2016/9/25.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
let screenW = UIScreen.main.bounds.width    // 屏幕的宽度
let screenH = UIScreen.main.bounds.height   // 屏幕的高度
let statusH: CGFloat = 20                   // 状态栏的高度
let navigationH: CGFloat = 44               // 导航栏的高度
let tabBarH: CGFloat = 49                   // 标签栏的高度

let scrollLineH: CGFloat = 2                // 底部滚动滑块的高度
let titleViewH: CGFloat = 44                // 标题滚动视图的高度
let CycleViewHeight = screenW * 3 / 6       // 轮播图高度
let refresh_HeaderViewHeight: CGFloat = 90  // 刷新视图高度
let refresh_FooterViewHeight: CGFloat = 60  // 底部加载更多视图高度
let SpreadMaxH:CGFloat = screenH - 64       // 默认下拉展开的最大高度

let LightBlue = UIColor(red:0.12, green:0.52, blue:0.81, alpha:1.00)                //全局颜色: 淡蓝色
let darkBlue = UIColor(red:0.21, green:0.27, blue:0.31, alpha:1.00)                 //全局颜色: 深蓝
let textFieldBackgroundColor = UIColor(red:0.11, green:0.45, blue:0.71, alpha:1.00) //全局颜色: 文本输入框背景色
