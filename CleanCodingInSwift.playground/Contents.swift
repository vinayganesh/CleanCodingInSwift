import XCTest
import CoreMotion

class StepCounterTests: XCTestCase {

    enum error: Error {
        case unknownError
    }

    class MockPedoMeterData: CMPedometerData {
        override var numberOfSteps: NSNumber {
            return 100
        }
        override var startDate: Date {
            return Date()
        }
    }

    class MockDataProvider: DataProvidingProtocol {
        func fetchData(completionHandler: @escaping CMPedometerHandler) {
            let mockPedometerData = MockPedoMeterData()
            completionHandler(mockPedometerData, nil)
        }
    }

    class MockDataProviderWithError: DataProvidingProtocol {
        func fetchData(completionHandler: @escaping CMPedometerHandler) {
            let mockPedometerData = MockPedoMeterData()
            completionHandler(mockPedometerData, error.unknownError)
        }
    }

    func testActivityWithNoActivity() {
        let stepCounter = StepCounter()
        let activities = stepCounter.allActivities
        XCTAssertEqual(activities.count, 0)
    }

    func testTotalStepsWithNoActivity() {
        let stepCounter = StepCounter()
        let steps = stepCounter.totalSteps
        XCTAssertEqual(steps, 0)
    }

    func testAllDatesWithNoActivity() {
        let stepCounter = StepCounter()
        let activeDates = stepCounter.allDates
        XCTAssertEqual(activeDates.count, 0)
    }

    func testTotalStepsWithSomeSteps() {
        let stepCounter = StepCounter()
        let activity = Activity(steps: 10, date: Date())
        stepCounter.setActivity(activity)
        let steps = stepCounter.totalSteps
        XCTAssertEqual(steps, 10)
    }

    func testAllDatesWithSomeActiveDates() {
        let stepCounter = StepCounter()
        let activity1 = Activity(steps: 10, date: Date())
        let activity2 = Activity(steps: 10, date: Date().addingTimeInterval(-24*60*60))
        stepCounter.setActivity(activity1)
        stepCounter.setActivity(activity2)
        let activeDates = stepCounter.allDates
        XCTAssertEqual(activeDates.count, 2)
    }

    func testFetchStepsData() {
        let mockDataProvider = MockDataProvider()
        let stepCounter = StepCounter(dataProvider: mockDataProvider)
        stepCounter.fetchStepsData()
        let steps = stepCounter.totalSteps
        XCTAssertEqual(steps, 100)
    }

    func testFetchStepsDataWithError() {
        let mockDataProvider = MockDataProviderWithError()
        let stepCounter = StepCounter(dataProvider: mockDataProvider)
        stepCounter.fetchStepsData()
        let steps = stepCounter.totalSteps
        XCTAssertEqual(steps, 0)
    }
}

StepCounterTests.defaultTestSuite().run()

