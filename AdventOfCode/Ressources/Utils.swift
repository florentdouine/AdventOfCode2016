//
//  Utils.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation



func matches(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        if results.isEmpty{
            return []
        }
        var matches = [String]()
        for g in 1...regex.numberOfCaptureGroups {
            matches.append(nsString.substring(with: results.first!.rangeAt(g)))
        }
        return matches;
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

func matchesAll(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range)}
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

extension String{
    
    mutating func nextString(){
        
        var pos = self.characters.count-1;
        for uni in self.unicodeScalars.reversed() {
            var val = uni.value
            var found = false
            if val == 122 { // If in the range "A"..."Y", just as an example
                val = 97
                found = true
            }else{
                val += 1
            }
            
            let t = UnicodeScalar(val)
            let newChar = String(describing: t!)
            
            self.replace(pos, newChar)
            
            if(!found){
                break;
            }
            
            pos -= 1
        }
        
    }
    
    mutating func replace(_ index: Int, _ newChar: String) {
        var modifiedString = String()
        for (i, char) in self.characters.enumerated() {
            //let character = String(char)
            modifiedString += (i == index) ? newChar : String(char)
        }
        self = modifiedString
    }
}


extension Array {
    
    func sliceArray<T>(_ x1: Int, x2: Int) -> Array<T> {
        
        if(x1>x2) {
            return []
        }
        var tt: Array<T> = []
        
        for i in x1...x2 {
            
            tt.append(self[i] as! T)
            
        }
        
        return tt
        
    }
    
    func combinations<T>( arr: Array<T>, k: Int) -> Array<Array<T>> {
        
        var arr = arr
        if(k==0){
     return [];
     }
     
     var ret: Array<Array<T>> = []
     
     var sub: Array<Array<T>> = []
     
     var next: Array<T> = []
     
     for i in 0 ..< arr.count {
     
     if(k == 1){
     
     ret.append([arr[i]])
     
     }else {
     
     sub = combinations(arr: self.sliceArray(i + 1, x2: self.count - 1), k: (k - 1))
     
     for subI in 0 ..< sub.count {
     
     next = sub[subI]
     
     next.insert(arr[i], at: 0)
     
     ret.append(next)
     
     }
     
     }
     
     }
     
     return ret
     
     }
    
    
    
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
