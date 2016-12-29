//: Playground - noun: a place where people can play

import Cocoa


func EquationCaptcha(equation: String) -> Int {
    let parts = equation.components(separatedBy: "=")
    
    let K = Int(parts[0].contains("x") ? parts[1] : parts[0])!
    var eq = parts[0].contains("x") ? parts[0] : parts[1]
    eq = eq.replacingOccurrences(of: "-x", with: "-1x")
    
    let matchs = matches(for: "([-+]?[0-9]?)x", in: eq)
    
    let N = Int(matchs[1]) ?? 1
    let M = Int(eq.replacingOccurrences(of: matchs[0], with: ""))!
    
    return (K-M)/N
    
}

func matches(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        
        var matches = [String]()
        for g in 0...regex.numberOfCaptureGroups {
            matches.append(nsString.substring(with: results.first!.rangeAt(g)))
        }
        return matches;
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

EquationCaptcha(equation: "3x+4=7")
EquationCaptcha(equation: "5+x=9")
EquationCaptcha(equation: "-44=7x-2")
EquationCaptcha(equation: "-8=-21-x")



