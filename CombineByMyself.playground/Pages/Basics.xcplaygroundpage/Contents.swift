import Combine
import Foundation

let publisher1 = Just("Hello")

let subscription = publisher1.sink { value in
    print("Received value from publisher1: \(value)")
}

let publisher2 = [1,2,3].publisher

let subcription2 = publisher2.sink { value in
    print("Received value from publisher2: \(value)")
}

class SomeClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let someObject = SomeClass()
let subscription3 = publisher2.assign(to: \.property, on: someObject)

let relay = PassthroughSubject<String, Never>()

relay.send("Hello")
let subscription4 = relay.sink { value in
    print("Subscription4 received value: \(value)")
}
relay.send("World!")


let variable = CurrentValueSubject<String, Never>("")
variable.send("Initial text")

let subscription5 = variable.sink { value in
    print("Subcription5 received value:\(value)")
}

variable.send("More text")

enum ExampleError: Swift.Error {
    case somethingWentWrong
}

let subject = PassthroughSubject<String, ExampleError>()

subject.handleEvents(receiveSubscription: { subscription in
    print("New subscription!")
}, receiveOutput: { value in
    print("Received new value!")
}, receiveCompletion: { _ in
    print("A subscription completed")
}, receiveCancel: {
    print("A subcription cancelled")
}, receiveRequest: { _ in
    print("A request received")
})
.replaceError(with: "Failure")
.sink { value in
    print("Subscripber received value: \(value)")
}



