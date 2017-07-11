//
//  AddPrenotationViewController.swift
//  BatPrenotation
//
//  Created by Francesco Thiery on 04/07/17.
//  Copyright © 2017 Sbreng3. All rights reserved.
//

import UIKit


class PrenotationBean : NSObject{
    var componentName : String
    var label : String
    var jsonName : String
    var jsonValue : String
    var component : UIView.Type
    var action : Selector?
    var placeholeder : String?
    
    init(componentName: String, label: String, jsonName: String, jsonValue: String, component: UIView.Type, action : Selector?, placeholeder : String?){
        self.componentName = componentName
        self.label = label
        self.jsonName = jsonName
        self.jsonValue = jsonValue
        self.component = component
        self.action = action
        self.placeholeder = placeholeder
    }
}

extension AddPrenotationViewController : DatePickerControllerDelegate{
    func didClosePiker(with date: Date?) {
        let bean = componentMap[AddPrenotationViewController.DATE_BEAN_KEY]
        bean?.jsonValue = (date?.timeIntervalSince1970.description)!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm"
        bean?.placeholeder = formatter.string(from: date!)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

class AddPrenotationViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    static let DATE_BEAN_KEY = "DATE"
    static let DURATION_BEAN_KEY = "DURATION"
    
    let formBeans : [PrenotationBean] = [PrenotationBean(componentName: DURATION_BEAN_KEY, label: "Durata", jsonName: "", jsonValue: "", component: UIButton.self, action : #selector(openMinutePicker(sender:)), placeholeder : nil),
                                         PrenotationBean(componentName: DATE_BEAN_KEY, label: "Data", jsonName: "", jsonValue: "", component: UIButton.self, action : #selector(openDatePicker(sender:)), placeholeder : nil)]
    
    var componentBeanBindMap = [UIView : PrenotationBean]()
    var componentMap = [String : PrenotationBean]()
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Aggiungi Prenotazione"
        addNavigationItems()
        tableView = UITableView(frame: .zero, style: .grouped)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return formBeans.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return getFirstSectionCell(by: indexPath)
        }
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let dismissButton = UIButton(type: .system)
        dismissButton.setTitleColor(.red, for: .normal)
        dismissButton.setTitle("Annulla", for: .normal)
        dismissButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        cell.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.edges.equalTo(cell)
        }
        
        return cell
    }
    
    
    func getFirstSectionCell(by indexPath : IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        let bean = formBeans[indexPath.row]
        cell.selectionStyle = .none
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = bean.label
        
        cell.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(cell)
            make.left.equalTo(cell).inset(15)
            make.width.equalTo(50)
        }
        
        let rightComponent = bean.component.init()
        cell.addSubview(rightComponent)
        rightComponent.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(cell)
            make.left.equalTo(label.snp.right).offset(15)
        }
        
        componentBeanBindMap[rightComponent] = bean
        componentMap[bean.componentName] = bean
        
        if let rightButton = rightComponent as? UIButton{
            rightButton.addTarget(self, action: bean.action!, for: .touchUpInside)
            rightButton.setTitle(bean.placeholeder, for: .normal)
            rightButton.backgroundColor = .red
        }
        
        
        return cell
    }
    
    func addNavigationItems(){
        let bitem = UIBarButtonItem(title: "Salva", style: .done, target: self, action: #selector(save))
        
        self.navigationItem.rightBarButtonItem = bitem
    }
    
    
    func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func save(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func openMinutePicker(sender : AnyObject){}
    
    func openDatePicker(sender : AnyObject){
        let picker = DatePickerController()
        picker.delegate = self
        picker.modalPresentationStyle = .overCurrentContext
        picker.modalTransitionStyle = .crossDissolve
        present(picker, animated: true, completion: nil)
    }
    
}
