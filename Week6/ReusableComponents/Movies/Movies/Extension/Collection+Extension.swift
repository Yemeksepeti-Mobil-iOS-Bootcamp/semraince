//
//  Collection+Extension.swift
//  Movies
//
//  Created by Kerim Caglar on 7.08.2021.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {
    
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
