//
//  addViewController.swift
//  KyuntoApp
//
//  Created by 高田早記 on 2016/12/03.
//  Copyright © 2016年 saki takada. All rights reserved.
//

import UIKit
import Social

class addViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var addMemoTextView: UITextView!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var addPlaceTextView: UITextView!
    
    let saveData: UserDefaults = UserDefaults.standard
    var point  = 0
    
    var memoArray: [Dictionary<String,String>] = []
    var dateArray: [String] = []
    /*var placeArray: [String] = []    //memoのUserdefaults*/
    let saveMemoData: UserDefaults = UserDefaults.standard
    //dateのuserdefaults
    let saveDateData: UserDefaults = UserDefaults.standard
    //let saveData: UserDefaults = UserDefaults.standard
   
    var indexDate = 0
    
    //Twitter投稿するかどうか
    var twitterOn: Bool = false
    @IBOutlet weak var twitterSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if saveMemoData.array(forKey: "MEMO") != nil{
            memoArray = saveMemoData.array(forKey: "MEMO") as![Dictionary<String,String>]
            
        }
        
        
        if saveDateData.array(forKey: "DATE") != nil {
            dateArray = saveDateData.array(forKey: "DATE") as! [String]
        }

                
        //point = saveData.object(forKey: "kyunKey") as! Int
        
        
        
        
        //日付
        let date = NSDate()
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        let strDate = format.string(from: date as Date)
        dateLabel.text = strDate
        
       
        dateArray.append(strDate)
        NSLog("date.count:%d",dateArray.count)
        
        saveDateData.set(dateArray, forKey: "DATE")
        saveDateData.synchronize()
        
        
 
        //デリゲート
        addMemoTextView.delegate = self
        addPlaceTextView.delegate = self
        
        
        
        
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: "commitButtonTapped")
        
        kbToolBar.items = [spacer, commitButton]
        
        
        addMemoTextView.inputAccessoryView = kbToolBar
        addPlaceTextView.inputAccessoryView = kbToolBar
        
        
        
    }
    
    func commitButtonTapped (){
        self.view.endEditing(true)
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveMemo() {
        print("PUSH save")
        let memoDictionary = ["memo": addMemoTextView.text!,"place": addPlaceTextView.text!]
        print(memoDictionary)
        
        //配列に保存
        //dateArray.append(strDate)
        memoArray.append(memoDictionary)
        NSLog("memoArray: %@", String(describing: memoArray))
        //UserDefaultsに保存
        saveMemoData.set(memoArray, forKey: "MEMO")
        //savePlaceData.set(placeArray, forKey: "PLACE")

        //この時点で一旦保存
        saveMemoData.synchronize()
       // savePlaceData.synchronize()
        
        print(saveMemoData.object(forKey: "MEMO"))
        print(saveDateData.object(forKey: "DATE"))
        
        /******Twitter投稿するかどうか****/
        if twitterOn {
            self.toTwitter()
            self.toSegue()
        }
        
        //memoViewControllerに遷移の3行
        print("画面遷移しマーーーーーーース")
        
        self.toSegue()
       /* let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "tomemoViewController") as! memoViewController
        self.present(nextView, animated: true, completion: nil)*/
    }

    
    //MARK: キーボードが出ている状態で、キーボード以外をタップしたらキーボードを閉じる
   func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //非表示にする。
        if(addMemoTextView.isFirstResponder){
            addMemoTextView.resignFirstResponder()
        }
        
    }
    
    /***** 改行ボタンを押した時の処理 *******/
    /*func textFieldShouldReturn(_ addMemoTextView: UITextView) -> Bool {
        // キーボードを隠す
        addMemoTextView.resignFirstResponder()
        NSLog("キーボード　隠す")
        return true
    }
    */
    /****** Twitterスイッチ *********/
    @IBAction func TwitterChanged(_ sender: UISwitch) {
        if twitterSwitch.isOn {
            twitterOn = true
        }
    }
    
    /****** Twitter投稿 *******/
    func toTwitter(){
        // Twitterダイアログを作る
        let cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        point = saveData.integer(forKey: "kyunKey")
        NSLog("point:%d",point)
        // 文字追加
        cv?.setInitialText("今日は"+String(point)+"キュン貯まりました！#キュント#girlsHackU")
        //cv?.setInitialText("今日のきゅんと："+memoArray[0,0])
        // 投稿ダイアログを表示する
        self.present(cv!, animated: true, completion: nil)
        
        //return true
        //self.toSegue()
    }
    
    /*****画面遷移*****/
    func toSegue(){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "tomemoViewController") as! memoViewController
        self.present(nextView, animated: true, completion: nil)
    }
    
}
