//
//  Todo.swift
//  TodoApp
//
//  Created by Henry Paulino on 9/19/18.
//  Copyright © 2018 Henry Paulino. All rights reserved.
//

import Foundation

class Todo {
	var text: String
	var state: String
	var userId: String
	var id: String
	
	init(_ text: String, _ userId: String, _ id: String) {
		self.text = text
		self.userId = userId
		self.state = "to do"
		self.id = id
	}
}
