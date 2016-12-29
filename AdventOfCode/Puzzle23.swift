//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle23: PuzzleProtocol {
    
    func startResolution() -> () {
        
        
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle23.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        let instructionsRaw = fileContent2.components(separatedBy: "\n");
        var instructions = [Instruction]()
        
        for instructionRaw in instructionsRaw {
            if(instructionRaw == ""){
                continue;
            }
            instructions.append(Instruction(instructionRaw: instructionRaw))
        }
        fileContent2 = ""
        
        var offset = 0;
        var letters : [String: Int] = ["a": 12, "b": 0, "c": 0, "d": 0]
        
        while offset<instructions.count {
            //READ INSTRUCTION
            
            if offset == 4 {
                letters["a"]! += letters["b"]! * letters["d"]!
                letters["c"]! = 0
                letters["d"]! = 0
                offset += 6
            }
            
            instructions[offset].type?.apply(&letters, instructions: instructions, offset: &offset)
            
            
        }
        
        print(letters)
        
    }
    
}
