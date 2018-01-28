//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nikita Petrenko on 1/27/18.
//  Copyright © 2018 Nikita Petrenko. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!

            self.categoryArray.append(newCategory)
            
            self.saveItems()
        }
            
            alert.addAction(action)
            alert.addTextField { (text) in
                text.placeholder = "Enter a new category"
                textField = text
            }
            present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    //MARK: - Data Manipulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        // reload the tableview after a new category was added
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request) // will return items and save it to the categoryArray to be displayed in the view
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
}
