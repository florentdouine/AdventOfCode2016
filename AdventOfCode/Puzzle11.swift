//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

struct Level: CustomStringConvertible, Equatable {
    var representation : [[String]]
    var elevator: Int = 3
    var moves: Int = 0
    var checksum: String {
        return "\(elevator)-" + self.representation.map({$0.joined()}).joined(separator: "-")
    }
    
    init(representation: [[String]]){
        self.representation = representation
    }
    
    var isComplete: Bool{
        return isFloorComplete(0)
    }
    
    func isFloorComplete(_ floor: Int=0) -> Bool{
        return self.representation[floor].filter({$0 == ""}).isEmpty
    }
    
    func isFloorEmpty(_ floor: Int=0) -> Bool{
        return self.representation[floor].joined() == ""
    }
    
    var canMoveDown : Bool {
        return !(elevator == 2 && isFloorEmpty(3))
    }
    
    
    var isFailed: Bool{
        for i in 0..<self.representation.count{
            let gs = self.representation[i].filter({$0.contains("G")})
            if gs.isEmpty {
                continue
            }
            let ms = self.representation[i].filter({$0.contains("M")})
            for m in ms {
                let o = m.replacingOccurrences(of: "M", with: "G")
                if !gs.contains(o){
                    //No shield for this one
                    return true
                }
                
            }
            
        }
    
        return false

    }
    
    var description: String{
        var desc = "";
        for (i, s) in self.representation.enumerated(){
            let raw = s.map({ $0=="" ? ".  " : $0+" "}).joined()
            let elevatorS = i == elevator ? "E " : "- "
            desc += "F\(4-i) "+elevatorS+raw+"\n"
        }
        return desc
    }
    
    
    mutating func move(_ indexes: [Int], up: Bool){
        let newFloorIndex = elevator+(up ? -1 : 1);
        indexes.forEach { (index) in
            self.representation[newFloorIndex][index] = self.representation[elevator][index]
            self.representation[elevator][index] = ""
        }
        elevator = newFloorIndex
        moves += 1
        
        
    }
}

func == (l1: Level, l2: Level) -> Bool{
    return l1.checksum == l2.checksum
}

class Puzzle11: PuzzleProtocol {
    
    
    var maxMoves = 50
    
    
    func startResolution() {
        
            /*
            let level = Level(representation: [
                ["",   "",   "",   ""  ],
                ["",   "",   "LG", ""  ],
                ["HG", "",   "",   ""  ],
                ["",   "HM", "",   "LM"]
                ])*/
        /*
            let level = Level(representation: [
                ["",   ""],
                ["",   ""],
                ["HG", ""],
                ["",   "HM"]
                ], elevator: 3)*/
        /*
            let level = Level(representation: [
             ["",   "",   "",   "",   "",   "",   "",   "",   "",   ""  ],
             ["TM", "",   "",   "",   "",   "",   "",   "",   "",   ""  ],
             ["",   "TG", "RG", "RM", "CG", "CM", "",   "",   "",   ""  ],
             ["",   "",   "",   "",   "",   "",   "SG", "SM", "PG", "PM"]
                ])*/
        
            let level = Level(representation: [
            ["",   "",   "",   "",   "",   "",   "",   "",   "",   "",    "",   "",   "",   ""  ],
            ["TM", "",   "",   "",   "",   "",   "",   "",   "",   "",    "",   "",   "",   ""  ],
            ["",   "TG", "RG", "RM", "CG", "CM",  "",   "",   "",   "",    "",   "",   "",   "" ],
            ["",   "",   "",   "",   "",   "",   "SG", "SM", "PG", "PM", "EG", "EM", "DG", "DM" ]
            ])
 
        testAllPropositions([level.checksum : level])
        
    }
    
    var tested = 0
    var solutions : [String: Int] = [:]
    func testAllPropositions(_ levels: [String: Level]){
        
        var newLevels = [String: Level]()
        for (i,l) in levels.enumerated() {
            let level = l.value
            if i % 100 == 0 {
                print("Moves: \(level.moves) - \(i)/\(levels.count)")
            }
            var directions = [Bool]()
            if level.elevator == 0 {
                directions = [false]
            }else if level.elevator == 3 {
                directions = [true]
            }else {
                /*if !level.canMoveDown{
                    directions = [true]
                }else if level.elevator == 1 && level.isFloorEmpty(3) && level.isFloorEmpty(2){
                    directions = [true]
                }else {*/
                    directions = [true, false]
                //}
            }
            
            
            for d in directions{
                let all = (getAllPropositionsForLevel(level, up: d))
                for p in all {
                    
//                    tested += 1
//                    if tested % 10000 == 0{
//                        print(tested)
//                    }
                    var newLevel:Level = level
                    
                    newLevel.move(p, up: d)
                    //print("\(moves) moves")
                    
                    let c = newLevel.checksum
                    if solutions[c] == 1 || newLevels[c] != nil {
                        //print("Solution already tested");
                        continue
                    }
                    
                    if newLevel.isFailed == true {
                        //print("Solution failed");
                        continue
                    }
                    solutions[c] = 1
                    newLevels[c] = newLevel
                    
                    if newLevel.isComplete == true {
                        print("Found minimum solution \(newLevel.moves)")
                        maxMoves = newLevel.moves
                        return;
                    }
                    
                }
            }
        }
        testAllPropositions(newLevels)
    }
    
    
    func amIlucky(_ luck: Int) -> Bool{
        let diceRoll = Int(arc4random_uniform(UInt32(luck)) + 1)
        return diceRoll == 1
    }
    
    func getAllPropositionsForLevel(_ level: Level, up: Bool) -> [[Int]]{
        
        /*if !level.canMoveDown && up == false{
            return []
        }*/
        
        var indexes = [Int]()
        var propositions = [[Int]]()
        let floor: [String] = level.representation[level.elevator]
        for (i, string) in floor.enumerated(){
            if string != "" {
                indexes.append(i)
                propositions.append([i])
            }
        }
        //var propositions = indexes.map({[$0]}))
        if up == false {
            return propositions
        }
        //up = true
        //if (level.elevator == 1 && level.isFloorEmpty(0)) || (level.elevator == 2 && level.isFloorEmpty(1) && level.isFloorEmpty(0)){
            propositions = [[Int]]()
        //}
        
        
        for (i, index1) in indexes.enumerated() {
            for j in (i+1)..<indexes.count{
                propositions.append([index1, indexes[j]])
            }
        }
        
        
        
        
        return propositions
    }
    
    
    
}
