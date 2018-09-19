//
//  FirstViewController.swift
//  TodoApp
//
//  Created by Henry Paulino on 9/19/18.
//  Copyright © 2018 Henry Paulino. All rights reserved.
//

import UIKit

class TodosView: UIViewController {
	@IBOutlet weak var todosTable: UITableView!
	@IBOutlet weak var todoInput: TextInput!
	
	var todos: [Todo] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		todosTable.delegate = self
		todosTable.dataSource = self
		todosTable.keyboardDismissMode = .onDrag
	}
	
	func addTodo(text: String) {
		let todo = Todo(text: text)
		
		todos.append(todo)
	}
	
	@IBAction func addTodoBtn(_ sender: Any) {
		let text: String = todoInput.text!
		addTodo(text: text)
		todosTable.reloadData()
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
