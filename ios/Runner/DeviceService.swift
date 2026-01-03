import Foundation
import UIKit
import flutter_native_bridge

class BuildService: NSObject {
    @objc func getBuildType() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "BUILD_ENV") as! String
    }
}