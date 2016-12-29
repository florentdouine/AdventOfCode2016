//
//  Puzzle13.swift
//  AdventOfCode
//
//  Created by Florent Douine on 14/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle13 : PuzzleProtocol{
    
    var startPoint = CGPoint(x: 1, y:1)
    
    
    /*
    var input = 10
    var destinationPoint = CGPoint(x: 7, y: 4)
    let width = 20
    let height = 20
    let maxStep = 5
     */
    
    
    var input = 1358
    var destinationPoint = CGPoint(x: 31, y: 39)
    let width = 50
    let height = 50
    let maxStep = 50
 
 
    var minMoves = 10000
    
    func startResolution() {
        
        
        
        //testAllRoutes(startPoint, route: [])
        findAllReachableDestinations(startPoint, route:[])
        
        printGrid(destinations)
        print(destinations.count)
        
    }
    
    var destinations = [CGPoint]()
    
    func findAllReachableDestinations(_ actualPoint: CGPoint, route: [CGPoint]){
        var r = route
        r.append(actualPoint)
        
        
        if !destinations.contains(actualPoint){
            destinations.append(actualPoint)
        }
        
        if route.contains(actualPoint){
            //print("Already passed in this point")
            return;
        }
        
        if r.count > maxStep{
            return
        }
        
        let downPoint = CGPoint(x: actualPoint.x, y: actualPoint.y+1)
        if !isWall(downPoint){
            findAllReachableDestinations(downPoint, route: r);
        }
        
        let upPoint = CGPoint(x: actualPoint.x, y: actualPoint.y-1)
        if !isWall(upPoint){
            findAllReachableDestinations(upPoint, route: r);
        }
        
        let rightPoint = CGPoint(x: actualPoint.x+1, y: actualPoint.y)
        if !isWall(rightPoint){
            findAllReachableDestinations(rightPoint, route: r);
        }
        
        let leftPoint = CGPoint(x: actualPoint.x-1, y: actualPoint.y)
        if !isWall(leftPoint){
            findAllReachableDestinations(leftPoint, route: r);
        }
    }
    
    
    func testAllRoutes(_ actualPoint: CGPoint, route: [CGPoint]){
        var r = route
        r.append(actualPoint)
        
        if (actualPoint == destinationPoint){
            //Find route
            if minMoves > r.count{
                minMoves = r.count
                printGrid(r)
                print("New best path in \(r.count-1) moves");
            }
            return
        }
        
        if route.contains(actualPoint){
            //print("Already passed in this point")
            return;
        }
        
        
        let downPoint = CGPoint(x: actualPoint.x, y: actualPoint.y+1)
        if !isWall(downPoint){
            testAllRoutes(downPoint, route: r);
        }
        
        let upPoint = CGPoint(x: actualPoint.x, y: actualPoint.y-1)
        if !isWall(upPoint){
            testAllRoutes(upPoint, route: r);
        }
        
        let rightPoint = CGPoint(x: actualPoint.x+1, y: actualPoint.y)
        if !isWall(rightPoint){
            testAllRoutes(rightPoint, route: r);
        }
        
        let leftPoint = CGPoint(x: actualPoint.x-1, y: actualPoint.y)
        if !isWall(leftPoint){
            testAllRoutes(leftPoint, route: r);
        }
        
        
    }
    
    
    func printGrid(_ route: [CGPoint] = []) {
        var desc = "  0123456789\n"
        for y in 0..<height {
            desc += "\(y) "
            for x in 0..<width {
                let point = CGPoint(x: x, y: y)
                desc += isWall(point) ? "•" : (route.contains(point) ? "0" : " ")
            }
            desc += "\n"
        }
        
        print(desc)
    }
    
    
    func isWall(_ point: CGPoint) -> Bool{
        if point.x < 0 || point.y < 0 || Int(point.x) >= width || Int(point.y) >= height {
            return true
        }
        let x = Int(point.x)
        let y = Int(point.y)
        var sum = x*x + 3*x + 2*x*y
        sum += y + y*y + self.input
        
        let binary = String(sum, radix: 2)
        let sumBinary = binary.characters.reduce(0, {$0 + (String($1) == "0" ? 0 : 1)})
        return sumBinary % 2 == 1
    }
    
}
