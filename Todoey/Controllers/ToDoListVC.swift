//
//  ViewController.swift
//  Todoey
//
//  Created by mohamed elatabany on 6/11/18.
//  Copyright © 2018 mohamed elatabany. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var itemArray : [Item] = [Item]()
    //    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    func loadItems() {
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
                self.itemArray = try decoder.decode([Item].self, from: data)
            }
        } catch {
            print("finding error retrieving data \(error)")
        }
    }
    
    // we can't use userdefaults with custom types we 've created
    //    func getItemArray() {
    //        if let items = defaults.value(forKey: "itemArray") as? [Item] {
    //            self.itemArray = items
    //        }
    //    }
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen one the user clicks the add item button on our uialert
            if let text = textField.text, !text.isEmpty {
                let newItem = Item()
                newItem.title = text
                self.itemArray.append(newItem)
                //                self.defaults.set(self.itemArray, forKey: "itemArray")
                self.saveItems()
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
    
    // MARK: - Model Manupulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("finding error while encoding")
        }
    }
    
    
    
    //MARK: - Tablview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = (item.done) ? .checkmark : .none
        return cell
    }
    
    //MARK: - Tablview Delgate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.reloadData()
    }
}

