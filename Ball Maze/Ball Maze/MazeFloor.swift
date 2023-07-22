//
//  MazeFloor.swift
//  Ball Maze
//
//  Created by Ben Hilger on 6/10/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import SceneKit

class MazeFloor {
    
    var scene : SCNScene = SCNScene()
    var box : SCNNode
    var grid : [[MazeRoom]] = []
    
    init(box : SCNNode, numOfRooms : Int, size : Int){
        self.box = box
        createMazeFloor(box: box, numR: numOfRooms, size: size)
    }
    
    func createMazeFloor(box : SCNNode, numR : Int, size : Int){
        for i in 0..<numR {
            grid.append([])
            
            for i2 in 0..<numR {
                let room = MazeRoom(box: box, x: size, y: size)
                
                if(i == 0 && i2 == 0){
                    room.createZeroZeroExits(size: size)
                }else if(i == 0 && i2+1 == numR) {
                    let prevRoom = grid[i][i2-1]
                    room.setWestExit(pos: prevRoom.getEastExit())
                    room.createSouthExit(size: size)
                }else if(i+1 == numR && i2 == 0){
                    let upperRoom = grid[i-1][i2]
                    room.setNorthExit(pos: upperRoom.getSouthExit())
                    room.createEastExit(size: size)
                }else if(i+1 == numR && i2+1 == numR){
                    let prevRoom = grid[i][i2-1]
                    let upperRoom = grid[i-1][i2]
                    room.setNorthExit(pos: upperRoom.getSouthExit())
                    room.setWestExit(pos: prevRoom.getEastExit())
                }else if(i+1 == numR && i2 > 0){
                    let prevRoom = grid[i][i2-1]
                    let upperRoom = grid[i-1][i2]
                    room.setWestExit(pos: prevRoom.getEastExit())
                    room.setNorthExit(pos: upperRoom.getSouthExit())
                    room.createEastExit(size: size)
                }else if(i > 0 && i2+1 == numR){
                    let prevRoom = grid[i][i2-1]
                    let upperRoom = grid[i-1][i2]
                    room.setNorthExit(pos: upperRoom.getSouthExit())
                    room.setWestExit(pos: prevRoom.getEastExit())
                    room.createSouthExit(size: size)
                }else if(i == 0 && i2 > 0){
                    let prevRoom : MazeRoom = grid[i][i2-1]
                    room.setWestExit(pos: prevRoom.getEastExit())
                    room.createEastExit(size: size)
                    room.createSouthExit(size: size)
                }else if(i > 0 && i2 == 0){
                    let upperRoom = grid[i-1][i2]
                    room.setNorthExit(pos: upperRoom.getSouthExit())
                    room.createSouthExit(size: size)
                    room.createEastExit(size: size)
                }else if(i > 0 && i2 > 0){
                    let prevRoom = grid[i][i2-1]
                    let upperRoom = grid[i-1][i2]
                    room.setNorthExit(pos: upperRoom.getSouthExit())
                    room.setWestExit(pos: prevRoom.getEastExit())
                    room.createEastExit(size: size)
                    room.createSouthExit(size: size)
                }
                
                grid[i].append(room)
            }
        }
    }
    
    func generateMaze(){
        
    }
    
    func printMaze(scene : SCNScene, offset : Float){
        var offsetX = offset
        var offsetY = offset
       /** for i in 0..<grid.count {
            for i2 in 0..<grid[i].count {
                grid[i][i2].projectRoom(scene: scene, offsetX: offsetX, offsetY: offsetY)
                
                offsetX += 40
                print(offsetX)
            }
            print(offsetY)
            offsetY += 40
            offsetX = offset
        }*/
        
        grid[0][0].projectRoom(scene: scene, offsetX: offsetX, offsetY: offsetY)
    }
}
