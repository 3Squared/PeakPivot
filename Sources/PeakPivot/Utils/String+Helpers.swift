//
//  String+Helpers.swift
//  PeakPivot
//
//  Created by Luke Stringer on 28/02/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

extension String {
    func splitIntoChunks(ofSize size: Int) -> [String] {
        let words = split(separator: " ")
        
        var scratch = ""
        var combined = [String]()
        for (index, word) in words.enumerated() {
            scratch.append("\(word) ")
            if scratch.count >= size {
                combined.append(" \(scratch)")
                scratch = ""
            }
            // If Last word
            if (index == words.count - 1 && scratch.count > 0) {
                combined.append(" \(scratch)")
            }
        }
        
        return combined.map { $0.trimmingCharacters(in: .whitespaces) }
    }
    
    func addLineBreaks(every wordLength: Int) -> String {
        return splitIntoChunks(ofSize: wordLength).joined(separator: "\n")
    }
}
