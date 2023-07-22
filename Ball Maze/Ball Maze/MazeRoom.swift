//
//  MazeRoom.swift
//  Ball Maze
//
//  Created by Ben Hilger on 5/30/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import SceneKit

class MazeRoom {
    
    public var grid : [[SCNNode]] = []
    
    private var startingX : Int!
    private var startingY : Int!
    
    init(box : SCNNode, x : Int,y : Int){
        createGrid(box: box, x: x, y: y)
    }
    
    func createGrid(box : SCNNode, x: Int, y : Int){
        
        for i in 0..<x {
            grid.append([])
            
            for i2 in 0..<y {
                var willHole = willPlaceHole()
                
                if(i > 0) {
                    if(grid[i-1][i2].name!.contains("Hole")){
                        willHole = false
                    }
                    
                    if(i2 > 0){
                        if(grid[i-1][i2-1].name!.contains("Hole")){
                            willHole = false
                        }
                        if(i2+1 < y){
                            if(grid[i-1][i2+1].name!.contains("Hole")){
                                willHole = false
                            }
                        }
                        
                        if(grid[i][i2-1].name!.contains("Hole")){
                            willHole = false
                        }
                    }
                    
                   
                }else if(i == 0 && i2 > 0){
                    if(grid[i][i2-1].name!.contains("Hole")){
                        willHole = false
                    }
                }
            
                let nodeToAdd : SCNNode = box.copy() as! SCNNode
                
                if(willHole){
                    nodeToAdd.isHidden = true
                    nodeToAdd.name = "Hole"
                }
                
                nodeToAdd.position = SCNVector3(x: nodeToAdd.position.x + Float(5*i), y: nodeToAdd.position.y, z: nodeToAdd.position.z + Float(5*i2))
                
                grid[i].append(nodeToAdd)
            }
        }
    }
    
    func createZeroZeroExits(size : Int){
        createEastExit(size: size)
        createSouthExit(size: size)
    }

    func createNorthExit(size : Int) {
        var exitNum : Int = Int(arc4random_uniform(UInt32(size)))
        while(exitNum <= 0 || exitNum >= size) {
            exitNum = Int(arc4random_uniform(UInt32(size)))
        }
        setNorthExit(pos: exitNum)
    }
    
    func createSouthExit(size : Int) {
        var exitNum : Int = Int(arc4random_uniform(UInt32(size)))
        while(exitNum <= 0 || exitNum >= size) {
            exitNum = Int(arc4random_uniform(UInt32(size)))
        }
        setSouthExit(pos: exitNum)
    }
    
    func createEastExit(size : Int) {
        var exitNum : Int = Int(arc4random_uniform(UInt32(size)))
        while(exitNum <= 0 || exitNum >= size) {
            exitNum = Int(arc4random_uniform(UInt32(size)))
        }
        setEastExit(pos: exitNum)
    }
    
    func createWestExit(size : Int) {
        var exitNum : Int = Int(arc4random_uniform(UInt32(size)))
        while(exitNum <= 0 || exitNum >= size) {
            exitNum = Int(arc4random_uniform(UInt32(size)))
        }
        setWestExit(pos: exitNum)
    }
    
    func createExits(x : Int, y: Int){
        let limit = x-1
        let min = 1
        
        for i in min...limit {
            let createExit = willPlaceHole()
            
            if(createExit) {
                grid[0][i].name = "Exit"
                break
            }
        }
        
        for i in min...limit {
            let createExit = willPlaceHole()
            
            if(createExit) {
                grid[limit][i].name = "Exit"
                break
            }
        }
        
        for i in min...limit {
            let createExit = willPlaceHole()
            
            if(createExit) {
                grid[i][0].name = "Exit"
                break
            }
        }
        
        for i in min...limit {
            let createExit = willPlaceHole()
            
            if(createExit) {
                grid[i][grid[0].count-1].name = "Exit"
                break
            }
        }
    }
    
    func printResults(){
        for i in 0..<grid.count {
            var s : String = ""
            for i2 in 0..<grid[i].count {
                if(grid[i][i2].name?.contains("Hole"))!{
                    s += " H "
                }else if(grid[i][i2].name?.contains("Exit"))!{
                    s += " E "
                }else{
                    s += " * "
                }
            }
            print(s)
        }
    }
    
    
    func willPlaceHole() -> Bool {
        let num = arc4random_uniform(10)
        if(num == 0) {
            return true
        }
        return false
    }

    func setNorthExit(pos : Int){
        if(pos < grid[0].count && pos > 0) {
            for i in 0..<grid[0].count {
                if(grid[0][i].name?.contains("Exit"))!{
                    grid[0][i].name = ""
                }
            }
            grid[0][pos].name = "Exit"
        }
    }
    
    func setSouthExit(pos : Int){
        if(pos < grid[grid.count-1].count && pos > 0) {
            for i in 0..<grid[grid.count-1].count {
                if(grid[grid.count-1][i].name?.contains("Exit"))!{
                    grid[grid.count-1][i].name = ""
                }
            }
            grid[grid.count-1][pos].name = "Exit"
        }
    }
    
    func setWestExit(pos : Int){
        if(pos < grid.count && pos > 0){
            for i in 0..<grid[pos].count {
                if(grid[pos][i].name?.contains("Exit"))!{
                    grid[pos][i].name = ""
                }
            }
            grid[pos][0].name = "Exit"
        }
    }
    
    func setEastExit(pos : Int){
        if(pos < grid.count && pos > 0){
            for i in 0..<grid[pos].count {
                if(grid[pos][i].name?.contains("Exit"))!{
                    grid[pos][i].name = ""
                }
            }
            grid[pos][grid[0].count-1].name = "Exit"
        }
    }
    
    public func getNorthExit() -> Int {
        for i in 0..<grid.count {
            if(grid[0][i].name!.contains("Exit")){
                return i
            }
        }
        
        return -1
    }
    
    public func getSouthExit() -> Int {
        for i in 0..<grid.count {
            if(grid[grid.count-1][i].name!.contains("Exit")){
                return i
            }
        }
        
        return -1
    }
    
    public func getEastExit() -> Int{
        for i in 0..<grid.count {
            if(grid[i][grid[0].count-1].name!.contains("Exit")){
                return i
            }
        }
        return -1
    }
    
    public func getWestExit() -> Int {
        for i in 0..<grid.count {
            if(grid[i][0].name!.contains("Exit")){
                return i
            }
        }
        
        return -1
    }
        
    func projectRoom(scene : SCNScene, offsetX : Float, offsetY : Float){
        printResults()
        for index in 0..<grid.count {
            var length : Float = 0
            for index2 in 0..<grid[0].count {
                /**if(((index == 0 || index+1 == grid.count) || ((index2 == 0 || index2+1 == grid[index].count))) && grid[index][index2].name! != "Exit"){
                    if(index == 0 || index+1 == grid.count){
                        let newwall = wall.copy() as! SCNNode
                        newwall.position = SCNVector3(x: Float((index)*5) - (index == 0 ? (offset) : (offset)),y: newwall.position.y,z: Float((index2)*5)-offset-2.5)
                        scene.rootNode.addChildNode(newwall)
                    }
                    
                    if(index2 == 0 || index2+1 == grid[index].count){
                        let newwall2 = wall.copy() as! SCNNode
                        newwall2.eulerAngles = SCNVector3(x: 90, y: 0, z: 0)
                        newwall2.position = SCNVector3(x: Float((index)*5) - (offset),y: newwall2.position.y,z: Float((index2)*5) - (index2 == 0 ? (offset+2.5/**+3.5*/) : (offset+2.5/**+1*/)))
                        scene.rootNode.addChildNode(newwall2)
                        print("Here")
                    }
                }else if(grid[index][index2].name! == "Exit"){
                    let randnum = 1//arc4random_uniform(2) + 1
                    print(randnum)
                    let node = SCNScene(named: "art.scnassets/Entrance\(randnum).scn")!.rootNode.childNode(withName: "box", recursively: true)!
                    let height = (node.childNode(withName: "height", recursively: true)!.geometry as! SCNBox).width
                    let width = (node.childNode(withName: "width", recursively: true)!.geometry as! SCNBox).length
                    if(index2 == 0 || index2+1 == grid[0].count){
                        node.position = SCNVector3(x: node.position.x + Float((index)*5) - (offset-1),y: node.position.y,z: node.position.z + Float((index2)*5) - (index2 == 0 ? (offset+3.5) : (offset+1)))
                        scene.rootNode.addChildNode(node)
                    }
                }*/

                let node = grid[index][index2]
                if(!node.name!.contains("Hole")){
                    length += 1
                }else{
                    node.scale = SCNVector3(x: node.scale.x,y: node.scale.y, z: node.scale.z * length)
                    node.position = SCNVector3(x: Float((index)*5) - (offsetX + (node.scale.z * length)/2),y: 0,z: Float((index2)*5)-offsetY)
                    scene.rootNode.addChildNode(node)
                    length = 0 
                }
                
            }
        }
    }

}
