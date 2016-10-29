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
    
    @IBOutlet weak var Name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let filePath = NSBundle.mainBundle().pathForResource("pokedb", ofType: "csv")
        do {
            var csvData: String = try String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
            csvData.enumerateLines {
                line, stop in
                
                print(line)
            }

        } catch {
            print(error)
        }
        */
        
        Name.text = KeyWord
        
        // appDelegateインスタンスの生成
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        // リクエストの設定
        let request = NSFetchRequest(entityName: "Monster")
        let predicate = NSPredicate(format: "name = %d", KeyWord)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        
        // リクエストの実行
        var datas: [Monster] = []
        do {
            let results = try managedObjectContext.executeFetchRequest(request) as! [Monster]
            datas = results
        } catch let error as NSError{
            print("Could not fetch ¥(error), ¥(error.userInfo)")
        }
        for row in datas {
            print(row.no)
            print(row.name)
        }
    }
}