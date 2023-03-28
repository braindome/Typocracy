//
//  ViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-20.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var listValues = (10...100).map{$0}
    var listLength = 10

    @IBOutlet weak var playerNameLabel: UITextField!
    @IBOutlet weak var listLengthPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listLengthPickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameStart" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.gameLength = listLength
            destinationVC.playerName = playerNameLabel.text
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(listValues[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row) : \(listValues[row])")
        listLength = listValues[row]
    }
    
    


}

