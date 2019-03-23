import Foundation

class Calc {

    func calculate(args: inout [String]) {

        for i in 0..<args.count {
            let isNum = NSPredicate(format: "SELF MATCHES %@", "^[+-]?[0-9]+$")
            let isSym = NSPredicate(format: "SELF MATCHES %@", "\\+|-|x|/|%")
            let isMatchNum: Bool = isNum.evaluate(with: args[i])
            let isMatchSym: Bool = isSym.evaluate(with: args[i])
            if((!isMatchNum) && (!isMatchSym)) {
                print("neither")
                exit(1)
            } else if (isMatchSym) {
                if( i==0 || i == args.count - 1) {
                    print("is sym out range")
                    exit(1)
                }
                let prev = Int(args[i-1])
                let next = Int(args[i+1])
                if(prev==nil||next==nil){
                    print("is sym next not num")
                    exit(1)
                }
            } else if (isMatchNum) {
                if(i==0&&args.count>1){
                    let next = isSym.evaluate(with: args[i+1])
                    if(!next){
                        exit(1)
                    }
                }else if(i>0&&i+1<args.count){
                    let prev = isSym.evaluate(with: args[i-1])
                    let next = isSym.evaluate(with: args[i+1])
                    if((!prev)&&(!next)){
                        exit(1)
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
                reduce(args: &args, i: i)
            }
        }

        for i in 0..<args.count {
            if(args[i] == "+" || args[i] == "-") {
                reduce(args: &args, i: i)
            }
        }

    }

    func reduce(args: inout [String], i: Int) {

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

        calculate(args: &args)

    }

}

