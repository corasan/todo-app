//
//  FirstViewController.swift
//  TodoApp
//
//  Created by Henry Paulino on 9/19/18.
//  Copyright © 2018 Henry Paulino. All rights reserved.
//

import UIKit
import Firebase

class TodosView: UIViewController {
	@IBOutlet weak var todosTable: UITableView!
	@IBOutlet weak var todoInput: TextInput!
	@IBOutlet weak var addTodoBtn: UIButton!
	
	var todos: [Todo] = []
	var DB: Firestore!

	override func viewDidLoad() {
		super.viewDidLoad()
		todosTable.keyboardDismissMode = .onDrag
		todosTable.tableFooterView = UIView()
		addTodoBtn.layer.cornerRadius = 6
		addTodoBtn.clipsToBounds = true
		
		let settings = FirestoreSettings()
		Firestore.firestore().settings = settings
		DB = Firestore.firestore()
		
		listenForTodos()
	}
	
	@IBAction func addTodoBtn(_ sender: Any) {
		let newDoc = DB.collection("todos").document()
		let textInput = todoInput.text!
		let user = Auth.auth().currentUser
		let id = newDoc.documentID
		let todo = Todo(textInput, user!.uid, id)
		
		addTodo(todo, newDoc)
	}
	
	private func addTodo(_ todo: Todo, _ newDoc: DocumentReference) {
		newDoc.setData([
			"text": todo.text,
			"user_id": todo.userId,
			"id": todo.id,
			"state": todo.state
		])
		todoInput.text = ""
	}
	
	private func listenForTodos() {
		let user = Auth.auth().currentUser

		DB.collection("todos").whereField("user_id", isEqualTo: user!.uid).addSnapshotListener { querySnapshot, error in
			guard let documents = querySnapshot?.documents else {
				print("Error!! \(error!)")
				return
			}
			
			// If there was no error, take each Todo in the DB and make it an instance of Todo class
			self.todos = documents.map {
				let text = $0["text"] as! String
				let userId = $0["user_id"] as! String
				let id = $0["id"] as! String

				return Todo(text, userId, id)
			}
			self.todosTable.reloadData()
		}
	}
	
	private func deleteTodo(_ id: String) {
		DB.collection("todos").document(id).delete() { err in
			if let err = err {
				print("Error removing document: \(err)")
			} else {
				self.todosTable.reloadData()
				print("Document successfully removed!")
			}
		}
	}
	
	private func doneTodo(_ id: String) {
		DB.collection("todos").document(id).updateData(["state": "done"])
	}
	
	private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
		let todo = todos[indexPath.row]
		let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
			self.deleteTodo(todo.id)
			completion(true)
		}
//		action.image = #imageLiteral(resourceName: "trash.png");#imageLiteral(resourceName: "trash@2x.png");#imageLiteral(resourceName: "trash@3x.png")
		action.backgroundColor = .red
		return action
	}
	
	private func doneAction(at indexPath: IndexPath) -> UIContextualAction {
		let todo = todos[indexPath.row]
		let action = UIContextualAction(style: .normal, title: "Done") { (action, view, completion) in
			self.doneTodo(todo.id)
			completion(true)
		}
		action.backgroundColor = UIColor(red:0.21, green:0.91, blue:0.29, alpha:1.0)
		return action
	}
}

// Table view code
extension TodosView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let todo = todos[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
		
		cell.setTodo(todo: todo)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let delete = deleteAction(at: indexPath)
		let done = doneAction(at: indexPath)
		
		return UISwipeActionsConfiguration(actions: [delete, done])
	}
}
