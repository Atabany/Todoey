//
//  ViewController.swift
//  Todoey
//
//  Created by mohamed elatabany on 6/11/18.
//  Copyright © 2018 mohamed elatabany. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {

    
    let itemArray = ["Learn some swift", "read my brand new books", "work on the projects"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Tablview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
//    var dict: [Int: Bool] = [:]
    
    //MARK: - Tablview Delgate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if dict[indexPath.row] == nil {
//            dict[indexPath.row] = true
//        } else {
//            dict[indexPath.row] = !dict[indexPath.row]!
//        }
//
//        if dict[indexPath.row] == true {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//
        
         tableView.cellForRow(at: indexPath)?.accessoryType = (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ) ? .none : .checkmark
        
    }
    

}

