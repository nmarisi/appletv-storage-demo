//
//  ViewController.swift
//  appletv-storage
//
//  Created by Nahuel Marisi on 2015-10-24.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    let textKey = "textKey"
    
    @IBOutlet weak var messageLabel: UILabel!
    enum buttomTypes: Int {
        case defaults = 0
        case kvo
        case cloudKit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func savePressed(sender: UIButton) {
        
        switch sender.tag {
        case buttomTypes.defaults.rawValue:
            saveToDefaults()
        case buttomTypes.kvo.rawValue:
            saveToKVO()
        default:
            saveToDefaults()
        }
        
        messageLabel.text = "Saved"
    }
    
    
    @IBAction func loadPressed(sender: UIButton) {
        switch sender.tag {
        case buttomTypes.defaults.rawValue:
            loadFromDefaults()
        case buttomTypes.kvo.rawValue:
            loadFromKVO()
        default:
            loadFromDefaults()
        }
        
        messageLabel.text = "Loaded"
    }
    
    func saveToDefaults() {
        NSUserDefaults.standardUserDefaults().setObject(textField.text,
            forKey: textKey)
        NSUserDefaults.resetStandardUserDefaults()
    }
    
    func loadFromDefaults() {
        
        guard let loadedText = NSUserDefaults.standardUserDefaults().objectForKey(textKey) as? String else {
            return
        }
        
        textField.text = loadedText
    }
    
    func saveToKVO() {
        let store = NSUbiquitousKeyValueStore.defaultStore()
        store.setString(textField.text, forKey: textKey)

        // For this demo we'll force the synchronisation, however this is
        // seldom neccesary
        store.synchronize()
    }
    
    func loadFromKVO() {
        let store = NSUbiquitousKeyValueStore.defaultStore()
        textField.text = store.stringForKey(textKey)
    }
    
}

