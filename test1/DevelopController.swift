//
//  DevelopController.swift
//  test1
//
//  Created by Student on 2016/10/08.
//  Copyright © 2016年 Student. All rights reserved.
//

import UIKit

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
        // Name.text = KeyWord
    }
}