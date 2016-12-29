//
//  Puzzle13.swift
//  AdventOfCode
//
//  Created by Florent Douine on 14/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle17 : PuzzleProtocol{
    
    /*
     #########
     #S| | | #
     #-#-#-#-#
     # | | | #
     #-#-#-#-#
     # | | | #
     #-#-#-#-#
     # | | |  
     ####### V
     
     */
    var grid = "#########\n#S| | | #\n#-#-#-#-#\n# | | | #\n#-#-#-#-#\n# | | | #\n#-#-#-#-#\n# | | |  \n####### V"
    
    var startPoint = CGPoint(x: 1, y:1)
    
    
    var input = "gdjjyniy" //"gdjjyniy"
    var destinationPoint = CGPoint(x: 7, y: 7)
    let width = 8
    let height = 8
    let maxStep = 50
    
    
    var minMoves = 10000
    var maxMoves = 50
    
    func startResolution() {
        
        
        
        testAllRoutes(startPoint, route: [], input: input)
        
        printGrid(destinations)
        
    }
    
    var destinations = [CGPoint]()
    
    func testAllRoutes(_ actualPoint: CGPoint, route: [CGPoint], input: String){
        var newRoute = route
        newRoute.append(actualPoint)
       
        if (actualPoint == destinationPoint){
            //Find route
            if maxMoves < newRoute.count{
                maxMoves = newRoute.count
                //printGrid(newRoute)
                print("New best path in \(newRoute.count-1) moves, input:\(input)");
            }
            return
        }
        //if newRoute.count > maxMoves{
        //    return;
        //}
       // if route.contains(actualPoint){
            //print("Already passed in this point")
        //    return;
        //}
        
        
        
        let md5 = input.md5()!
        let u = "bcdef".contains(md5[0] as String)
        let d = "bcdef".contains(md5[1] as String)
        let l = "bcdef".contains(md5[2] as String)
        let r = "bcdef".contains(md5[3] as String)
        
        let downPoint = CGPoint(x: actualPoint.x, y: actualPoint.y+2)
        if !isWall(downPoint) && d{
            testAllRoutes(downPoint, route: newRoute, input: input+"D");
        }
        
        let upPoint = CGPoint(x: actualPoint.x, y: actualPoint.y-2)
        if !isWall(upPoint) && u{
            testAllRoutes(upPoint, route: newRoute, input: input+"U");
        }
        
        let rightPoint = CGPoint(x: actualPoint.x+2, y: actualPoint.y)
        if !isWall(rightPoint) && r{
            testAllRoutes(rightPoint, route:  newRoute, input: input+"R");
        }
        
        let leftPoint = CGPoint(x: actualPoint.x-2, y: actualPoint.y)
        if !isWall(leftPoint) && l{
            testAllRoutes(leftPoint, route:  newRoute, input: input+"L");
        }
        
        
    }
    
    
    func printGrid(_ route: [CGPoint] = []) {
        
        
        print(grid)
    }
    
    
    func isWall(_ point: CGPoint) -> Bool{
        if (Int(point.x) > width-1 || point.x < 0 || point.y < 0 || Int(point.y) > height-1 ){
            return true
        }
        let lines = grid.components(separatedBy: "\n")
        let c = lines[Int(point.y)][Int(point.x)] as String
        
        return c == "#";
    }
    
}
