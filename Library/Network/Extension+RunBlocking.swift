import Foundation
import Libbox
import NetworkExtension

func runBlocking<T>(_ block: @escaping () async -> T) -> T {
    let semaphore = DispatchSemaphore(value: 0)
    let box = resultBox<T>()
    Task.detached {
        let value = await block()
        box.result0 = value
        semaphore.signal()
    }
    semaphore.wait()
    return box.result0
}

func runBlocking<T>(_ tBlock: @escaping () async throws -> T) throws -> T {
    let semaphore = DispatchSemaphore(value: 0)
    let box = resultBox<T>()
    Task.detached {
        do {
            let value = try await tBlock()
            box.result = .success(value)
        } catch {
            box.result = .failure(error)
        }
        semaphore.signal()
    }
    semaphore.wait()
    return try box.result.get()
}

private class resultBox<T> {
    var result: Result<T, Error>!
    var result0: T!
}
