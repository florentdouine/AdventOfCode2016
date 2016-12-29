//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle5: PuzzleProtocol {
    
    func startResolution() {
        
        var l = 0
        var numbers = [27000000]//[1469591, 1925351, 4310992, 4851204, 6610226, 6840976, 9504234, 10320588, 13000000]
        let input = "ojvtpuvg" //"abc"
        var number = 0
        var password = ["1","5","5","0","c","4","b","d"] // 1050cbbd 1550c4bd
        while(password.contains("")){
            if let n = numbers.first{
                number = n
                numbers.removeFirst()
            }else{
                number += 1
            }
            
            let md5 = self.md5(input+String(number))!
            let substr = md5.substring(to: md5.characters.index(md5.startIndex, offsetBy: 5));
            let n6 = (md5[6] as String)
            
            if substr == "00000", let n5 = Int(md5[5]), n5 < 8 {
                
                password[n5] = n6
                print("password:")
                print(password)
                
            }
            
            if (number % 1000000 == 0){
                print(number)
            }
            
        }
        
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
