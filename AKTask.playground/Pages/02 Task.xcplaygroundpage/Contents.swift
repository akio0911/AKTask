import UIKit


class Task<Value> {
    
    typealias FulfillHandler = Value -> Void
    
    typealias InitClosure = (fulfill: FulfillHandler) -> Void
    
    init(initClosure: InitClosure) {
        
        let fulfill: FulfillHandler = { (value: Value) -> Void in
            print("value", value)
        }
        
        initClosure(fulfill: fulfill)
    }
}

print("before")
let task1 = Task<Int> { (fulfill) in
    print("before fulfill")
    fulfill(123)
    print("after fulfill")
}
print("after")

