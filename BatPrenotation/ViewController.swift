//
//  ViewController.swift
//  BatPrenotation
//
//  Created by Francesco Thiery on 26/06/17.
//  Copyright © 2017 Sbreng3. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItems()
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view = tableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if tableView.numberOfRows(inSection: section) == 0{
            return getFooterViewForAdd()
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func getFooterViewForAdd() -> UIView{
        let footer = UIView()
        let addButton = UIButton(type: .system)
        addButton.backgroundColor = .white
        addButton.setTitle("+ Aggiungi", for: .normal)
        addButton.layer.cornerRadius = 7
        addButton.addTarget(self, action: #selector(addBisogno), for: .touchUpInside)
        
        footer.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.edges.equalTo(footer).inset(20)
        }
        
        return footer
    }
    
    
    func addNavigationItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBisogno))
    }
    
    func addBisogno(){
        self.present(UINavigationController(rootViewController: AddPrenotationViewController()),
                     animated: true,
                     completion: nil)
    }
    
    
}

