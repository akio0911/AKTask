import UIKit


class Task {
    typealias InitClosure = () -> Void
    
    init(initClosure: InitClosure) {
        initClosure()
    }
}

print("before")
let task1 = Task(initClosure: { print("closure") })
print("after")

