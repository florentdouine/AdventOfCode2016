//
//  Grid.swift
//  AdventOfCode
//
//  Created by Florent Douine on 04/09/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa

protocol Copying {
    init(original: Self)
}

extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}

class Grid : CustomStringConvertible {

    var lights = [[Light]]()
    
    var description:String {
        var tempDesc = "";
        for y in 0..<6{
            for x in 0...lights.count-1 {
                let light = lights[x][y]
                tempDesc += light.on == 1 ? "|" : " "
            }
            tempDesc += "\n"
        }
        return tempDesc
    }
    
    init(){
        for x in 0..<50 {
            var subLights = [Light]()
            for y in 0..<6{
                subLights.append(Light(x: x, y: y))
            }
            self.lights.append(subLights)
        }
    }
    
    func decale(_ axis: String, coordinate: Int, decale: Int){
        if(axis=="row"){
            var newRow = [Light]()
            for i in 0..<lights.count {
                newRow.append(lights[i][coordinate])
            }
            for i in 0..<lights.count {
                lights[i][coordinate]  = newRow[(i-decale+lights.count+lights.count)%lights.count]
            }
            

        }else if(axis=="column"){
            for _ in 0..<decale {
                lights[coordinate].insert(Light(x:0, y:0), at: 0)
                lights[coordinate][0] = lights[coordinate].last!
                lights[coordinate].removeLast()
            
            }
        }
    }
    
    func turnOnAll(_ initialPoint: CGPoint, destinationPoint: CGPoint) {
        self.applyAll(initialPoint, destinationPoint: destinationPoint) { (light) in
            light.switchOn()
        }
    }
    
    func turnOffAll(_ initialPoint: CGPoint, destinationPoint: CGPoint) {
        self.applyAll(initialPoint, destinationPoint: destinationPoint) { (light) in
            light.switchOff()
        }
    }
    
    func toggleAll(_ initialPoint: CGPoint, destinationPoint: CGPoint) {
        self.applyAll(initialPoint, destinationPoint: destinationPoint) { (light) in
            light.toggle()
        }
    }
    
    fileprivate func applyAll(_ initialPoint: CGPoint, destinationPoint: CGPoint, callback: (inout Light)->()){
        
        
        
        for x in Int(initialPoint.x) ... Int(destinationPoint.x) {
            for y in Int(initialPoint.y) ... Int(destinationPoint.y) {
                var light = lights[x][y]
                callback(&light)
            }
            
        }
        
    }
    
}
