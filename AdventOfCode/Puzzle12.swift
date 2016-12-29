//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle12: PuzzleProtocol {
    
    func startResolution() -> () {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle12.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        let instructionsRaw = fileContent2.components(separatedBy: "\n");
        //let instructionsRaw = ["inc a"];
        var instructions = [Instruction]()
        for instructionRaw in instructionsRaw {
            if(instructionRaw == ""){
                continue;
            }
            instructions.append(Instruction(instructionRaw: instructionRaw))
        }
        
        var offset = 0;
        var letters = ["c" : 1]
        while offset<instructions.count {
            //READ INSTRUCTION
            let instruction = instructions[offset]
            instruction.type?.apply(&letters, instructions: instructions, offset: &offset)
            
        }
        
        print(letters)
        
    }
    
}
