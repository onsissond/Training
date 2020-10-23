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
    case todoAction(Int, ToDoAction)
}

struct ToDoListEnviroment {
}

let toDoListReducer: Reducer<ToDoListState, ToDoListAction, ToDoListEnviroment> = toDoReducer.forEach(
    state: \ToDoListState.todos,
    action: /ToDoListAction.todoAction,
    environment: { _ in ToDoEnviroment() }
)

// MARK: - TODO
enum ToDoAction {
    case toggleStatus
}

struct ToDoEnviroment {
}

let toDoReducer = Reducer<ToDo, ToDoAction, ToDoEnviroment> { state, action, env in
    switch action {
    case .toggleStatus:
        state.isCompleted.toggle()
    }
    return .none
}
