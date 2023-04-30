//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/04/30.
//

import Foundation

/*
 リスコフ置換の原則：ベースの型をサブの型に置換することができる原則
 */

class Rectangle: CustomStringConvertible {
    
    var _width = 0
    var _height = 0
    
    var width: Int {
        get { return _width }
        set(value) { _width = value }
    }
    
    var height: Int {
        get { return _height }
        set(value) { _height = value }
    }
   
    init(){}
    
    init(_width: Int = 0, _height: Int = 0) {
        self._width = _width
        self._height = _height
    }
    
    var area: Int {
        return width * height
    }
    
    public var description: String {
        return "width: \(width), height: \(height)"
    }
    
    
}

class Square: Rectangle {
    override var width: Int {
        get { return _width }
        set(value) {
            _width = value
            _height = value
        }
    }
    
    override var height: Int {
        get { return _height }
        set(value) {
            _width = value
            _height = value
        }
    }
}
