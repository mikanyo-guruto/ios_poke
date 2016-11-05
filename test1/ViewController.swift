//
//  ViewController.swift
//  test1
//
//  Created by Student on 2016/10/08.
//  Copyright © 2016年 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var KeyWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let Develop = segue.destinationViewController as! DevelopController
        Develop.KeyWord = KeyWord.text
    }   
}

    