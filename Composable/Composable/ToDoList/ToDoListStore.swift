//
//  ToDoStore.swift
//  Composable
//
//  Created by Евгений Суханов on 19.10.2020.
//

import Foundation
import ComposableArchitecture

struct ToDo: Identifiable, Equatable {
    let id: UUID
    let title: String
    var isCompleted: Bool = false
}

struct ToDoListState: Equatable {
    var todos: [ToDo] = []
}

enum ToDoListAction {
    case toggleStatus(Int)
}

struct ToDoListEnviroment {
}

let toDoListReducer = Reducer<ToDoListState, ToDoListAction, ToDoListEnviroment> { state, action, env in
    switch action {
    case .toggleStatus(let index):
        state.todos[index].isCompleted.toggle()
    }
    return .none
}
