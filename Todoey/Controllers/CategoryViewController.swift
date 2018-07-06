//
//  CategoryViewController.swift
//  Todoey
//
//  Created by mohamed elatabany on 6/13/18.
//  Copyright © 2018 mohamed elatabany. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    
    let realm = try! Realm() // -> new realm instances
    
    // MARK: - variables
    
//    var categories = [Category]()
    
    var categories: Results<Category>? //    var categories = [Category]()


    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add The Category", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // MARK:- Core Data
//            let category = Category(context: self.context)
//            category.name = textField.text!
//            self.categories.append(category)
//            self.saveCategories()
            // Save the data to core data


            // MARK:- Realm
            let cateogry = Category()
            cateogry.name = textField.text!
            self.save(category: cateogry)

        }
        alert.addAction(alertAction)
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create New Category"
            textField.addTarget(self, action: #selector(self.textChanged(sender:)), for: .editingChanged)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.actionToEnable = alertAction
        alertAction.isEnabled = false
        self.present(alert, animated: true)
    }
    
    weak var actionToEnable : UIAlertAction?
    @objc func textChanged(sender: UITextField) {
        self.actionToEnable?.isEnabled = (sender.text != "")
    }
    
    // MARK: - Data Manipulation Methods
//    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//        do {
//            self.categories = try context.fetch(request)
//        } catch {
//            print("finding error loading data from core data \(error)")
//        }
//        tableView.reloadData()
//    }
//
    
    
    func loadCategories() {
        self.categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
//    func saveCategories() {
//        do {
//            try context.save()
//        } catch {
//            print("error saving to core data \(error)")
//        }
//        tableView.reloadData()
//    }
//
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving to realm \(error)")
        }
        tableView.reloadData()
    }

    
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Add yet"
        return cell
    }
    
    // MARK: - TableView Delgate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = self.categories?[indexPath.row]
        }
    }
    
    
    // MARK: - TableView Manipulation Methods
    
    
    
    
    
}
