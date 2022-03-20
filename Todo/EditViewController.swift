//
//  EditViewController.swift
//  Todo
//
//  Created by 五十嵐諒 on 2022/03/01.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    let realm = try! Realm()
    var editIndex = -1
    var todos:Results<Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todos = realm.objects(Todo.self)
        print(editIndex)
    }
    
    @IBAction func saveButton(){
        let todo = Todo()
        todo.title = titleTextField.text!
        todo.content = contentTextField.text!
        try! realm.write() {
            if editIndex == -1{
                realm.add(todo)
            }else{
                todos[editIndex].title = titleTextField.text!
                todos[editIndex].content = contentTextField.text!
            }
            let alert = UIAlertController(title: "保存", message: "保存に成功しました", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler: {
                (action: UIAlertAction!) -> Void in
                self.navigationController?.popViewController(animated: true)
            }))
                self.present(alert, animated: true, completion: nil)
        }
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
