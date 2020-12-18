//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()    // array of Item object
    
    var selectedCategory: Category? {
        didSet {
            // everything inside these {} will be triggered as soon as the selectedCategory is assigned with a value.
            loadItems() // And this is the perfect place to call loadItems() cz we are now certain that we've already got a value for selectedcategory -> so we aren't calling it before which might crash our app
        }
    }
    
    // inspect each element to see its definition/purpose
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(dataFilePath)
        
         loadItems()    // this seams to happen sync cz angela removed tableView.reloadData(). Heye mn abl sheylta bas ana ma knt mntebeh
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        // cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        // Remove Data
        // the order is very imortant cz if we removed it first from itemArray -> Item no longer exists -> indexPath will refer to another Item(CoreData will delete another Item!!) or an indexPath outside the range(Fatal Error)
        // context.delete(itemArray[indexPath.row])    // eloquent :), we refered the object to be deleted
        // itemArray.remove(at: indexPath.row)
        // saveItems() // otherwise, context.delete won't take affect!
        
        // 1- First way for updating Data with CoreData
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // 2- second way for updating Data
        // itemArray[indexPath.row].setValue(!itemArray[indexPath.row].done, forKey: "done")
        
        /* if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark -------->>> // ref to cell at the specific index (like in JS: getElementById or by ... and set its innerText or innerHtml orany prop)
        }*/
        
        saveItems()
        
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
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory  // relationship
            self.itemArray.append(newItem)
    
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in   // alertTextField: reference to the created TextField
            alertTextField.placeholder = "Create new item"
            textField = alertTextField  // so we can reference it outsid this closure
        }
        
        alert.addAction(action) // very similar to JAVASCRIPT :)
        
        present(alert, animated: true, completion: nil) // docs: present viewController modally (above the current view controller).
    }
    
    // MARK: - Model Manupulation Methods
    
    func saveItems() {
        do {
            // commit our context to permenant storage inside our persistance container (similarly to what's done inside AppDelegate.appwillterminate
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData() // reload rows and sections of the table view
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predict: NSPredicate? = nil) {  // default value
        // NSFetchRequest is a generic class that is going to fetch results in the form of Item
        // Xcode is smart to know what is the datatype based on the value but in this case we should identify its type. I belive bcz its generic(the first line).

        let categoryPredict = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        /* If we do request.predict = predict ;; the assigned predict defined inside searchBarSearchButtonClicked ""request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)"" will be overritten!
         ---> solution is to combine predicates using NSCompoundPredicate initialized using sub-predicates
         */
        
        if let additionalPredicat = predict {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredict, additionalPredicat])
        } else {
            request.predicate = categoryPredict
        }
                
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching fata from context, \(error)")
        }
        
        tableView.reloadData()
    }
}

// MARK: - Searchbar methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        // To query data in CoreData we need to use NSPredicate
        // NSPredicate is a fondation class (represents a logical conditions) that specify how data should be fetched or filtered
        // A query language
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)   // %@ will be replaced by args we passed: searchBar.text!   // [cd]: see pdf
        // request.predicate = predicate   // add query format to our request
        
        // sort data
        // let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        // request.sortDescriptors accepts an array of [NSSortDescriptor]
        // request.sortDescriptors = [sortDescriptor]
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predict: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {    // retrurn all items
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {  // resigning should happen on the main thread for it to work (see GoodNotes)
                searchBar.resignFirstResponder()    // Notifies this object that it has been saked to relinquish its status as first responder in its window ---> should not be the thing that is currently selected -> hide the cursor & hide the keyboard
            }
        }
    }
}
