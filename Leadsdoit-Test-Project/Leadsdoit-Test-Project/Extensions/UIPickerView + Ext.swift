//
//  UIPickerView + Ext.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 29/01/2024.
//

import UIKit

extension UIPickerView {
   static func showPickerView(title name: String) -> UIPickerView {
        let pickerView = UIPickerView()
       
        
        pickerView.backgroundColor = .white
        
        pickerView.frame = CGRect(x: 0, y: 546, width: 393, height: 306)
        pickerView.layer.cornerRadius = 50
        pickerView.layer.masksToBounds = true
        pickerView.layer.borderWidth = 1
        pickerView.layer.borderColor = UIColor.lightGray.cgColor
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "closeBlack"), for: .normal)
        closeButton.frame = CGRect(x: 20, y: 20, width: 44, height: 44)
        
        let acceptButton = UIButton()
        acceptButton.setImage(UIImage(named: "tick"), for: .normal)
        acceptButton.frame = CGRect(x: 329, y: 20, width: 44, height: 44)
        
        let titleForPicker = UILabel()
        titleForPicker.text = name
        titleForPicker.font = UIFont.title2
        titleForPicker.frame = CGRect(x: 156, y: 28, width: 81, height: 28)
        
        pickerView.addSubview(closeButton)
        pickerView.addSubview(acceptButton)
        pickerView.addSubview(titleForPicker)
     return pickerView
    }
}
