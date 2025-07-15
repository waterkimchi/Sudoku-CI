//
//  ContentView.swift
//  Sudoku
//
//  Created by Hyunsu Lim on 7/14/25.
//

import SwiftUI
import SwiftData

/// 6개의 버튼이 필요하다.
/// - About - AboutView(NavigationStack type) 열기
/// - Help - HelpView(NavigationStack type) 열기
/// - Leader Board - LeaderBoardView(ActionSheet type) 열기
/// - Setting - SettingView(ActionSheet type) 열기
/// - Game- GameBoardView(NavigationStack type, 진입시 항상 LevelView ActionSheet type형 화면을 표시한다) 열기
/// - Solver - SolverView(NavigationStack type) 열기
///
/// - Parameters:
///     - x: The *x* component of the vector.
///     - y: The *y* component of the vector.
///     - z: The *z* component of the vector.
///
/// - Returns:
///     - a: The *a* component of the vector.
///
struct GameHomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    GameHomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
