import Foundation

public struct Activity {
    let steps: Int
    let date: Date

    public init(steps: Int, date: Date) {
        self.steps = steps
        self.date = date
    }
}
