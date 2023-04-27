//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/04/27.
//

import Foundation

// Open Closed Principle：クラスは拡張にはオープンであるが、変更にはクローズであるべき
// クラスに戻って、元のクラスを変更することは、拡張するのではなく、変更すること
enum Color {
    case red
    case green
    case blue
}

enum Size {
    case small
    case medium
    case large
    case yuge
}

class Product  {
    var name: String
    var color: Color
    var size: Size
    
    init(name: String, color: Color, size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
}

class ProductFilter {
    // 実装1（最初の要件）
    func fileterByColor(_ products: [Product], _ color: Color) -> [Product] {
        var result = [Product]()
        
        for p in products {
            if p.color == color {
                result.append(p)
            }
        }
        
        return result
    }
    
    // 実装2（追加の要件）
    func fileterBySize(_ products: [Product], _ size: Size) -> [Product] {
        var result = [Product]()
        
        for p in products {
            if p.size == size {
                result.append(p)
            }
        }
        
        return result
    }
    
    // 実装3（追加の要件）
    // 問題：誰かが機能追加を頼むたびに、すでに書いたクラス、すでにテストしたクラスに戻り、修正を行う必要があること
    func fileterByColorAndSize(_ products: [Product],_ color: Color, _ size: Size) -> [Product] {
        var result = [Product]()
        
        for p in products {
            if (p.size == size) && (p.color == color) {
                result.append(p)
            }
        }
        
        return result
    }
}

// - MARK: Specification
protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func fileter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T] where Spec.T == T
}

class ColorSpecification: Specification {
    typealias T = Product
    let color: Color
    init(color: Color) {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product
    let size: Size
    init(size: Size) {
        self.size = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<T, SpecA: Specification, SpecB: Specification>: Specification where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T {
    let first: SpecA
    let second: SpecB
    init(first: SpecA, second: SpecB) {
        self.first = first
        self.second = second
    }
    
    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

class BetterFilter: Filter {
    typealias T = Product
    
    func fileter<Spec: Specification>(_ items: [Product], _ spec: Spec) -> [T] where Spec.T == T {
        var result = [Product]()
        for i in items {
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }
        
        return result
    }
}
