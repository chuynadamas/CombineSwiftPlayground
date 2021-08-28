//: [Previous](@previous)
import Foundation
import Combine

enum WeatherError: Error {
    case shitHappens(error: Error)
}

let weatherPublisher = PassthroughSubject<Int, WeatherError>()

let subscriber = weatherPublisher
    .filter { $0 > 25 }
    .sink(receiveCompletion: {_ in},
          receiveValue: {value in
            print("A summer day of \(value) °C")
          })

weatherPublisher.send(10)
weatherPublisher.send(40)
//: [Next](@next)
