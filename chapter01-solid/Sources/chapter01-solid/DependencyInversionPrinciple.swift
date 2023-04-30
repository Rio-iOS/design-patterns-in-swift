//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/04/30.
//

import Foundation
/*
 依存関係逆転の法則
 - 上位モジュールが下位モジュールに依存しない
 - 抽象化は細部に依存してはならない
 */

enum Relationship {
    case parent
    case child
    case sibling
}

class Person {
    var name = ""
    
    init(name: String) {
        self.name = name
    }
}

protocol RelationshipBrowser {
    func findAllChildrenOf(_ name: String) -> [Person]
}

// low-level
class Relationships: RelationshipBrowser {
    var relations = [(Person, Relationship, Person)]()
    
    func addParentAndChild(_ p: Person, _ c: Person) {
        relations.append((p, .parent, c))
        relations.append((c, .child, p))
    }
    
    func findAllChildrenOf(_ name: String) -> [Person] {
        return relations
            .filter { $0.name == name && $1 == .parent && $2 === $2}
            .map{$2}
    }
}

// high-level
class Research {
    // low-levelのモジュール（Relationships）に依存してしまっている
    /*
    init(_ relationships: Relationships) {
        let relations = relationships.relations
        for r in relations where r.0.name == "John" && r.1 == .parent{
            print("John has a child called \(r.2.name)")
        }
    }
    */
    
    // モジュールは、抽象化されたものに依存
    init(_ browser: RelationshipBrowser) {
        for p in browser.findAllChildrenOf("John") {
            print("John has a chld called \(p.name)")
        }
    }
}

