//
//  CacheManager.swift
//  PixabaySearch
//
//  Created by Andras Pal on 18/04/2021.
//

import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    
    var searchCache: Array< Dictionary<String, Array<ImageInfo>> > = []
    var imageCache: Array< Dictionary<Int, UIImage> > = []
    
    func updateSearchCache(searchString: String, searchResults: Array<ImageInfo>) {
        
        let searchCache = [searchString : searchResults]
        
        if self.searchCache.count == 10 {
            self.searchCache.remove(at: 0)
        }
        self.searchCache.append(searchCache)
    }
    
    func isImageInfoSaved(query: String) -> Bool {
        if searchCache.count > 0 {
            for item in 0..<searchCache.count {
                let item = searchCache[item]
                if item.keys.contains(query) {
                    return true
                }
            }
        }
        return false
    }
    
    func returnImageInfo(query: String) -> Array<ImageInfo> {
        
        var imageInfo: Array<ImageInfo> = []
        
        for idx in 0..<searchCache.count {
            let item = searchCache[idx]
            if item.keys.contains(query) {
                imageInfo = item[query] ?? []
            }
        }
        return imageInfo
    }
    
    func updateImageCache(imageId: Int, image: UIImage) {
        
        let imageCache = [imageId : image]
        
        if self.imageCache.count == 50 {
            self.imageCache.remove(at: 0)
        }
        self.imageCache.append(imageCache)
    }
    
    func isImageSaved(imageId: Int) -> Bool {
        if imageCache.count > 0 {
            for item in 0..<imageCache.count {
                let item = imageCache[item]
                if item.keys.contains(imageId) {
                    return true
                }
            }
        }
        return false
    }
    
    func returnImage(imageId: Int) -> UIImage {
        
        var image = UIImage()
        
        for idx in 0..<imageCache.count {
            let item = imageCache[idx]
            if item.keys.contains(imageId) {
                image = item[imageId] ?? UIImage()
            }
        }
        return image
    }
    
    private init() {}
}
