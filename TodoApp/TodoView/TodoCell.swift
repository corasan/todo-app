//
//  TodoCell.swift
//  TodoApp
//
//  Created by Henry Paulino on 9/19/18.
//  Copyright © 2018 Henry Paulino. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
	@IBOutlet weak var todoText: UILabel!
	
	func setTodo(todo: Todo) {
		todoText.text = todo.text
	}
}
