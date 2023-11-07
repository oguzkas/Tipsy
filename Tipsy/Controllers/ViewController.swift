//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        //Klavyeyi kapatmak için
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        //Basılanın yeşil yanması için
        sender.isSelected = true
        //Basılan butonu öğrenmek için
        let buttonTitle = sender.currentTitle!
        // Buton sonundaki % ifadesini kaldırmak için
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        // Stringi doubleye çevirmek için
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        tip = buttonTitleAsANumber / 100
        
        
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        //Kullanıcının yazdığı metin alınır
        let bill = billTextField.text!
        
        if bill != ""{
            
            billTotal = Double(bill)!
            
            
            
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let result = billTotal * (1 + tip) / Double(numberOfPeople)
        let finalResult = String(format: "%.2f", result)
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
            
        }
    }
}

