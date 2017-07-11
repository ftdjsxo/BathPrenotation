//
//  DatePickerController.swift
//  BatPrenotation
//
//  Created by Francesco Thiery on 05/07/17.
//  Copyright © 2017 Sbreng3. All rights reserved.
//

import UIKit

protocol DatePickerControllerDelegate {
    func didClosePiker(with date : Date?)
}

class DatePickerController : PickerContainerController{
    
    var delegate : DatePickerControllerDelegate?
    
    var date : Date?
    var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatePicker()
    }
    
    func openDatePicker(){
        datePicker =  UIDatePicker()
        datePicker?.setDate(Date(), animated: true)
        addPickerToController(picker: datePicker!)
    }
 
    override func close(){
        print("Selected: " , datePicker?.date as Any)
        delegate?.didClosePiker(with: datePicker?.date)
        dismiss(animated: true, completion: nil)
    }
}
