import Foundation

import GameKit

enum CalcError: Error {
    case InvalidInputError
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
} catch CalcError.InvalidInputError{
    print("Invalid input: things are neither integer nor valid operators")
    exit(1)
} catch CalcError.SymbolPositionError {
    print("Invalid symbol position error:\n1. Symbol at the first or last place.\n2. Consecutive symbols.")
    exit(2)
} catch CalcError.DivAndModZeroError {
    print("Division/Mod by zero error")
    exit(3)
} catch CalcError.NumericOutOfBoundsError {
    print("Numeric out-of-bounds error")
    exit(4)
} catch CalcError.NumberPositionError {
    print("Invalid number position error: Consecutive numbers, e.g.")
    exit(5)
}
