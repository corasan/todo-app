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
	
	var todos: [Todo] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		
		todosTable.delegate = self
		todosTable.dataSource = self

		addTodo()
	}
	
	func addTodo() {
		let todo1 = Todo(text: "My first todo")
		let todo2 = Todo(text: "My second todo")
		
		todos = [todo1, todo2]
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
