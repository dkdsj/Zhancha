//
//  MainTabBarVC.swift
//  Zhacha
//
//  Created by ZZ on 2019/9/2.
//  Copyright © 2019 ZZ. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addChildVC("HomeVC", imageName: "tab_home", title: "首页")
//        addChildVC("ProfileVC", imageName: "tab_profile", title: "我的")
        
        loadVCsFromJsonFile(name: "MainVCSettings")
    }
    
    
    //
    // MARK: -  从json加载控制器
    //

    private func loadVCsFromJsonFile(name: String) {
        // 1.文件路径
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            extLog("\(name) file isn't exist")
            return
        }
        
        // 2.读取json文件内容
        guard let jsonData = NSData(contentsOfFile: path) else {
            extLog("\(name) file no data")
            return
        }
    
        //data2字典数组
        guard let jsonObj = try? JSONSerialization.jsonObject(with: (jsonData as Data), options: .mutableContainers) else {
            extLog("jsonObject = nil")
            return
        }
        
        guard let jsonArr = jsonObj as? [[String: Any]] else {
            extLog("jsonArr = nil")
            return
        }
        
        
        let exeName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        
        for dic in jsonArr {
            // 1.获取控制器name
            guard let vcName = dic["vcName"] as? String else {
                continue
            }
            
            // 2.获取控制器title
            guard let vcTitle = dic["title"] as? String else {
                continue
            }
            
            // 3.获取控制器image
            guard let vcImageName = dic["imageName"] as? String else {
                continue
            }
            
            //将对应的AnyClass?转成vc的类型
            let clsName = exeName! + "." + vcName
            guard let childCls = NSClassFromString(clsName) as? UIViewController.Type else {
                extLog("无对应的 \(clsName).Type")
                continue
            }
            
            //图片没有的话 tabbarItem的title不显示
            let imageNormal = UIImage(named: vcImageName)?.withRenderingMode(.alwaysOriginal)
            let imageSelected = UIImage(named: vcImageName+"_selected")?.withRenderingMode(.alwaysOriginal)
            
            //vc
            let childVC = childCls.init()
            childVC.navigationItem.title = vcTitle
            childVC.tabBarItem.title = vcTitle
            childVC.tabBarItem.image = imageNormal
            childVC.tabBarItem.selectedImage = imageSelected
            setTabBarItemAttributes(childVC)
            addChild(UINavigationController(rootViewController: childVC))
        }
    }
    
    
    //
    // MARK: - 普通加载vc
    //

    //private func addChildVC(_ className: String, imageName: String, selectedImageName: String, title: String) {
    private func addChildVC(_ className: String, imageName: String, title: String) {
        
        //第一步：获取项目名称 https://blog.csdn.net/weixin_42349140/article/details/80948019
        let exeName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String

        //第二步：拼接参数字符串 项目名+.+需要加载的类的名称
        let clsName = exeName! + "." + "\(className)"
        
        //将对应的AnyClass?转成vc的类型
        guard let childCls = NSClassFromString(clsName) as? UIViewController.Type else {
            extLog("无对应的 \(className).Type")
            return
        }
        
        //第三步：创建对应的控制器对象
        let imageNormal = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let imageSelected = UIImage(named: imageName+"_selected")?.withRenderingMode(.alwaysOriginal)
        
        let childVC = childCls.init()
        childVC.navigationItem.title = title
        childVC.tabBarItem.title = title
        childVC.tabBarItem.image = imageNormal
        childVC.tabBarItem.selectedImage = imageSelected
        
        //第四步：设置文字大小颜色
        setTabBarItemAttributes(childVC)
        
        //第五步：嵌入导航栏
        addChild(UINavigationController(rootViewController: childVC))
        
    }
    
    private func setTabBarItemAttributes(_ vc: UIViewController) {
        
        //方式一：设置vc的
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.extHex(0x48D1CC), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], for: .selected)
        
        //方式二：设置全局的
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.extHex(0x48D1CC), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)], for: .selected)
    }

}
