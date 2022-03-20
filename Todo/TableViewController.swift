//
//  TableViewController.swift
//  Todo
//
//  Created by 五十嵐諒 on 2022/03/01.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    let realm = try! Realm()
    var todos: [Todo?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        todos = read()
        self.tableView.reloadData()
    }
    //セルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = todos[indexPath.row]?.title
        return cell!
    }
    
    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "navigationPushView") as! EditViewController
        nextVC.editIndex = indexPath.row
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            print("Deleteがタップされた")
            let index = indexPath.row
            try! self.realm.write(){
                self.realm.delete(self.realm.objects(Todo.self)[index])
            }
          completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    
    func read() -> [Todo?]{
        return Array(realm.objects(Todo.self))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
