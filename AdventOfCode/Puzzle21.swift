//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle21: PuzzleProtocol {
    
    func startResolution() -> () {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle21.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        
        var input = ["f", "b", "g", "d", "c", "e", "a", "h"]
        //var input = ["g", "c", "e", "d", "f", "a", "h", "b"]
        //var input = ["d", "e", "c", "a", "b"]
        
        //fileContent2 = "swap position 4 with position 0\nswap letter d with letter b\nreverse positions 0 through 4\nrotate left 1 step\nmove position 1 to position 4\nmove position 3 to position 0\nrotate based on position of letter b\nrotate based on position of letter d"
        
        for n in fileContent2.components(separatedBy: "\n").reversed() {
            print(input.joined())
            let m1 = matches(for: "swap position ([0-9]+) with position ([0-9]+)", in: n)
            if !m1.isEmpty{
                let temp = input[Int(m1[0])!]
                input[Int(m1[0])!] = input[Int(m1[1])!]
                input[Int(m1[1])!] = temp
                continue;
            }
            
            let m2 = matches(for: "swap letter ([a-z]) with letter ([a-z])", in: n)
            if !m2.isEmpty{
                for i in 0..<input.count {
                    if input[i] == m2[0] {
                        input[i] = m2[1]
                    }else if input[i] == m2[1] {
                        input[i] = m2[0]
                    }
                }
                continue;
            }
            
            let m3 = matches(for: "rotate (left|right) ([0-9]+) step", in: n)
            if !m3.isEmpty{
                for _ in 0..<Int(m3[1])! {
                    if m3[0] == "left"{
                        input.insert(input.removeLast(), at: 0)
                    }else{
                        input.append(input.removeFirst())
                    }
                }
                continue;
            }
            
            let m4 = matches(for: "rotate based on position of letter ([a-z])", in: n)
            if !m4.isEmpty{
                let d = input.index(of: m4[0])!
                var f = 0
                switch d {
                case 0:
                    f = 1
                    break
                case 1:
                    f = 1
                    break
                case 2:
                    f = 6
                    break
                case 3:
                    f = 2
                    break
                case 4:
                    f = 7
                    break
                case 5:
                    f = 3
                    break
                case 6:
                    f = 0
                    break
                case 7:
                    f = 4
                    break
                default:
                    break
                }
                
                for _ in 0..<f {
                    input.append(input.removeFirst())
                }
                continue
            }
            
            let m5 = matches(for: "reverse positions ([0-9]+) through ([0-9]+)", in: n)
            if !m5.isEmpty{
                let myRange: ClosedRange = Int(m5[0])!...Int(m5[1])!
                let i = input[myRange].reversed()
                
                input.replaceSubrange(myRange, with: i)
                continue
            }
            
            let m6 = matches(for: "move position ([0-9]+) to position ([0-9]+)", in: n)
            if !m6.isEmpty{
                let el = input.remove(at: Int(m6[1])!)
                input.insert(el, at: Int(m6[0])!)
                continue
            }
            
            print(n)
            
        }
        
        print(input.joined())
        
    }
    
    
    
    /*func startResolution() -> () {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle21.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        var input = ["a", "b", "c", "d", "e", "f", "g", "h"]
        //fileContent2 = "swap position 4 with position 0\nswap letter d with letter b\nreverse positions 0 through 4\nrotate left 1 step\nmove position 1 to position 4\nmove position 3 to position 0\nrotate based on position of letter b\nrotate based on position of letter d"
        
        for n in fileContent2.components(separatedBy: "\n") {
            print(input.joined())
            let m1 = matches(for: "swap position ([0-9]+) with position ([0-9]+)", in: n)
            if !m1.isEmpty{
                let temp = input[Int(m1[0])!]
                input[Int(m1[0])!] = input[Int(m1[1])!]
                input[Int(m1[1])!] = temp
                continue;
            }
        
            let m2 = matches(for: "swap letter ([a-z]) with letter ([a-z])", in: n)
            if !m2.isEmpty{
                for i in 0..<input.count {
                    if input[i] == m2[0] {
                        input[i] = m2[1]
                    }else if input[i] == m2[1] {
                        input[i] = m2[0]
                    }
                }
                continue;
            }
            
            let m3 = matches(for: "rotate (left|right) ([0-9]+) step", in: n)
            if !m3.isEmpty{
                for _ in 0..<Int(m3[1])! {
                    if m3[0] == "right"{
                        input.insert(input.removeLast(), at: 0)
                    }else{
                        input.append(input.removeFirst())
                    }
                }
                continue;
            }
            
            let m4 = matches(for: "rotate based on position of letter ([a-z])", in: n)
            if !m4.isEmpty{
                var i = input.index(of: m4[0])! + 1
                if input.index(of: m4[0])! >= 4{
                    i += 1
                }
                for _ in 0..<i {
                    input.insert(input.removeLast(), at: 0)
                }
                continue
            }
            
            let m5 = matches(for: "reverse positions ([0-9]+) through ([0-9]+)", in: n)
            if !m5.isEmpty{
                let myRange: ClosedRange = Int(m5[0])!...Int(m5[1])!
                let i = input[myRange].reversed()
                
                input.replaceSubrange(myRange, with: i)
                continue
            }
            
            let m6 = matches(for: "move position ([0-9]+) to position ([0-9]+)", in: n)
            if !m6.isEmpty{
                let el = input.remove(at: Int(m6[0])!)
                input.insert(el, at: Int(m6[1])!)
                continue
            }
            
            print(n)
            
        }
        
        print(input.joined())
        
    }*/

    
}
