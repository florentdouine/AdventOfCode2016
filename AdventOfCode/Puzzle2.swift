//
//  Puzzle2.swift
//  AdventOfCode
//
//  Created by Florent Douine on 02/09/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa


class Puzzle2: PuzzleProtocol {

    var grid = [
        
        ["",   "", "1", "", ""],
        ["",  "2", "3", "4", ""],
        ["5", "6", "7", "8", "9"],
        ["",  "A", "B", "C", ""],
        ["",   "", "D", "", ""],
        
        ]
    
    func startResolution(){

        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle2.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        
        var pos = CGPoint(x: 0, y: 2)
        var code = "7"
        for presentRaw in fileContent.components(separatedBy: "\n") {
            
            for char in presentRaw.characters {
                
                let s = String(char)
                
                switch s {
                case "L":
                    if pos.x > 0 && codeAt(point: CGPoint(x: pos.x-1, y: pos.y)) != "" {
                        pos = CGPoint(x: pos.x-1, y: pos.y)
                    }
                    break;
                case "R":
                    if pos.x < 4 && codeAt(point: CGPoint(x: pos.x+1, y: pos.y)) != "" {
                        pos = CGPoint(x: pos.x+1, y: pos.y)
                    }
                    break;
                case "U":
                    if pos.y > 0 && codeAt(point: CGPoint(x: pos.x, y: pos.y-1)) != "" {
                        pos = CGPoint(x: pos.x, y: pos.y-1)
                    }
                    break;
                case "D":
                    if pos.y < 4 && codeAt(point: CGPoint(x: pos.x, y: pos.y+1)) != "" {
                        pos = CGPoint(x: pos.x, y: pos.y+1)
                    }
                    break;
                default:
                    break;
                }
                
            }
            print(codeAt(point: pos))
            
        }
    }
    
    func codeAt(point: CGPoint) -> String{
        return grid[Int(point.y)][Int(point.x)]
    }
}
