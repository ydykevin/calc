import Foundation

import GameKit

var args = ProcessInfo.processInfo.arguments
args.removeFirst()

var cal = Calc()
cal.calculate(args: &args)

