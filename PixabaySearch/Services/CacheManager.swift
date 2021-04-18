//
//  CacheManager.swift
//  PixabaySearch
//
//  Created by Andras Pal on 18/04/2021.
//

import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    
    var searchCacheArray: Array< Dictionary<String, Array<ImageInfo>> > = []
    
    func updateSearchCache(searchString: String, searchResults: Array<ImageInfo>) {
        
        let searchCache = [searchString : searchResults]
        
        if self.searchCacheArray.count == 10 {
            self.searchCacheArray.remove(at: 0)
        }
        self.searchCacheArray.append(searchCache)
    }
    
    func isImageInfoSaved(query: String) -> Bool {
        if searchCacheArray.count > 0 {
            for item in 0..<searchCacheArray.count {
                let item = searchCacheArray[item]
                if item.keys.contains(query) {
                    return true
                }
            }
        }
        return false
    }
    
    func returnImageInfo(query: String) -> Array<ImageInfo> {
        
        var imageInfo: Array<ImageInfo> = []
        
        for idx in 0..<searchCacheArray.count {
            let item = searchCacheArray[idx]
            if item.keys.contains(query) {
                imageInfo = item[query]!
            }
        }
        return imageInfo
    }
    
    private init() {}
}
