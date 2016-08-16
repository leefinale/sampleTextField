//
//  ViewController.swift
//  textFieldSample
//
//  Created by Elex Lee on 8/15/16.
//  Copyright © 2016 Elex Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var jasonTextField: UITextField!
    var currentString = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        jasonTextField.keyboardType = .NumberPad
        jasonTextField.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
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
        return false
    }
    
    func formatCurrency(string: String)
    {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        let numberFromField = (NSString(string: currentString).doubleValue) / 100
        self.jasonTextField.text = formatter.stringFromNumber(numberFromField)
    }
}

