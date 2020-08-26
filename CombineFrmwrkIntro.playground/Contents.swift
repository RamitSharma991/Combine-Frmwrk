import Combine
import Foundation

// Combine framework provides a declarative Swift API for processing values over time.
// These values can represent many kinds of async events
// Combine declares publishers to expose values that can change over time And subscribers to recieve those values from the publishers


// The publisher protocol declares a type that can deliver a sequence of values over time
// Publishers have operators to act on the values recieved from upstream publishers and republish them
// At the end of th chain of publishers, a subscriber acts on elements as it recieves them. Publishers only emit values when explicitly requested to do so by subs. This puts subs code in control of how fast it recieves events from the publishers its connected to.

// Publisher defines how values and errors are produced
// They are structs of value type
// allows registeration of a subscriber


// Subscriber recieves values and a completion
// potential completion a referece type


//Operators
// Adopts Publisher
// describes behaviour for changing values
// subscribe to a publisher : upstream
// sends results to a subscriber: downstream
//value type


//Special Subscriber
// sink(recieveCompletion: recieveValue)
// assign(to: on:)

enum WeatherError: Error{
    case Uncertainity
}
let weatherPublisher = PassthroughSubject<Int, Error>()

let subscriber = weatherPublisher
    .filter {$0 > 25}
    .sink(receiveCompletion: { (value) in
        print("Potential value: \(value)")
    }) { (value) in
        print("A summer of \(value) ºC")
}

let anotherSubscriber = weatherPublisher.handleEvents(receiveSubscription: {subscription in
print("New Subscription \(subscription)")
}, receiveOutput: { output in
    print("New value: Output \(output)")
}, receiveCompletion: { error in
    print("Subscription completed with potential error \(error)")
}, receiveCancel: {
    print("Subscription cancelled")
}).sink(receiveCompletion: { (value) in
    print("Subscriber recieved value: \(value)")
}) { (value) in
    print("Subscriber Reciever value: \(value)")
}

weatherPublisher.send(10)
weatherPublisher.send(20)
weatherPublisher.send(24)
weatherPublisher.send(26)
weatherPublisher.send(28)
weatherPublisher.send(30)
// weatherPublisher.send(completion: Subscribers.Completion<WeatherError>.failure(.Uncertainity))
weatherPublisher.send(18)


