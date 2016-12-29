//
//  Puzzle1.swift
//  AdventOfCode
//
//  Created by Florent Douine on 02/09/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa

enum Orientation{
    case NORTH
    case EAST
    case WEST
    case SOUTH
    
    func newOrientationFor(letter: String) -> Orientation {
        switch self {
        case .NORTH:
            return letter == "R" ? .EAST : .WEST
            
        case .EAST:
            return letter == "R" ? .SOUTH: .NORTH
            
        case .WEST:
            return letter == "R" ? .NORTH : .SOUTH
            
        case .SOUTH:
            return letter == "R" ? .WEST : .EAST
        }
    }
    
    func movePoint(point: CGPoint, distance: Int) -> CGPoint{
        var newPoint = point
        switch self {
        case .NORTH:
            newPoint.y = CGFloat(Int(point.y) + distance)
            break
        case .EAST:
            newPoint.x = CGFloat(Int(point.x) + distance)
            break
        case .WEST:
            newPoint.x = CGFloat(Int(point.x) - distance)
            break
        case .SOUTH:
            newPoint.y = CGFloat(Int(point.y) - distance)
            break
        }
        
        return newPoint
    }
    
    func getAllVisited(point: CGPoint, distance: Int) -> [CGPoint] {
        
        switch self {
        case .NORTH:
            return Array((Int(point.y)+1)...(Int(point.y)+distance)).map({ y in
                return CGPoint(x: point.x, y: CGFloat(y))
            }) as [CGPoint]
        case .EAST:
            return Array((Int(point.x)+1)...(Int(point.x)+distance)).map({ x in
                return CGPoint(x: CGFloat(x), y: point.y)
            }) as [CGPoint]
        case .WEST:
            return Array((Int(point.x)-distance)...(Int(point.x)-1)).map({ x in
                return CGPoint(x: CGFloat(x), y: point.y)
            }) as [CGPoint]
        case .SOUTH:
            return Array((Int(point.y)-distance)...(Int(point.y)-1)).map({ y in
                return CGPoint(x: point.x, y: CGFloat(y))
            }) as [CGPoint]
        }
        
    }
    
    
}

class Puzzle1 : PuzzleProtocol{
    
    
    func startResolution(){
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle1.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        var points = [CGPoint]()
        
        var orientation : Orientation = .NORTH
        var point = CGPoint(x: 0, y: 0)
        for instruction in fileContent.components(separatedBy: ", ") {
            let letter = instruction.substring(to: instruction.index(instruction.startIndex, offsetBy: 1))
            let distance = Int(instruction.substring(from: instruction.index(instruction.startIndex, offsetBy: 1)))
            
            /*
             PART 1
            orientation = orientation.newOrientationFor(letter: letter)
            point = orientation.movePoint(point: point, distance: distance!)
            */
            
            orientation = orientation.newOrientationFor(letter: letter)
            let addedPoints = orientation.getAllVisited(point: point, distance: distance!)
            for p in addedPoints {
                if(points.contains(p)){
                    print(p)
                    
                }
            }
            points.append(contentsOf: addedPoints)
            
            point = orientation.movePoint(point: point, distance: distance!)
            
            
        }
        
        print(point);
        
        
    }
    
}
