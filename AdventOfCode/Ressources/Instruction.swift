//
//  Instruction.swift
//  AdventOfCode
//
//  Created by Florent Douine on 01/09/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa

var clock = ""
let scheme = "01010101010101"
enum InstructionType{
    case inc(String)
    case dec(String)
    case cpy(String, String)
    case tgl(String)
    case jnz(String, String)
    case out(String)
    
    
    func apply(_ letters: inout [String: Int], instructions: [Instruction], offset: inout Int, outcallback: (Bool) -> Void = { t in }){
        switch self {
        case let .inc(letter):
            letters[letter]! += 1
            offset += 1;
            break;
        case let .dec(letter):
            letters[letter]! -= 1
            offset += 1;
            break;
        case let .cpy(letter, letter2):
            if let v = Int(letter) {
                letters[letter2] = v
            }else{
                letters[letter2] = letters[letter]
            }
            offset += 1;
            break;
        case let .jnz(letter, letter2):
            let o = Int(letter2) ?? letters[letter2]!
            if let v = Int(letter) {
                if v != 0 {
                    offset += o
                }else{
                    offset += 1;
                }
            }else {
                let l2 = letters[letter]
                if l2 != 0 {
                    offset += o
                }
                else{
                    offset += 1;
                }
            }
            break;
        case let .tgl(letter):
            var o : Int = offset
            if let v = Int(letter) {
                o += v
            }else{
                o += letters[letter]!
            }
            if o < instructions.count {
                instructions[o].type = instructions[o].type!.inverse()
            }
            offset += 1;
            break;
            
        case let .out(letter):
            clock += String(letters[letter]!)
            if clock.characters.count == scheme.characters.count {
                outcallback(clock == scheme)
                return;
            }
            offset += 1;
            break;
        }
    }
    
    func inverse() -> InstructionType{
        switch self {
        case let .inc(letter):
            return .dec(letter)
            
        case let .dec(letter):
            return .inc(letter)
            
        case let .cpy(letter, letter2):
            return .jnz(letter, letter2)
            
        case let .jnz(letter, o):
            return .cpy(letter, "\(o)")
            
        case let .tgl(letter):
            return .inc(letter)
            
        case let .out(letter):
            return .out(letter)
        }
    }
}

class Instruction: NSObject {
    
    var type: InstructionType?
    
    init(instructionRaw: String){
        
        var c = instructionRaw.components(separatedBy: " ")
        let instructioName = c[0];
        
        switch instructioName {
        case "inc":
            self.type = .inc(c[1])
            break;
        case "dec":
            self.type = .dec(c[1])
            break;
        case "cpy":
            self.type = .cpy(c[1], c[2])
            break;
        case "jnz":
            self.type = .jnz(c[1], c[2])
            break;
        case "tgl":
            self.type = .tgl(c[1])
            break;
        case "out":
            self.type = .out(c[1])
            break;
        default:
            break;
        }
        
    }
    
}
