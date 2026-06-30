import Foundation
import TokenCostBarCore

@MainActor
final class AppModel: ObservableObject {
    @Published private(set) var snapshot: DashboardSnapshot
    @Published private(set) var isRefreshing = false
    @Published private(set) var lastErrorMessage: String?

    private let coordinator: ScanCoordinator?
    private var refreshTimer: Timer?

    init(coordinator: ScanCoordinator) {
        self.coordinator = coordinator
        snapshot = (try? coordinator.currentSnapshot()) ?? .empty
    }

    init(errorMessage: String) {
        coordinator = nil
        snapshot = .empty
        lastErrorMessage = errorMessage
    }

    func startAutoRefresh() {
        refreshTimer?.invalidate()
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.refresh()
            }
        }
    }

    func refresh() {
        guard let coordinator else { return }
        guard !isRefreshing else { return }

        isRefreshing = true

        Task { [weak self, coordinator] in
            do {
                let summary = try await Task.detached(priority: .userInitiated) {
                    try coordinator.scanAll()
                }.value

                self?.snapshot = summary.snapshot
                self?.lastErrorMessage = nil
            } catch {
                self?.lastErrorMessage = error.localizedDescription
            }

            self?.isRefreshing = false
        }
    }
}
