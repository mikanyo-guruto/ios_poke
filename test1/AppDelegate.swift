//
//  AppDelegate.swift
//  test1
//
//  Created by Student on 2016/10/08.
//  Copyright © 2016年 Student. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 初回起動処理
        let defaults = NSUserDefaults.standardUserDefaults()
        var dic = ["firstLaunch": true]
        
        // 初回起動の場合、csvからDBを作成する
        if defaults.boolForKey("firstLaunch") {
            
            // csvを入れ込む配列を用意
            var result: [[String]] = []
            // csvファイルを指定
            if let csvPath = NSBundle.mainBundle().pathForResource("pokedb", ofType: "csv") {
                // csvの文字を指定
                let csvString = try! NSString(contentsOfFile: csvPath, encoding: NSUTF8StringEncoding) as String
                // 一行ずつカンマ区切りで読み込む
                csvString.enumerateLines { (line, stop) -> () in
                    result.append(line.componentsSeparatedByString(","))
                }
            }
            // カラムを削除
            result.removeAtIndex(0)
            
            // カラムを変数で宣言
            var id: Int = 0
            var no: Int = 0
            var name: String = "null"
            var t1: String = "null"
            var t2: String = "null"
            var h: Int = 0
            var a: Int = 0
            var b: Int = 0
            var c: Int = 0
            var d: Int = 0
            var s: Int = 0
            var total: Int = 0
            var sp1: String = "null"
            var sp2: String = "null"
            var ha: String = "null"
            var ad1: Int = 0
            var ad2: Int = 0
            var ad3: Int = 0
            
            // appDelegateインスタンスを生成
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            // CoreDateでDBへ保存
            var i: Int = 0
            result.forEach { row in
                id = i
                no = Int(row[0]) ?? 9999
                name = row[1] ?? ""
                t1 = row[2] ?? ""
                t2 = row[3] ?? ""
                h = Int(row[4]) ?? 9999
                a = Int(row[5]) ?? 9999
                b = Int(row[6]) ?? 9999
                c = Int(row[7]) ?? 9999
                d = Int(row[8]) ?? 9999
                s = Int(row[9]) ?? 9999
                total = Int(row[10]) ?? 9999
                sp1 = row[11] ?? ""
                sp2 = row[12] ?? ""
                ha = row[13] ?? ""
                ad1 = Int(row[14]) ?? 9999
                ad2 = Int(row[15]) ?? 9999
                ad3 = Int(row[16]) ?? 9999
                
                // テーブルの指定
                let monster = NSEntityDescription.insertNewObjectForEntityForName("Monster", inManagedObjectContext: appDelegate.managedObjectContext) as! Monster
                // カラムへ入れ込む
                monster.id = id
                monster.no = no
                monster.name = name
                monster.t1 = t1
                monster.t2 = t2
                monster.h = h
                monster.a = a
                monster.b = b
                monster.c = c
                monster.d = d
                monster.s = s
                monster.total = total
                monster.sp1 = sp1
                monster.sp2 = sp2
                monster.ha = ha
                monster.ad1 = ad1
                monster.ad2 = ad2
                monster.ad3 = ad3
                
                // コミット
                appDelegate.saveContext()
                i = i + 1
            }
            
            // 初回起動処理が終わったら、フラグを立てる
            defaults.setBool(false, forKey: "firstLaunch")
            
            print("firstLaunch")
        }
        // 検索
        /*
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "Monster")
        do {
            let monsters = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Monster]
            for monster in monsters {
                print("\(monster.id) \(monster.no) \(monster.name)")
            }
        } catch let error as NSError {
            print(error)
        }
*/
        print("Run")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "-55.core" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Develop", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

