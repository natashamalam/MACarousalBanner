//
//  CarousalViewModel.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/11.
//

import Foundation
import UIKit

class MACarousalViewModel {
    
    private(set) var datasource = MAChain<UIImage>()
    private(set) var currentChainNode: MAChainNode<UIImage>?
    
    init(_ images: [UIImage]) {
        allocateDataSource(images)
        if datasource.count() > 0 {
            currentChainNode = datasource.head
        }
    }
    
    func moveForward() -> MAChainNode<UIImage>? {
        if datasource.count() <= 0 {
            return nil
        }
        
        guard let nextNode = currentChainNode?.next else {
            currentChainNode = datasource.head
            return currentChainNode
        }
        self.currentChainNode = nextNode
        return nextNode
    }
    
    func moveBackward() {
        
    }
    
    func currentFocusedCarousalImage() -> UIImage? {
        return currentChainNode?.item
    }
    
    private func allocateDataSource(_ images: [UIImage]) {
        var count = 0
        while count < images.count {
            datasource.add(item: images[count])
            count += 1
        }
    }
}
