//
//  TableViewController.swift
//  ToDoList
//
//  Created by Стас Чебыкин on 18.02.2020.
//  Copyright © 2020 Стас Чебыкин. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing( !tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alerController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        
        alerController.addTextField { (textField) in
            textField.placeholder = "New item name"
        }
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
            let newItem = alerController.textFields![0].text
            if newItem != ""{
                addItem(nameItem: newItem!)
                self.tableView.reloadData()
            }
        }
        
        alerController.addAction(alertAction1)
        alerController.addAction(alertAction2)
        present(alerController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = ToDoItems[indexPath.row]["Name"] as? String
        
        if (ToDoItems[indexPath.row]["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "check.png")
        } else{
            cell.imageView?.image = UIImage(named: "uncheck.png")
        }
        
        if tableView.isEditing{
            cell.imageView?.alpha = 0.4
            cell.textLabel?.alpha = 0.4
        } else {
            cell.imageView?.alpha = 1
            cell.textLabel?.alpha = 1
        }
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check.png")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "uncheck.png")
        }
        
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItemFrom(fromIndex: fromIndexPath.row, toIndex: to.row)
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
