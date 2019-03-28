import Foundation

import GameKit

enum CalcError: Error {
    case SymbolPositionError
    case DivAndModZeroError
    case NumericOutOfBoundsError
    case NumberPositionError
}

var args = ProcessInfo.processInfo.arguments
args.removeFirst()

do {
    let cal = Calc()
    try cal.calculate(args: &args)
} catch CalcError.SymbolPositionError {
    print("Invalid symbol position error:\n1. Symbol at the first or last place.\n2. Consecutive symbols.")
    exit(1)
} catch CalcError.DivAndModZeroError {
    print("Division/Mod by zero error")
    exit(2)
} catch CalcError.NumericOutOfBoundsError {
    print("Numeric out-of-bounds error")
    exit(3)
} catch CalcError.NumberPositionError {
    print("Invalid number position error: Consecutive numbers, e.g.")
    exit(4)
}
