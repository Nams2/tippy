//
//  ViewController.swift
//  tippy
//
//  Created by Namrata Mehta on 10/7/17.
//  Copyright © 2017 Namrata Mehta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var sliderValueSelectedSlider: UISlider!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet var firstPageView: UIView!
    
    let tipPercentage = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        
        persistBillValue()
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let noOfPerson = Int(sliderValueSelectedSlider.value)
        let totalPerPerson = (total/Double(noOfPerson))
        tipLabel.text = String(format: getCurrencySymbol()+"%.2f", tip)
        totalLabel.text = String(format: getCurrencySymbol()+"%.2f", total)
        if(noOfPerson != 0) {
            totalPerPersonLabel.text = String(format: getCurrencySymbol()+"%.2f", totalPerPerson)
        }
    }
    
    @IBAction func noOfPersonChanges(_ sender: Any) {
        let currentValue = Int(sliderValueSelectedSlider.value)
        personLabel.text = "\(currentValue)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaultVal = 0
        let defaults = UserDefaults.standard
        defaultVal = defaults.integer(forKey: "selectedSegmentNumber")
        tipControl.selectedSegmentIndex = defaultVal
        
        billField.placeholder = getCurrencySymbol()
        billField.text = ""
        
        let refDate = UserDefaults.standard.object(forKey: "defaults.billDate") as? NSDate
        if (refDate != nil && integer_t(NSDate().timeIntervalSince(refDate! as Date)) < 600) {
            billField.text = UserDefaults.standard.object(forKey: "defaults.billValue") as? String
        }
        
        self.calculateTip(self)
        sliderValueSelectedSlider.maximumValue = defaults.float(forKey: "maxNumberOfPerson")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
        UIView.animate(withDuration: 0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.firstPageView.alpha = 1
        })
        billField.text=""
        tipLabel.text=getCurrencySymbol()+"0.00"
        totalLabel.text=getCurrencySymbol()+"0.00"
        totalPerPersonLabel.text=getCurrencySymbol()+"0.00"
        tipControl.alpha=2
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }
    
    func getCurrencySymbol() -> String {
        return NSLocale.current.currencySymbol!
    }
    
    func persistBillValue() {
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "defaults.billValue")
        defaults.set(NSDate(), forKey: "defaults.billDate")
        defaults.synchronize()
    }
    
    
}

