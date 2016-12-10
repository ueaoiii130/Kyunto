//
//  memoViewController.swift
//  KyuntoApp
//
//  Created by 高田早記 on 2016/12/03.
//  Copyright © 2016年 saki takada. All rights reserved.
//

import UIKit




class memoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var font:UIFont = UIFont(name:"HelveticaNeue-Bold",size:10)
    
    @IBOutlet var table: UITableView!
    var memoArray: [Dictionary<String,String>] = []
    var dateArray: [String] = []
    //var placeArray: [String] = []
    let saveMemoData: UserDefaults = UserDefaults.standard
    //let savePlaceData: UserDefaults = UserDefaults.standard
    let saveDateData: UserDefaults = UserDefaults.standard
    //let saveIndexData: UserDefaults = UserDefaults.standard
    
  // var dateIndex=0

    override func viewDidLoad() {
        super.viewDidLoad()
        //memotableView.xibとの連携のnib
        var nib = UINib(nibName: "memoTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "cell")
        
        //table.dateSource = self
                
        print("_______memoViewController________")

        //データを配列に入れる
       // memoArray = (saveMemoData.object(forKey: "MEMO") as! [Dictionary<String,String>]?)!
        //placeArray = (savePlaceData.object(forKey: "PLACE") as! [String]?)!
        //dateArray = (saveDateData.object(forKey: "DATE") as! [String]?)!
        //dateIndex = (saveIndexData.object(forKey: "INDEX") as! Int)
        
        //NSLog("2 memoArray: %@", String(describing: memoArray))
        //NSLog("2 dateArray: %@", String(describing: dateArray))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //配列memoArrayにデータを入れる
        if saveMemoData.array(forKey: "MEMO") != nil {
            memoArray = saveMemoData.array(forKey: "MEMO") as! [Dictionary<String,String>]
            //print(memoArray[0])
        }
        if saveDateData.array(forKey: "DATE") != nil {
            dateArray = saveDateData.array(forKey: "DATE") as! [String]
        }
      
        table.reloadData()
    }

    
    // MARK: - Table view data source
    
    //セルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableViewのセルの数指定なう")
        NSLog("memoArray.count:%d",memoArray.count)
        NSLog("dateArray.count:%d",dateArray.count)
        return memoArray.count
    }
    
    //セルの中身の表示の仕方を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("セルの中身を設定")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! memoTableViewCell
        let nowIndexPathDictionary = memoArray[indexPath.row]
        //Tag番号1で UILabelインスタンスを生成
        //_ = table.viewWithTag(1) as! UILabel // textLabel
        //cell上のtextLabelに、配列memoArrayの中身を表示
        //cell?.textLabel?.text = memoArray[indexPath.row]
        
        
        cell.memoLabel.text = nowIndexPathDictionary["memo"]
        cell.dateLabel.text = dateArray[dateArray.count-1]
        cell.placeLabel.text = "@"+nowIndexPathDictionary["place"]!
        return cell
    }
}
