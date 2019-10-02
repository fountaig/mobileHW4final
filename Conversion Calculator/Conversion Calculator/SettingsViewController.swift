//
//  ViewSelectorViewController.swift
//  Conversion Calculator
//
//  Created by Xcode User on 9/23/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit)
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit)
}

class SettingsViewController: UIViewController {

    var pickerData:[String] = [String]()
    var selection:String = "Steak"
    var mode : CalculatorMode?
    var delegate: SettingsViewControllerDelegate?
    @IBOutlet weak var fromUnitButton: UIButton!
    @IBOutlet weak var toUnitButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    var fromLenUnit: LengthUnit?
    var toLenUnit: LengthUnit?
    var fromVolUnit: VolumeUnit?
    var toVolUnit: VolumeUnit?
    var fromIsPressed = false
    var toIsPressed = false
    
    @IBAction func saveButton(_ sender:UIBarButtonItem){
        if mode == .Length {
            if let d = self.delegate{
                            d.settingsChanged(fromUnits: fromLenUnit!, toUnits: toLenUnit!)
            }
        }
        if mode == .Volume {
            if let d = self.delegate{
                d.settingsChanged(fromUnits: fromVolUnit!, toUnits: toVolUnit!)
            }
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func superCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func fromUnitsSelected(_ sender: UIButton) {
        self.picker.isHidden = false
        fromIsPressed = true
    }
    @IBAction func toUnitsSelected(_ sender: UIButton) {
        self.picker.isHidden = false
        toIsPressed = true
    }
    
    @objc func dismissPicker(){
        if mode == .Length {
            if fromIsPressed {
                fromLenUnit = LengthUnit(rawValue: self.selection)
                fromUnitButton.setTitle(fromLenUnit!.rawValue,for: .normal)
                fromIsPressed = false
            }
            else {
                toLenUnit = LengthUnit(rawValue: self.selection)
                toUnitButton.setTitle(toLenUnit!.rawValue,for: .normal)
                toIsPressed = false
            }
        }
        if mode == .Volume {
            if fromIsPressed {
                fromVolUnit = VolumeUnit(rawValue: self.selection)
                fromUnitButton.setTitle(fromVolUnit!.rawValue,for: .normal)
                fromIsPressed = false
            }
            else {
                toVolUnit = VolumeUnit(rawValue: self.selection)
                toUnitButton.setTitle(toVolUnit!.rawValue,for: .normal)
                toIsPressed = false
            }
        }
         self.picker.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(mode == .Length){
        self.pickerData = ["Meters", "Yards", "Miles"]
             fromUnitButton.setTitle(fromLenUnit!.rawValue,for: .normal)
             toUnitButton.setTitle(toLenUnit!.rawValue,for: .normal)
        }
        else{
            self.pickerData = ["Liters", "Gallons", "Quarts"]
             fromUnitButton.setTitle(fromVolUnit!.rawValue,for: .normal)
            toUnitButton.setTitle(toVolUnit!.rawValue,for: .normal)
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.isHidden = true
        let detectTouch = UITapGestureRecognizer(target: self, action:#selector(self.dismissPicker))
        self.view.addGestureRecognizer(detectTouch)
        // Do any additional setup after loading the view.
    }
}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selection = self.pickerData[row]
    }
}
