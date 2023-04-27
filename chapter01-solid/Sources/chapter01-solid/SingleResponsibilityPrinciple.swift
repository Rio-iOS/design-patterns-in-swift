//
//  File.swift
//  
//
//  Created by 藤門莉生 on 2023/04/27.
//

import Foundation

/*
 クラスは単一の責任 → 単一の変更理由を持つべきである
 */
class Journal: CustomStringConvertible {
    var entries = [String]()
    var count = 0
    
    func addEntry(_ text: String) -> Int {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }
    
    func removeEntry(_ index: Int) {
        entries.remove(at: index)
    }
    
    var description: String {
        return entries.joined(separator: "\n")
    }
   
    
    // 保存方法を変更した場合、Journalクラスに戻って色々と変更する必要がある
    // 単一責任原則は、永続性のようなものがある場合 → 別のクラスに移動させるべきである
    // Dialy（日記）クラスのようなものが出来た時に、save()を再度各必要が出てくるかもしれない → 重複になる
    func save(_ filename: String, _ overwrite: Bool = false) {
        // save to a file
    }
    
    func load(_ filename: String) {
        
    }
    
    func load(_ url: URL) {
        
    }
    
    
}

class Persistence {
    func saveToFile(_ journal: Journal, _ filename: String, overwrite: Bool = false) {
        
    }
}
