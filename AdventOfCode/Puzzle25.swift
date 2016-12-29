//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle25: PuzzleProtocol {
    
    var instructions = [Instruction]()
    
    func startResolution() -> () {
        
        
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle25.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        let instructionsRaw = fileContent2.components(separatedBy: "\n");
        
        for instructionRaw in instructionsRaw {
            if(instructionRaw == ""){
                continue;
            }
            instructions.append(Instruction(instructionRaw: instructionRaw))
        }
        fileContent2 = ""
        
        findWith(1)
        
        
    }
    
    func findWith(_ a: Int){
        var letters : [String: Int] = ["a": a, "b": 0, "c": 0, "d": 0]
        var offset = 0;
        clock = ""
        while offset<instructions.count {
            //READ INSTRUCTION
            
             if offset == 2 {
             letters["d"]! += 231 * letters["c"]!
             letters["b"]! = 0
             letters["c"]! = 0
             offset += 6
             }
            //print(letters)
            
            instructions[offset].type?.apply(&letters, instructions: instructions, offset: &offset, outcallback: { found in
                if found {
                    print(a)
                }else{
                    findWith(a+1)
                }
            })
            
            
        }
        
        print(letters)
    }
    
}
