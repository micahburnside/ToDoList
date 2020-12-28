//
//  ViewController.swift
//  To Do List
//
//  Created by Micah Burnside on 12/27/20.

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        
    }
    
//Mark - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
// Ternary Operator
// value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
//MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        context.delete(itemArray[indexPath.row])
//
//        itemArray.remove(at: indexPath.row)
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
// CoreData function
        saveItems()
                
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
// MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default)
        { (action) in
            let newItem = Item(context: self.context)
            
// Creating a newItem from the Item.swift Data Model called Item()
            newItem.title = textField.text!
            
// Setting it's title property
            newItem.done = false
            
            self.itemArray.append(newItem)

            self.saveItems()
            
// Checks to see if itemArray was appended by printing all indexes inside "itemArray"
            print(self.itemArray)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
//extending the scope of alertTextField to this addButtonPressed
            textField = alertTextField
            
            print(alertTextField.text!)
            
            print("Now")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        }
    
//MARK - Model Manipulation Methods
    
    func saveItems() {
       
        
        do {
            try context.save() 
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }

    func loadItems() {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            
            itemArray = try context.fetch(request)
            
        } catch {
            
            print("Error fetching data from context \(error)")
            
        }
}



}
