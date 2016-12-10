//
//  AppDelegate.swift
//  KyuntoApp
//
//  Created by 高田早記 on 2016/12/03.
//  Copyright © 2016年 saki takada. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    
//shiba
    
    //跳ねるスプラッシュ
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 18/255, alpha: 1)
        self.window!.makeKeyAndVisible()
        
        // rootViewController from StoryBoard
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "navigationController")
        self.window!.rootViewController = navigationController
        
        // logo mask
        navigationController.view.layer.mask = CALayer()
        navigationController.view.layer.mask!.contents = UIImage(named: "logo.png")!.cgImage
        navigationController.view.layer.mask!.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        navigationController.view.layer.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        navigationController.view.layer.mask!.position = CGPoint(x: navigationController.view.frame.width / 2, y: navigationController.view.frame.height / 2)
        
        // logo mask background view
        let maskBgView = UIView(frame: navigationController.view.frame)
        maskBgView.backgroundColor = UIColor.white
        navigationController.view.addSubview(maskBgView)
        navigationController.view.bringSubview(toFront: maskBgView)
        
        // logo mask animation
        let transformAnimation = CAKeyframeAnimation(keyPath: "bounds")
        //self.transformAnimation.delegate = self
        transformAnimation.duration = 1
        transformAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
        let initalBounds = NSValue(cgRect: (navigationController.view.layer.mask?.bounds)!)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        transformAnimation.values = [initalBounds, secondBounds, finalBounds]
        transformAnimation.keyTimes = [0, 0.5, 1]
        transformAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        transformAnimation.isRemovedOnCompletion = false
        transformAnimation.fillMode = kCAFillModeForwards
        navigationController.view.layer.mask!.add(transformAnimation, forKey: "maskAnimation")
        
        // logo mask background view animation
        UIView.animate(withDuration: 0.1,
                       delay: 1.35,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        maskBgView.alpha = 0.0
        },
                       completion: { finished in
                        maskBgView.removeFromSuperview()
        })
        
        // root view animation
        UIView.animate(withDuration: 0.25,
                       delay: 1.3,
                       options: UIViewAnimationOptions(),
                       animations: {
                        self.window!.rootViewController!.view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        },
                       completion: { finished in
                        UIView.animate(withDuration: 0.3,
                                       delay: 0.0,
                                       options: UIViewAnimationOptions(),
                                       animations: {
                                        self.window!.rootViewController!.view.transform = CGAffineTransform.identity
                        },
                                       completion: nil
                        )
        })
        
        //復帰したかどうか
        if let notification = launchOptions?[UIApplicationLaunchOptionsKey.localNotification] as? UILocalNotification,let userInfo = notification.userInfo{
            application.applicationIconBadgeNumber = 0
            application.cancelLocalNotification(notification)
        }
        //復帰に関係なくバッジが0じゃなければ0にする
        if application.applicationIconBadgeNumber != 0{
            application.applicationIconBadgeNumber = 0
        }
        //ユーザーに通知許可をもらうためのコード
        if #available(iOS 8.0, *) {
            // iOS8以上
            //forTypesは.Alertと.Soundと.Badgeがあります。
            let notiSettings = UIUserNotificationSettings(types:[.alert,.sound,.badge], categories:nil)
            application.registerUserNotificationSettings(notiSettings)
            application.registerForRemoteNotifications()
            
        } else{
            // iOS7以前
            application.registerForRemoteNotifications( matching: [.alert,.sound,.badge] )
        }
        
        
        
        return true
    }
    
    
    func SelectedViewCOntroller() {
        //windowを生成
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Viewcontrollerを指定
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "addViewController")
        //rootViewControllerに入れる
        self.window?.rootViewController = initialViewController
        //表示
        self.window?.makeKeyAndVisible()
    }
    
    
//saki
    
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        //アプリがactive時に通知を発生させた時にも呼ばれる
        if application.applicationState != .active{
            //バッジを０にする
            application.applicationIconBadgeNumber = 0
            //通知領域から削除する
            application.cancelLocalNotification(notification)
        }else{
            //active時に通知が来たときはそのままバッジを0に戻す
            if application.applicationIconBadgeNumber != 0{
                application.applicationIconBadgeNumber = 0
                application.cancelLocalNotification(notification)
            }
        }
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        //古い通知があれば削除する
        application.cancelAllLocalNotifications()
        //ローカル通知
        let notification = UILocalNotification()
        //ロック中にスライドで〜〜のところの文字
        notification.alertAction = "アプリを開く"
        //通知の本文
        notification.alertBody = "今日もキュントポイントがたまりました！！"
        //通知される時間（とりあえず10秒後に設定）
        notification.fireDate = NSDate(timeIntervalSinceNow:10) as Date
        //notification.fireDate = EveryDay.EveryDayPush()
        //通知音
        notification.soundName = UILocalNotificationDefaultSoundName
        //アインコンバッジの数字
        notification.applicationIconBadgeNumber = notification.applicationIconBadgeNumber + 1
        //通知を識別するID
        notification.userInfo = ["notifyID":"kyunto"]
        //通知をスケジューリング
        application.scheduleLocalNotification(notification)
        //毎日繰り返す
        notification.repeatInterval = .day
        
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("バックグラウンドからフォアグラウウンド")
        if application.applicationIconBadgeNumber != 0{
            application.applicationIconBadgeNumber = 0
            print("application\(application.applicationIconBadgeNumber)")
        }
        self.SelectedViewCOntroller()
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
