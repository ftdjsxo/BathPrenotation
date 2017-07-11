//
//  MinutePickerController.swift
//  BatPrenotation
//
//  Created by Francesco Thiery on 05/07/17.
//  Copyright © 2017 Sbreng3. All rights reserved.
//

import UIKit

class MinutePickerController : PickerContainerController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
