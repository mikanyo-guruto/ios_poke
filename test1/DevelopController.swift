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
    
    var mId: Int!
    var KeyWord: String!
    var mega_id: Int16 = 9999
    var Mega1_id: Int16!
    var Mega2_id: Int16!
    var back_id: Int!
    var back_status: Bool!
    
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Hp: UILabel!
    @IBOutlet weak var Atk: UILabel!
    @IBOutlet weak var Def: UILabel!
    @IBOutlet weak var Mat: UILabel!
    @IBOutlet weak var Mde: UILabel!
    @IBOutlet weak var Spd: UILabel!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var Mega1: UIButton!
    @IBOutlet weak var Mega2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Mega1_id = 9999
        Mega2_id = 9999
        
        DevelopName()
    }
    
    /// ### 戻るボタンを押された時の処理
    @IBAction func BackBtn(sender: AnyObject) {
        if !back_status {
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            Mega1_id = 9999
            Mega2_id = 9999
            mega_id = 9999
            let predicate = NSPredicate(format: "id = %d", back_id)
            setMonsterData(predicate)
        }
    }
    
    /// ### 名前で検索
    private func DevelopName() {
        // predicateの設定
        let predicate = NSPredicate(format: "name = %@", KeyWord)
        
        // 設定したpredicateで検索しデータを画面に代入
        setMonsterData(predicate)
    }
    
    /// ### メガのボタンを押された時の処理
    @IBAction func MegaDevelop(sender: AnyObject) {
        // 押されたボタンによってmega_idをセットする
        if sender.tag! == 0 {
            mega_id = Mega1_id
        } else if sender.tag! == 1 {
            mega_id = Mega2_id
        } else {
            print("err")
        }
        
        let predicate = NSPredicate(format: "id = %d", mega_id)
        
        setMonsterData(predicate)
    }
    
    /// ### モンスターデータを画面にセットする関数
    /*
        引数:テーブルを検索する時のpredicateを設定
        成功:検索したモンスターを検索し、画面に描画する
    */
    private func setMonsterData(predicate: NSPredicate) {
        // appDelegateインスタンスの生成
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Monster")
        // 引数のpredicateを代入
        request.predicate = predicate
        
        do{
            let results = try managedObjectContext.executeFetchRequest(request) as! [Monster]
            
            if results.isEmpty {
                
            }
            
            for row in results {
                //let no = Int(row.no!)
                Name.text = row.name
                
                let no = Int(row.no!)
                let id = Int(row.id!)
                
                print("no;", no)
                print("mega_id:", mega_id)
                
                // 画像はidと同じ画像名の物を表示する為、stringで取得
                var img_name: String? = nil
                
                if mega_id != 9999 {
                    if (mId + 1) == mega_id{
                        img_name = String(row.no!) + "_1"
                    }else if (mId + 2) == Mega2_id {
                        img_name = String(row.no!) + "_2"
                    }else{
                        print("MegaImg input Error")
                        img_name = "no_image"
                    }
                }else{
                    img_name = String(row.no!)
                    mId = Int(row.id!)
                }
                
                // 画像の存在チェック
                if UIImage(named: img_name!) != nil{
                    Img.image = UIImage(named: img_name!)
                }else{
                    Img.image = UIImage(named: "no_image")
                }
                
                // --- タイプ処理 --- //
                // タイプをDBから取得
                /*
                var type: [String] = []
                type.append(row.t1!)
                if (row.t2 != nil) {
                    type.append(row.t2!)
                }
                
                let type_name = [
                    "ノーマル", "かくとう", "どく", "じめん", "ひこう",
                    "むし", "いわ", "ゴースト", "はがね", "ほのお",
                    "みず", "でんき", "くさ", "こおり", "エスパー",
                    "ドラゴン", "あく", "フェアリー"
                ];
                
                let type_week = [
                    // 普,  闘, 毒, 地,  飛, 虫, 岩, 霊,  鋼, 炎, 水, 電,  草, 氷,  超, 龍, 悪, 妖
                    /*普*/[1,2,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1],
                    /*闘*/[1,1,1,1,2,0.5,0.5,1,1,1,1,1,1,1,2,1,0.5,2],
                    /*毒*/[1,0.5,0.5,2,1,0.5,1,1,1,1,1,1,0.5,1,2,1,1,0.5],
                    /*地*/[1,1,0.5,1,1,1,0.5,1,1,1,2,0,2,2,1,1,1,1],
                    /*飛*/[1,0.5,1,0,1,0.5,2,1,1,1,1,2,0.5,2,1,1,1,1],
                    /*虫*/[1,0.5,1,0.5,2,1,2,1,1,2,1,1,0.5,1,1,1,1,1],
                    /*岩*/[0.5,2,0.5,2,0.5,1,1,1,2,0.5,2,1,2,1,1,1,1,1],
                    /*霊*/[0,0,0.5,1,1,0.5,1,2,1,1,1,1,1,1,1,1,2,1],
                    /*鋼*/[0.5,2,0,2,0.5,0.5,0.5,1,0.5,2,1,1,0.5,0.5,0.5,0.5,1,0.5],
                    /*炎*/[1,1,1,2,1,0.5,2,1,0.5,0.5,2,1,0.5,0.5,1,1,1,0.5],
                    /*水*/[1,1,1,1,1,1,1,1,0.5,0.5,0.5,2,2,0.5,1,1,1,1],
                    /*電*/[1,1,1,2,0.5,1,1,1,0.5,1,1,0.5,1,1,1,1,1,1],
                    /*草*/[1,1,2,0.5,2,2,1,1,1,2,0.5,0.5,0.5,2,1,1,1,1],
                    /*氷*/[1,2,1,1,1,1,2,1,2,2,1,1,1,1,0.5,1,2,1],
                    /*超*/[1,0.5,1,1,1,2,1,2,1,1,1,1,1,1,0.5,1,2,1],
                    /*龍*/[1,2,1,1,1,1,1,1,1,0.5,0.5,0.5,0.5,2,1,2,1,2],
                    /*悪*/[1,2,1,1,1,2,1,0.5,1,1,1,1,1,1,0,1,0.5,2],
                    /*妖*/[1,0.5,2,1,1,0.5,1,1,2,1,1,1,1,1,1,0,0.5,1]
                ];
                
                var merge_type_week:[Double] = []
                // type_nameにタイプと同じ名前があるか検索
                if type_name.indexOf(type[0]) != nil {
                    // type2のがあれば
                    if !type[1].isEmpty && type_name.indexOf(type[1]) != nil {
                        for i in 0 ..< type_week.count {
                            merge_type_week.append(
                                type_week[type_name.indexOf(type[0])!][i] *
                                    type_week[type_name.indexOf(type[1])!][i])
                        }
                        // なければタイプ1を代入
                    }else{
                        for i in 0 ..< type_week.count {
                            merge_type_week.append(type_week[type_name.indexOf(type[0])!][i])
                        }
                    }
                }
                */
                // --- END タイプ処理 --- //
                
                // --- メガの検索 --- //
                let predicate_mega = NSPredicate(format: "%K = %d", "no", no)
                request.predicate = predicate_mega
                
                let mega_results = try managedObjectContext.executeFetchRequest(request) as! [Monster]
                
                var mega1: [Any] = []
                var mega2: [Any] = []
                var j = 0
                if !mega_results.isEmpty {
                    for mega in mega_results {

                        // 検索したモンスターは除外(最初を除外)
                        switch j {
                        case 0:
                            break
                        case 1:
                            mega1.append(mega.id!)
                            mega1.append(mega.name!)
                            // 変数にメガ進化のidを保持する
                            Mega1_id = mega.id!.shortValue
                        case 2:
                            mega2.append(mega.id!)
                            mega2.append(mega.name!)
                            Mega2_id = mega.id!.shortValue
                        default:
                            break
                            
                        }
                        j = j+1
                    }
                }
                
                // --- END メガの検索 ---- ///
                
                // メガ進化ではなかったら
                if mega_id == 9999 {
                    back_id = id
                    back_status = false
                }else{
                    back_status = true
                }
                
                // ステータスの代入
                Hp.text = String(row.h!)
                Atk.text = String(row.a!)
                Def.text = String(row.b!)
                Mat.text = String(row.c!)
                Mde.text = String(row.d!)
                Spd.text = String(row.s!)
                Total.text = String(row.total!)
                
                if !mega1.isEmpty {
                    Mega1.setTitle(String(mega1[1]), forState: UIControlState.Normal)
                }else{
                    Mega1.hidden = true
                }
                
                if !mega2.isEmpty {
                    Mega2.setTitle(String(mega2[1]), forState: UIControlState.Normal)
                }else{
                    Mega2.hidden = true
                }
            }
        }catch {
            
        }
    }
}