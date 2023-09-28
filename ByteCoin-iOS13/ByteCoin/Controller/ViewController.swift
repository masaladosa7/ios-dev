//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    var selectedCurrency : String = ""
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}


// MARK: - UIPickerViewDataSource


extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
}



// MARK: - UIPickerViewDelegate


extension ViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
}


// MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, rate: Double?) {
        DispatchQueue.main.async {
            
            self.bitcoinLabel.text = String(format: "%.2f",rate!)
            self.currencyLabel.text = self.selectedCurrency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//API Key: FA64F25A-600B-40B6-90FF-38F20BA247DE
