//
//  ToDoListView.swift
//  ComposableArchitecture
//
//  Created by Евгений Суханов on 19.10.2020.
//

import SwiftUI
import ComposableArchitecture
import CasePaths

struct ToDoListView: View {
    let store: Store<ToDoListState, ToDoListAction>

    var body: some View {
        NavigationView {
            List {
                ForEachStore(
                    store.scope(
                        state: \.todos,
                        action: ToDoListAction.todoAction
                    ),
                    content: ToDoView.init
                )
            }.navigationTitle("My todo")
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(store: .mock)
    }
}
