//
//  Puzzle2.swift
//  AdventOfCode
//
//  Created by Florent Douine on 02/09/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa


class Puzzle3: PuzzleProtocol {
    
    var grid = [
        
        ["",   "", "1", "", ""],
        ["",  "2", "3", "4", ""],
        ["5", "6", "7", "8", "9"],
        ["",  "A", "B", "C", ""],
        ["",   "", "D", "", ""],
        
        ]
    
    func startResolution(){
        
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle3.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        var total = 0
        var row : Int = 0
        var rows = fileContent.components(separatedBy: "\n")
        for presentRaw in rows {
            if(row%3 != 2) {
                row += 1
                continue
            }
            
            
            let tsizes1 = rows[row].components(separatedBy: " ").filter({$0 != ""})
            let tsizes2 = rows[row-1].components(separatedBy: " ").filter({$0 != ""})
            let tsizes3 = rows[row-2].components(separatedBy: " ").filter({$0 != ""})
            
            let sizes1 = [tsizes1[0], tsizes2[0], tsizes3[0]].sorted(by: {Int($0)! > Int($1)!})
            let sizes2 = [tsizes1[1], tsizes2[1], tsizes3[1]].sorted(by: {Int($0)! > Int($1)!})
            let sizes3 = [tsizes1[2], tsizes2[2], tsizes3[2]].sorted(by: {Int($0)! > Int($1)!})
            
            
            let size11 = Int(sizes1[0])!
            let size12 = Int(sizes1[1])!
            let size13 = Int(sizes1[2])!
            
            if ((size13+size12)>size11){
                total += 1
            }
            
            let size21 = Int(sizes2[0])!
            let size22 = Int(sizes2[1])!
            let size23 = Int(sizes2[2])!
            
            if ((size23+size22)>size21){
                total += 1
            }
            
            let size31 = Int(sizes3[0])!
            let size32 = Int(sizes3[1])!
            let size33 = Int(sizes3[2])!
            
            if ((size33+size32)>size31){
                total += 1
            }
            
            row += 1
            
        }
        print(total)
    }
    
    func codeAt(point: CGPoint) -> String{
        return grid[Int(point.y)][Int(point.x)]
    }
}
