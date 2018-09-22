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
	var state: Bool
	var userId: String
	
	init(text: String, userId: String, state: Bool = false) {
		self.text = text
		self.userId = userId
		self.state = state
	}
}
