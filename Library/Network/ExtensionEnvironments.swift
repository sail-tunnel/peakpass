import Foundation
import SwiftUI

public class ExtensionEnvironments: ObservableObject {
    @Published public var logClient = CommandClient(.log)
    @Published public var extensionProfileLoading = true
    @Published public var extensionProfile: ExtensionProfile?
    @Published public var emptyProfiles = false

    public let profileUpdate = ObjectWillChangePublisher()
    public let selectedProfileUpdate = ObjectWillChangePublisher()
    public let openSettings = ObjectWillChangePublisher()

    public init() {}

    deinit {
        logClient.disconnect()
    }

    public func postReload() {
        Task {
            await reload()
        }
    }

    @MainActor
    public func reload() async {
        if let newProfile = try? await ExtensionProfile.load() {
            if extensionProfile == nil || extensionProfile?.status == .invalid {
                newProfile.register()
                extensionProfile = newProfile
                extensionProfileLoading = false
            }
        } else {
            extensionProfile = nil
            extensionProfileLoading = false
        }
    }

    public func connectLog() {
        guard let profile = extensionProfile else {
            return
        }
        if profile.status.isConnected, !logClient.isConnected {
            logClient.connect()
        }
    }
}
