import Foundation

class Calc {

    func calculate(args: inout [String]) throws {

        for i in 0..<args.count {
            let isNum = NSPredicate(format: "SELF MATCHES %@", "^[+-]?[0-9]+$")
            let isSym = NSPredicate(format: "SELF MATCHES %@", "\\+|-|x|/|%")
            let isMatchNum: Bool = isNum.evaluate(with: args[i])
            let isMatchSym: Bool = isSym.evaluate(with: args[i])
            
            if((!isMatchNum) && (!isMatchSym)) {
                throw CalcError.InvalidInputError
            } else if (isMatchSym) {
                if( i == 0 || i == args.count - 1) {
                    throw CalcError.SymbolPositionError
                }
                let prev = Int(args[i - 1])
                let next = Int(args[i + 1])
                if(prev == nil || next == nil) {
                    throw CalcError.SymbolPositionError
                }
                if((args[i] == "/" || args[i] == "%") && next == 0) {
                    throw CalcError.DivAndModZeroError
                }
            } else if (isMatchNum) {
                guard let _ = Int (args[i]) else {
                    throw CalcError.NumericOutOfBoundsError
                }
                if(i == 0 && args.count > 1) {
                    let next = isSym.evaluate(with: args[i + 1])
                    if(!next) {
                        throw CalcError.NumberPositionError
                    }
                } else if(i > 0 && i + 1 < args.count) {
                    let prev = isSym.evaluate(with: args[i - 1])
                    let next = isSym.evaluate(with: args[i + 1])
                    if((!prev) && (!next)) {
                        throw CalcError.NumberPositionError
                    }
                }
            }
        }

        if(args.count == 1) {
            print(Int(args[0])!)
            exit(0)
        }

        for i in 0..<args.count {
            if(args[i] == "x" || args[i] == "/" || args[i] == "%") {
                var res = reduce(args: &args, i: i)
                try calculate(args: &res)
                break
            }
        }

        for i in 0..<args.count {
            if(args[i] == "+" || args[i] == "-") {
                var res = reduce(args: &args, i: i)
                try calculate(args: &res)
                break
            }
        }

    }

    func reduce(args: inout [String], i: Int) -> [String] {

        switch args[i] {
        case "+":
            args.replaceSubrange(i - 1...i + 1, with: [String(Int(args[i - 1])! + Int(args[i + 1])!)])
        case "-":
            args.replaceSubrange(i - 1...i + 1, with: [String(Int(args[i - 1])! - Int(args[i + 1])!)])
        case "x":
            args.replaceSubrange(i - 1...i + 1, with: [String(Int(args[i - 1])! * Int(args[i + 1])!)])
        case "/":
            args.replaceSubrange(i - 1...i + 1, with: [String(Int(args[i - 1])! / Int(args[i + 1])!)])
        case "%":
            args.replaceSubrange(i - 1...i + 1, with: [String(Int(args[i - 1])! % Int(args[i + 1])!)])
        default:
            break
        }

        return args

    }

}
