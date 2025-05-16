import Foundation

public enum AppEnvironment {
    case xcode
    case testFlight
    case appStore

    public static func current() -> AppEnvironment {
#if DEBUG
        return .xcode
#else
        // Check for provisioning profile
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return .xcode
        }

        // Check for TestFlight receipt
        if let receiptURL = Bundle.main.appStoreReceiptURL,
           receiptURL.lastPathComponent == "sandboxReceipt" {
            return .testFlight
        }

        return .appStore
#endif
    }
}
