//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle14: PuzzleProtocol {
    
    let input = "abc";//"jlmsuwbz"; //"abc"
    
    func startResolution() {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle14.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        
        
        var number = 0
        
        var founds = [Int: [String]]()
        
        var matches = [(Int, Int)]()
        
        for md5 in fileContent2.components(separatedBy: "\n"){
            
            //let md5 = "afzlfzd0000ezfff"
            
            
            let regex5 = "([0-9a-z])\\1\\1\\1\\1"
            matchesAll(for: regex5, in: md5).forEach({ (s) in
                
                let previousMatches = founds.filter({!$0.value.filter({$0 == s}).isEmpty})
                previousMatches.forEach({ (element) in
                        if number-element.key > 1000{
                            //print("Stop here")
                            return
                        }
                    
                        if(matches.contains(where: {$0.1 == element.key})){
                            print("error")
                            return
                            
                        }
                    
                        print("Found match at position \(number) in \(element)")
                        matches.append((number,element.key))
                    
                })
                
                
            })
            
            let regex = "([0-9a-z])\\1\\1"
            if let s = matchesAll(for: regex, in: md5).first {
                if founds[number] == nil {
                    founds[number] = [String]()
                }
                founds[number]!.append(s + s[0] as String + s[0] as String)
                
             }
             
            number += 1
            
        }
        let result = matches.sorted(by: {$0.0 == $1.0 ? $0.1 < $1.1 : $0.0 < $1.0})
        let r = (result.sliceArray(0, x2: 63) as [(Int, Int)]).map({$0.1}).sorted()
        
        print(r[63])
        /*
         number:1469591 4
         number:1925351 5
         number:4310992 4
         number:4851204 3
         number:6610226 c
         number:6840976 1
         number:9504234 5
         number:10320588 4
         */
    }
    
    func md5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let d = string.data(using: String.Encoding.utf8) {
            d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
