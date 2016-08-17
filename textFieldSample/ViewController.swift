//
//  ViewController.swift
//  textFieldSample
//
//  Created by Elex Lee on 8/15/16.
//  Copyright © 2016 Elex Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var costOfFoodTextField: UITextField!
    @IBOutlet weak var jasonPercentTextField: UITextField!
    @IBOutlet weak var jasonAmountTextField: UITextField!

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var fuckinTotal: UILabel!
    
    var costOfFood: Double = 20.00
    var currentString = ""
   
    var percentageAmount: Double?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        costOfFoodTextField.text = "$\(String(format: "%.2f", costOfFood))"
        
        costOfFoodTextField.keyboardType = .NumberPad
        costOfFoodTextField.delegate = self
        
        jasonAmountTextField.keyboardType = .NumberPad
        jasonAmountTextField.delegate = self
        
        jasonPercentTextField.keyboardType = .NumberPad
        jasonPercentTextField.addTarget(self, action: #selector(self.updateLabels), forControlEvents: .EditingChanged)
        jasonPercentTextField.delegate = self
    }
    
    func updateTotal()
    {
        if currentString != ""
        {
            let tip = Double(currentString)
            let total = costOfFood + (tip! / 100)
            fuckinTotal.text = "$\(String(format: "%.2f", total))"
        }
        else
        {
            fuckinTotal.text = "TOTAL"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        switch textField
        {
        case jasonPercentTextField:
            return shouldAllowInput(string)
        case jasonAmountTextField:
            changeStringToCurrency(string)
        default:
            return false
        }
        return false
    }
    
    func shouldAllowInput(string: String) -> Bool
    {
        var returnBool = false
        
        if jasonPercentTextField.text?.characters.count == 0 && string == "0"
        {
            return returnBool
        }
        
        switch string
        {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if jasonPercentTextField.text?.characters.count < 3
            {
                returnBool = true
            }
        default:
            returnBool = true
        }
        return returnBool
    }
    
    func updateLabels()
    {
        guard
            let text = jasonPercentTextField.text,
            let tipPercentage = Int(text)
        else
        {
            totalLabel.text = "$0.00"
            fuckinTotal.text = "TOTAL"
            return
        }
        let tip = Double(tipPercentage)
        let tipValue = costOfFood * (tip / 100.00)
        totalLabel.text = "$\(String(format: "%.2f", tipValue))"
        fuckinTotal.text = "$\(String(format: "%.2f", tipValue + costOfFood))"
    }
    
    func changeStringToCurrency(string: String)
    {
        switch string
        {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            currentString += string
            formatCurrency(currentString)
        default:
            if string.characters.count == 0 && currentString.characters.count != 0
            {
                currentString = String(currentString.characters.dropLast())
                formatCurrency(currentString)
            }
        }
        updateTotal()
    }
    
    func formatCurrency(string: String)
    {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        let numberFromField = (NSString(string: currentString).doubleValue) / 100
        self.jasonAmountTextField.text = formatter.stringFromNumber(numberFromField)
    }
}

