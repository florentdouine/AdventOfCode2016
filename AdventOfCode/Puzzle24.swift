//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation


class Puzzle24: PuzzleProtocol {
    
    
    var width : Int?
    var height : Int?
    
    
    var grid : [[String]] = [[String]]()
    func startResolution() -> () {
        
        
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle24.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        for n in fileContent2.components(separatedBy: "\n"){
            grid.append(n.characters.map { String($0) })
            
        }
        width = grid.first?.count
        height = grid.count
        
        var distance : [Int: [Int : Int]] = [Int: [Int : Int]]()
        var nPoints : [Int: CGPoint] = [:]
        for y in 0..<height! {
            for x in 0..<width! {
                let point = CGPoint(x: x, y: y)
                if let n = Int(element(point)){
                    nPoints[n] = point
                    distance[n] = [Int: Int]()
                }
            }
        }
        
        
        
        while let p = nPoints.popFirst() {
            testAllRoutes([p.value], route: [], destinationPoints: nPoints, whenFound: { number, dist in
                print("Found distance between \(p.key) and \(number) of \(dist)")
                
                distance[number]?[p.key] = dist
                distance[p.key]?[number] = dist
                
            })
            if nPoints.count == 1 {
                break
            }
        }
        
        
        let all = permutation(Array(1...7), actualArr: [])
        var min = 100000
        for s in all {
            var total = 0
            for (i, a) in s.enumerated(){
                let previous = (i == 0)  ? 0 : s[i-1]
                total += distance[previous]![a]!
            }
            total += distance[s.last!]![0]!
            
            if total < min {
                min = total
                print(s)
            }
            
        }
        

        print(min)
        
        
        
        //printGrid(destinations)
        
    }
    
    
    func permutation(_ arr: [Int], actualArr: [Int]) -> [[Int]]{
        
        if(actualArr.count == arr.count){
            return [actualArr]
        }
        
        var ret = [[Int]]();
        
        
        for i in arr {
            if(actualArr.contains(i)){
                continue
            }
            
            var actualCopy = [Int](actualArr)
            actualCopy.append(i)
            let sub = permutation(arr, actualArr: actualCopy);
            
            if(sub.count>0){
                ret.append(contentsOf: sub)
            }
        }
        
        
        return ret;
    }
    
    
    
    func testAllRoutes(_ actualPoints: [CGPoint], route: [CGPoint], moves: Int = 0, destinationPoints: [Int: CGPoint], whenFound: (Int, Int) -> Void){
        
        var points  = [CGPoint]()
        var r = route
        var destinations = destinationPoints
        for point in actualPoints {
            if let find = destinationPoints.first(where: {$0.value == point}) {
                whenFound(find.key, moves)
                destinations.removeValue(forKey: find.key)
                if destinations.isEmpty{
                    return
                }
            }
        
            if r.contains(point){
                continue
            }
        
            r.append(point)
        
            let downPoint = CGPoint(x: point.x, y: point.y+1)
            if !isWall(downPoint) && !actualPoints.contains(downPoint){
                points.append(downPoint)
            }
            
            let upPoint = CGPoint(x: point.x, y: point.y-1)
            if !isWall(upPoint) && !actualPoints.contains(upPoint){
                points.append(upPoint)
            }
            
            let rightPoint = CGPoint(x: point.x+1, y: point.y)
            if !isWall(rightPoint) && !actualPoints.contains(rightPoint){
                points.append(rightPoint)
            }
            
            let leftPoint = CGPoint(x: point.x-1, y: point.y)
            if !isWall(leftPoint) && !actualPoints.contains(leftPoint){
                points.append(leftPoint)
            }
        }

        testAllRoutes(points, route: r, moves: moves+1, destinationPoints: destinations, whenFound: whenFound)
        //printGrid(r)
    }
 
    
    
    func printGrid(_ route: [CGPoint] = []) {
        var desc = ""
        for y in 0..<height! {
            for x in 0..<width! {
                let point = CGPoint(x: x, y: y)
                desc += route.contains(point) ? "•" : element(point).replacingOccurrences(of: ".", with: " ")
            }
            desc += "\n"
        }
        
        print(desc)
    }
    
    
    func isWall(_ point: CGPoint) -> Bool{
        return element(point) == "#"
    }
    
    func element(_ point : CGPoint) -> String{
        return grid[Int(point.y)][Int(point.x)] as String
    }
}
