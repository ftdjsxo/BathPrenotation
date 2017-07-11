//
//  PickerContainerController.swift
//  BatPrenotation
//
//  Created by Francesco Thiery on 05/07/17.
//  Copyright © 2017 Sbreng3. All rights reserved.
//

import UIKit

class PickerContainerController : UIViewController{
    
    var container : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view =
        container = createContainer()
        self.view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.right.left.equalTo(view).inset(20)
            make.center.equalTo(view)
        }
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    func addPickerToController(picker : UIView){
        container.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(container)
            make.height.equalTo(250)
        }
    }
    
    private func createContainer() -> UIView{
        let container = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        container.layer.cornerRadius = 15
        container.clipsToBounds = true
        container.snp.makeConstraints { (make) in
            make.height.equalTo(270)
        }
        
        let bar = createContainerBar()
        container.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(container)
        }
        
        return container
    }
    
    private func createContainerBar() -> UIView{
        let containerBar = UIView()
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Fine", for: .normal)
        saveButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        containerBar.addSubview(saveButton)
        containerBar.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(containerBar).inset(10)
            make.width.equalTo(70)
        }
        
        return containerBar
    }
    
    
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
}
