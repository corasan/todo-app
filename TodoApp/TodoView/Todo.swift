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
	var done: Bool
	
	init(text: String, done: Bool = false) {
		self.text = text
		self.done = done
	}
}
