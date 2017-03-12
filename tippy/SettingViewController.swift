//
//  SettingViewController.swift
//  tippy
//
//  Created by Namrata Mehta on 3/9/17.
//  Copyright © 2017 Namrata Mehta. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    
    @IBOutlet weak var tipSettingControl: UISegmentedControl!
    @IBOutlet weak var setNoOfPersonText: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet var secondPAgeView: UIView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.text = ""
        // Do any additional setup after loading the view.
        // view.backgroundColor = UIColor.blue
        tipSettingControl.selectedSegmentIndex = defaults.integer(forKey: "selectedSegmentNumber")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateMaxPersonButton(_ sender: Any) {
        if(Float(setNoOfPersonText.text!)==0 || Float(setNoOfPersonText.text!)==1) {
            errorMessage.text = "The maximum value cannot be 0 or 1"
        } else {
            defaults.set(Float(setNoOfPersonText.text!), forKey: "maxNumberOfPerson")
            defaults.synchronize()
            errorMessage.text = "";
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onChange(_ sender: Any) {
        defaults.set(tipSettingControl.selectedSegmentIndex, forKey: "selectedSegmentNumber")
        defaults.synchronize()
    }
    

}
