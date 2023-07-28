import Foundation

// The recommendation is use an actor instead this template

class MySingleton {
    static let shared = MySingleton()

    private init() {}

    /// Attributes: .concurrent: allow read access while ensuring exclusive write access.
    private let lockQueue = DispatchQueue(label: "com.any.lockQueue", attributes: .concurrent)

    private var _sharedProperty: Int = .zero


    var sharedProperty: Int {
        get {
            /// lockQueue.sync: safely read the property, ensuring thread safety
            lockQueue.sync {
                return _sharedProperty
            }
        }

        set {
            /// lockQueue.async(flags: .barrier): this ensure that write operations are executed exclusively, preventinfg race condition.
            lockQueue.async(flags: .barrier) { [weak self] in
                self?._sharedProperty = newValue
            }
        }
    }
}


/// References:
///  https://stackoverflow.com/questions/49160125/thread-safe-singleton-in-swift
///  https://stackoverflow.com/questions/65574904/swift-safe-thread-using-nslock-or-concurrent-queue
///  https://stackoverflow.com/questions/45710200/thread-safety-for-a-getter-and-setter-in-a-singleton
///  https://swiftrocks.com/thread-safety-in-swift
