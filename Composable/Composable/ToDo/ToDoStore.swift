//
//  ToDoStore.swift
//  Composable
//
//  Created by Евгений Суханов on 23.10.2020.
//

import Foundation
import ComposableArchitecture

struct ToDo: Identifiable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool = false
}

enum ToDoAction {
    case toggleStatus
    case textFieldChanged(String)
}

struct ToDoEnviroment {}

let toDoReducer = Reducer<ToDo, ToDoAction, ToDoEnviroment> { state, action, env in
    switch action {
    case .toggleStatus:
        state.isCompleted.toggle()
    case .textFieldChanged(let newTitle):
        state.title = newTitle
    }
    return .none
}

typealias ToDoStore = Store<ToDo, ToDoAction>
extension ToDoStore {
    static var mock: ToDoStore {
        ToDoStore(
            initialState: ToDo(id: UUID(), title: "Learn Swift", isCompleted: true),
            reducer: toDoReducer,
            environment: ToDoEnviroment()
        )
    }
}
