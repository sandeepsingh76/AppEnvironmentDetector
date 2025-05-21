import Foundation
import UIKit

public enum AppEnvironment {
    case xcode
    case testFlight
    case appStoreRobot
    case appStoreRealUser
    case simulator

    public static func current() -> AppEnvironment {
#if targetEnvironment(simulator)
        return .simulator
#elseif DEBUG
        return .xcode
#else
        // Xcode Ad Hoc Install
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return .xcode
        }

        // TestFlight Install
        if let receiptURL = Bundle.main.appStoreReceiptURL,
           receiptURL.lastPathComponent == "sandboxReceipt" {
            return .testFlight
        }

        // App Store Install - Check if it's bot or real user
        if isLikelyRobot() {
            return .appStoreRobot
        } else {
            return .appStoreRealUser
        }
#endif
    }

    private static func isLikelyRobot() -> Bool {
        let env = ProcessInfo.processInfo.environment

        // Check for common CI or bot environment variables
        if env.keys.contains(where: { $0.lowercased().contains("ci") || $0.lowercased().contains("bot") }) {
            return true
        }

        // Check for low power mode (some automated test devices)
        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            return true
        }

        // Check device name clues
        let deviceName = UIDevice.current.name.lowercased()
        if deviceName.contains("xcode") || deviceName.contains("test") || deviceName.contains("automation") {
            return true
        }

        return false
    }
}
