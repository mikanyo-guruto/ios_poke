//
//  DevelopController.swift
//  test1
//
//  Created by Student on 2016/10/08.
//  Copyright © 2016年 Student. All rights reserved.
//

import UIKit
import CoreData

class DevelopController: UIViewController {
    
    var KeyWord: String!
    
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
            ### DBのnameで検索する処理
        */
        // appDelegateインスタンスの生成
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        // リクエストの設定
        let request = NSFetchRequest(entityName: "Monster")
        let predicate = NSPredicate(format: "name = %@", KeyWord)
        request.predicate = predicate
        
        // リクエストの実行
        do {
            let results = try managedObjectContext.executeFetchRequest(request) as! [Monster]
            // 検索してヒットしたら
            if !results.isEmpty {
                // 画面にデータをセット
                for row in results {
                    Name.text = row.name
                    // 画像はidと同じ画像名の物を表示する為、一度idをstringにキャスト
                    let tmp: String = String(row.no)
                    Img.image = UIImage(named: tmp)
                    if tmp == "1" {
                        print("ok")
                    }else{
                        print(tmp)
                    }
                }
            }else{
                Name.text = "Not Found"
            }
        } catch let error as NSError{
            print("Could not fetch ¥(error), ¥(error.userInfo)")
        }
    }
}