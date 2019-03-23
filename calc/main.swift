import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst()

var cal = Calc()
cal.calculate(args: &args)

