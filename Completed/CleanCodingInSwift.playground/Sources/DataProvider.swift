import CoreMotion

public protocol DataProvidingProtocol {
    func fetchData(completionHandler: @escaping CMPedometerHandler)
}

public class DataProvider: DataProvidingProtocol {
    private lazy var pedoMeter = CMPedometer()

    public func fetchData(completionHandler: @escaping CMPedometerHandler) {
        pedoMeter.queryPedometerData(from: Date().addingTimeInterval(-24*60*60), to: Date(), withHandler: completionHandler)
    }
}
