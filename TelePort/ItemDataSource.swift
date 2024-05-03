import SwiftData


final class ItemDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ItemDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: GameData.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendItem(data: GameData) {
        modelContext.insert(data)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchItems() -> [GameData] {
        do {
            return try modelContext.fetch(FetchDescriptor<GameData>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem(_ data: GameData) {
        modelContext.delete(data)
    }
    
    func deleteAll() {
        do {
            try modelContext.delete(model: GameData.self)
        } catch {
            print("Failed to delete students.")
        }
    }
}
