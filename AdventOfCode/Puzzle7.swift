//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle7: PuzzleProtocol {
    
    func startResolution() {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle7.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        var count = 0
        global: for string in fileContent.components(separatedBy: "\n") {
            var s = string
            let c = matchesAll(for: "\\[[a-z]+\\]", in: string)
            
            for bg in c{
                s = s.replacingOccurrences(of: bg, with: "-")
            }
            
            for t in s.components(separatedBy: "-") {
                for ssl in matchSSL(t)! {
                    for bg in c{
                        if bg.contains(ssl){
                            count+=1
                            continue global
                        }
                    }
                }
            }
            

        }
        print(count)
        
    }
    
    func matchTLS(_ string: String) -> Bool{
        let count = string.characters.count
        guard count > 3 else {
            return false
        }
        for i in 0...(count-4){
            let sub0 = string[i+0] as String
            let sub1 = string[i+1] as String
            let sub2 = string[i+2] as String
            let sub3 = string[i+3] as String
            if sub0 != sub1 && sub0==sub3 && sub2==sub1{
                return true
            }
            
        }
        
        return false
        
    }
    
    func matchSSL(_ string: String) -> [String]?{
        let count = string.characters.count
        guard count > 2 else {
            return nil
        }
        var matches = [String]()
        for i in 0...(count-3){
            let sub0 = string[i+0] as String
            let sub1 = string[i+1] as String
            let sub2 = string[i+2] as String
            if sub0 != sub1 && sub0==sub2{
                matches.append(sub1+sub0+sub1)
            }
            
        }
        
        return matches
        
    }
    
}
