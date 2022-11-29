//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//class ViewController: UIViewController{
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

}


//MARK: - CoinManagerDelegate
extension ViewController : CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error:Error){
        print(error)
    }
}


//MARK: - UIPicker Datasource and Delegate
extension ViewController : UIPickerViewDataSource , UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print(coinManager.currencyArray.count)
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (coinManager.currencyArray.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(row)
//        print(coinManager.currencyArray[row])
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        print(selectedCurrency)
    }
}



/*
 E027AB8B-3C62-4D94-9355-D6CE140F25EB
 
 
 curl https://rest.coinapi.io/v1/exchangerate/BTC/USD \
   --request GET
   --header "X-CoinAPI-Key: E027AB8B-3C62-4D94-9355-D6CE140F25EB"
 
 curl https://rest.coinapi.io/v1/exchangerate/BTC/USD --request GET --header "X-CoinAPI-Key: E027AB8B-3C62-4D94-9355-D6CE140F25EB"
 
https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=E027AB8B-3C62-4D94-9355-D6CE140F25EB
 
 */
