//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/04/30.
//

/*
 インタフェース分離の法則：必要の内容部分を実装しないようにするメリットがある
 */
import Foundation

class Document {
    
}

protocol Machine {
    func print(d: Document)
    func scan(d: Document)
    func fax(d: Document)
}

// 複合機を実装 -> MachineプロトコルでOK
class MFP: Machine {
    func print(d: Document) {
        
    }
    
    func scan(d: Document) {
        
    }
    
    func fax(d: Document) {
        
    }
}

enum NoRequiredFunctionality: Error {
    case doesNotFax
    case doesNotScan
}

// bad
// プリント機能のみが欲しい -> Machineプロトコルだと余計な関数まで実装する必要がある
/*
class OldFashionedPrinter: Machine {
    func scan(d: Document) {
        <#code#>
    }
    
    func fax(d: Document) {
        <#code#>
    }
    
    func print(d: Document) {
        // ok
    }
    
    // Errorを投げて、対処する方法がある
    func fax(d: Document) throws {
        throw NoRequiredFunctionality.doesNotFax
    }
    
    func scan(d: Document) throws {
        throw NoRequiredFunctionality.doesNotScan
    }
}
*/

// インタフェース分離の法則を利用
protocol Printer {
    func print(d: Document)
}

protocol Scanner {
    func scan(d: Document)
}

protocol Fax {
    func fax(d: Document)
}

// 他の関数を実装する必要がなくなった
class OrdinaryPrinter: Printer {
    func print(d: Document) {
        // ok
    }
}

class Photocopier: Printer, Scanner {
    func print(d: Document) {
        // ok
    }
    
    func scan(d: Document) {
        // ok
    }
}

// プロトコルを利用して、新たなプロトコルを定義するのもOK
protocol MultiFunctionDeviceProtocol: Printer, Scanner, Fax {
    
}

class MultiFunctionDevice: Printer, Scanner, Fax {
    func print(d: Document) {
        // ok
    }
    
    func scan(d: Document) {
        // ok
    }
    
    func fax(d: Document) {
        // ok
    }
}

class MultiFunctionDevice2: MultiFunctionDeviceProtocol {
    let printer: Printer
    let scanner: Scanner
   
    init(printer: Printer, scanner: Scanner) {
        self.printer = printer
        self.scanner = scanner
    }
    
    func print(d: Document) {
        // ok
        // デコレーターパターンの利用
        printer.print(d: d)
    }
    
    func scan(d: Document) {
        // ok
    }
    
    func fax(d: Document) {
        // ok
    }
    
    
}
