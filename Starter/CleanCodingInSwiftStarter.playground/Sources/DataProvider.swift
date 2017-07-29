import Foundation
import CoreMotion

public protocol DataProvidingProtocol {
    func fetchData(completionHandler: @escaping CMPedometerHandler)
}

public class DataProvider: DataProvidingProtocol {
    private lazy var pedoMeter = CMPedometer()

    public func fetchData(completionHandler: @escaping CMPedometerHandler) {

    }
}
