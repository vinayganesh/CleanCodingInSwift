import Foundation

public class StepCounter {
    private var steps: Int
    private var dates: [Date]
    private var activities: [Activity]
    private let dataProvider: DataProvidingProtocol

    public init(dataProvider: DataProvidingProtocol = DataProvider()) {
        activities = [Activity]()
        steps = 0
        dates = [Date]()
        self.dataProvider = dataProvider
    }

    private func addSteps(_ s: Int) {
        steps += s
    }

    private func addDate(_ d: Date) {
        dates.append(d)
    }

    public var totalSteps: Int {
        return steps
    }

    public var allDates: [Date] {
        return dates
    }

    public var allActivities: [Activity] {
        return activities
    }

    public func setActivity(_ activity: Activity) {
        activities.append(activity)
        addSteps(activity.steps)
        addDate(activity.date)
    }

    public func fetchStepsData() {
        dataProvider.fetchData { (data, error) in
            guard error == nil else { return }
            guard let stepsData = data else { return }
            let activity = Activity(steps: stepsData.numberOfSteps.intValue, date: stepsData.startDate)
            self.setActivity(activity)
        }
    }
}
