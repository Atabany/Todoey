//
//  ViewController.swift
//  Todoey
//
//  Created by mohamed elatabany on 6/11/18.
//  Copyright © 2018 mohamed elatabany. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var itemArray = ["Learn some swift", "read my brand new books", "work on the projects"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen one the user clicks the add item button on our uialert
            if let text = textField.text, !text.isEmpty {
                self.itemArray.append(text)
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            // triggered when the textfield added to the alert
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            textField.addTarget(self, action: #selector(self.textChanged(sender:)), for: .editingChanged)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.actionToEnable = action
        action.isEnabled = false
        present(alert, animated: true)
    }
    
    weak var actionToEnable : UIAlertAction?
    @objc func textChanged(sender:UITextField) {
        self.actionToEnable?.isEnabled = (sender.text! != "")
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
    
    //MARK: - Tablview Delgate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         tableView.cellForRow(at: indexPath)?.accessoryType = (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ) ? .none : .checkmark
    }
}

