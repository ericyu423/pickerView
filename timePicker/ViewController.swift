//
//  ViewController.swift
//  timePicker
//
//  Created by eric yu on 11/7/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    @IBOutlet var storyboardPicker: UIPickerView!
    //If you use this you will need to go to storyboard
    //click on autoresize inside the smaller square
    //to make sure it stretch out or else you get an gap
    
    @IBOutlet weak var textfield1: UITextField!
    
    @IBOutlet weak var textfield2: UITextField!
    
    let selectionTitle = ["default","1 Day","2 Days", "3 Days","4 Days", "5 Days","6 Days", "7 Days"]

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let item1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let item2 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(done))
        toolbar.setItems([item1,item2], animated: true)
        toolbar.tintColor = UIColor.white
        toolbar.barStyle = .blackTranslucent
        toolbar.sizeToFit()
        return toolbar
    }()
    @objc func done(){
        textfield1.endEditing(true)
        textfield2.endEditing(true)
    }
     let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //set delegates of picker and textfield
        picker.delegate = self
        picker.dataSource = self
        
        // delegate is set to load picker to the previous
        //selection
        textfield1.delegate = self
        textfield2.delegate = self
  
        //load current selection
        textfield1.text  = selectionTitle[UserDefaults.standard.integer(forKey: selectionTitleKeyActive)]
        
        textfield2.text = selectionTitle[UserDefaults.standard.integer(forKey: selectionTitleKeyBackground)]
    
        //textfield activates pickers
        textfield1.inputView = storyboardPicker
        textfield2.inputView = picker
       
        //add done button on top of pickers
        textfield1.inputAccessoryView = toolbar
        textfield2.inputAccessoryView = toolbar
        
      
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectionTitle.count
    }
   
    public func pickerView(_ pickerView:UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        
        
        return selectionTitle[row]
    }
    
    let selectionTitleKeyActive = "selectionTitleKeyActive"
    let selectionTitleKeyBackground = "selectionTitleKeyBackground"
    //this key should be store as a global variable

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  
        if textfield1.isEditing {
            textfield1.text = selectionTitle[row]
            UserDefaults.standard.setValue(row, forKey: selectionTitleKeyActive)
        }else {
            textfield2.text = selectionTitle[row]
            UserDefaults.standard.setValue(row, forKey: selectionTitleKeyBackground)
        }
        
        UserDefaults.standard.synchronize()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    storyboardPicker.selectRow(UserDefaults.standard.integer(forKey: selectionTitleKeyActive), inComponent: 0, animated: false)
        picker.selectRow(UserDefaults.standard.integer(forKey: selectionTitleKeyBackground), inComponent: 0, animated: false)
    }
    


}

