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
    let store: ToDoListStore

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List {
                    ForEachStore(
                        store.scope(
                            state: \.todos,
                            action: ToDoListAction.todoAction
                        ),
                        content: ToDoView.init
                    )
                }
                .navigationTitle("Shopping list")
                .navigationBarItems(
                    trailing: Button("Add item") {
                        viewStore.send(.addToDo)
                    }
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(store: .mock)
    }
}
