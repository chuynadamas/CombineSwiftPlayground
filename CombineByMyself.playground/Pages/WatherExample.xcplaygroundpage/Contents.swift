//: [Previous](@previous)
import Foundation
import Combine

enum WeatherError: Error {
    case shitHappens
}

let weatherPublisher = PassthroughSubject<Int, WeatherError>()

let subscriber = weatherPublisher
    .filter { $0 > 25 }
    .sink(receiveCompletion: { error in
        print("Subscription completed with potential error: \(error)")
    },
    receiveValue: { value in
        print("A summer day of \(value) °C")
    })

weatherPublisher.send(10)
weatherPublisher.send(40)
weatherPublisher.send(completion: Subscribers.Completion<WeatherError>.failure(.shitHappens))
//: [Next](@next)
