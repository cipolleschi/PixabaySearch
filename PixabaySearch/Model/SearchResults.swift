//
//  SearchResults.swift
//  PixabaySearch
//
//  Created by Andras Pal on 13/04/2021.
//

import Foundation

struct SearchResults<Object: Decodable> : Decodable {
    
    var hits: [Object]
}
