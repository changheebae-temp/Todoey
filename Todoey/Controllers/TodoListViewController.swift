//
//  ViewController.swift
//  Todoey
//
//  Created by Changhee Bae on 04/04/2018.
//  Copyright © 2018 Changhee Bae. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  
  let defaults = UserDefaults.standard
  var itemArray = [Item]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newItem = Item()
    newItem.title = "Find Mike"
    itemArray.append(newItem)
    
    if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
      itemArray = items
    }
  }

  // MARK - Tableview Datasource Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    cell.textLabel?.text = itemArray[indexPath.row].title
    let item = itemArray[indexPath.row]
    cell.accessoryType = item.done ? .checkmark : .none
    return cell
  }
  
  // MARK - Tableview Delegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    tableView.reloadData()
    tableView.deselectRow(at: indexPath, animated: true)
  }

  // MARK - Add New Items
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      let newItem = Item()
      newItem.title = textField.text!
      self.itemArray.append(newItem)
      self.defaults.set(self.itemArray, forKey: "TodoListArray")
      self.tableView.reloadData()
    }
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
}
