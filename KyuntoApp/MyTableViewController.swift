//
//  MyTableViewController.swift
//  KyuntoApp
//
//  Created by 坂本のぞみ on 2016/12/10.
//  Copyright © 2016年 saki takada. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // カスタマイズ
        
        // アイコンの色
        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 200/255, blue: 18/255, alpha: 1.0) // yellow
        
        // 背景色
//        UITabBar.appearance().barTintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        // grey black

        UITabBar.appearance().barTintColor = UIColor.white
        // white
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
