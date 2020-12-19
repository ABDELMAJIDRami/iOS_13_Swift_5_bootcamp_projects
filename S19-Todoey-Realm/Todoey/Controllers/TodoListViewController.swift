//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems: Results<Item>?    // array of Item object
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            // everything inside these {} will be triggered as soon as the selectedCategory is assigned with a value.
            loadItems() // And this is the perfect place to call loadItems() cz we are now certain that we've already got a value for selectedcategory -> so we aren't calling it before which might crash our app
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         loadItems()
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write{
                    //update row
                    item.done = !item.done
                    
                    // delete row
                    // realm.delete(item)
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)    // so when i click on the cell -> marked in grey -> then deselect it -> grey highlight disappears
    }

    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // var textField: UITextField will throw error inside the closure
        var textField = UITextField()
        
        // our alert popup
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // the button in the alert
        // let action = UIAlertAction(title: "Add Item", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)   // will be added to Item table with relationship to its parent category
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in   // alertTextField: reference to the created TextField
            alertTextField.placeholder = "Create new item"
            textField = alertTextField  // so we can reference it outsid this closure
        }
        
        alert.addAction(action) // very similar to JAVASCRIPT :)
        
        present(alert, animated: true, completion: nil) // docs: present viewController modally (above the current view controller).
    }
    
    // MARK: - Model Manupulation Methods
        
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true) // simialar to eloquent where we call relationshiproperty and then chain the query we want
        
        tableView.reloadData()
    }
}

// MARK: - Searchbar methods

//extension TodoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        // To query data in CoreData we need to use NSPredicate
//        // NSPredicate is a fondation class (represents a logical conditions) that specify how data should be fetched or filtered
//        // A query language
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)   // %@ will be replaced by args we passed: searchBar.text!   // [cd]: see pdf
//        // request.predicate = predicate   // add query format to our request
//
//        // sort data
//        // let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        // request.sortDescriptors accepts an array of [NSSortDescriptor]
//        // request.sortDescriptors = [sortDescriptor]
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
////        loadItems(with: request, predict: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {    // retrurn all items
//        if searchBar.text?.count == 0 {
////            loadItems()
//
//            DispatchQueue.main.async {  // resigning should happen on the main thread for it to work (see GoodNotes)
//                searchBar.resignFirstResponder()    // Notifies this object that it has been saked to relinquish its status as first responder in its window ---> should not be the thing that is currently selected -> hide the cursor & hide the keyboard
//            }
//        }
//    }
//}
