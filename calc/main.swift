import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst()

var cal = Calc()
cal.calculate(args: &args)

//for i in 0..<args.count {
//    let pred = NSPredicate(format: "SELF MATCHES %@", "^[+-]?[0-9]*|[+-/%x]$")
//    let isMatch: Bool = pred.evaluate(with: args[i])
//    print(args[i]+" ",terminator:"")
//    print(isMatch)
//}
//var i = Int("q")
//print(i==nil)

//let isSym = NSPredicate(format: "SELF MATCHES %@", "\\+|-|x|/|%")
//let isMatchSym: Bool = isSym.evaluate(with: "1")
//print(isMatchSym)

