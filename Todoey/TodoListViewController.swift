//
//  ViewController.swift
//  Todoey
//
//  Created by Nikita Petrenko on 1/1/18.
//  Copyright © 2018 Nikita Petrenko. All rights reserved.
//

import UIKit
class TodoListViewController: UITableViewController {
    
    var itemArray = [String]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            self.itemArray.append(textField.text!)
            
            // Save the updated itemArray to UserDefaults
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // reload the tableview after a new item was added
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (text) in
            text.placeholder = "Enter a new item"
            textField = text
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

