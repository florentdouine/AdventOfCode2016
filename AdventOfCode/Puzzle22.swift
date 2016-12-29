//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

struct Node {
    var point : CGPoint
    var capacity: Int
    var used: Int
    
    var available: Int {
        return capacity - used
    }
    
    var percent : Float {
        return Float(used)/Float(capacity)
    }
    
    var isBlock: Bool{
        return capacity > 400
    }
    
}
class Puzzle22: PuzzleProtocol {
    
    var nodes = [[Node]]()
    func startResolution() -> () {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle22.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        
        var input = ["f", "b", "g", "d", "c", "e", "a", "h"]
        //var input = ["g", "c", "e", "d", "f", "a", "h", "b"]
        //var input = ["d", "e", "c", "a", "b"]
        
        //fileContent2 = "swap position 4 with position 0\nswap letter d with letter b\nreverse positions 0 through 4\nrotate left 1 step\nmove position 1 to position 4\nmove position 3 to position 0\nrotate based on position of letter b\nrotate based on position of letter d"
        
        var startingNode : Node? = nil
        
        for n in fileContent2.components(separatedBy: "\n") {
            
            let m = matches(for: "\\/dev\\/grid\\/node-x([0-9]+)-y([0-9]+)\\s+([0-9]+)T\\s+([0-9]+)T", in: n)
            let x = Int(m[0])!
            let y = Int(m[1])!
            let node = Node(point: CGPoint(x: x, y: y), capacity: Int(m[2])!, used: Int(m[3])!)
            if nodes.count <= x {
                nodes.append([Node]())
            }
            nodes[x].append(node)
            if node.used == 0 {
                startingNode = node
            }
        }
        
        printNodes()
        
        //let _ = findAllRoutesfrom([startingNode!], to: nodes[32][0])
        
        
        
        /*
         1 star
        nodes.sort(by: {$0.0.available > $0.1.available})
        
        print(nodes.filter({$0.used <= 90}).count)
        */
        
    }
    
    //func findAllRoutesfrom(_ points:[Node], to: Node) -> Int {
        
    //}
    
    
    
    
    func printNodes(){
        var desc = ""
        for y in 0...29 {
            for x in 0...32 {
                let node = nodes[x][y]
                var letter = node.used == 0 ? "_" : node.isBlock ? "#" : "."
                if x == 32 && y == 0 {
                    letter = "G"
                }
                
                desc += letter+" "
            }
            desc += "\n"
        }
        print(desc)
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
