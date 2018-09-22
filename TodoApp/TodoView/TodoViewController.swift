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
	
	func newTodo(_ text: String, _ userId: String) -> Todo {
		let todo = Todo(text: text, userId: userId)
		
		return todo
	}
	
	@IBAction func addTodoBtn(_ sender: Any) {
		let textInput = todoInput.text!
		let user = Auth.auth().currentUser
		DB.collection("todos").addDocument(data: [
			"text": textInput,
			"user_id": user!.uid,
			"state": "to do"
		])
	}
	
	private func listenForTodos() {
		let user = Auth.auth().currentUser

		DB.collection("todos").whereField("user_id", isEqualTo: user!.uid).addSnapshotListener { querySnapshot, error in
			guard let documents = querySnapshot?.documents else {
				print("Error!! \(error!)")
				return
			}
			
			self.todos = documents.map { self.newTodo($0["text"] as! String, $0["user_id"] as! String) }
			self.todosTable.reloadData()
		}
	}
}

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
}
