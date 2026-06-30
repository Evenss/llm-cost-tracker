import SwiftUI

struct RefreshGlyph: View {
    let isRefreshing: Bool
    var size: CGFloat = 13

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 45.0, paused: !isRefreshing)) { context in
            Image(systemName: "arrow.clockwise")
                .font(.system(size: size, weight: .semibold))
                .rotationEffect(.degrees(rotationAngle(for: context.date)))
                .accessibilityHidden(true)
        }
    }

    private func rotationAngle(for date: Date) -> Double {
        guard isRefreshing else { return 0 }

        let duration = 0.85
        let progress = date.timeIntervalSinceReferenceDate
            .truncatingRemainder(dividingBy: duration) / duration
        return progress * 360
    }
}
