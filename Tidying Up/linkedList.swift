//
//  linkedList.swift
//  Tidying Up
//
//  Created by vincent Alvaro on 12/6/20.
//  Copyright © 2020 vincent Alvaro. All rights reserved.
//

import Foundation
import UIKit

//create a linked list node that is generic
class LLNode<T> {
    var value: T
    var next: LLNode<T>? = nil
    var prev: LLNode<T>? = nil
    
    init(value: T) {
        self.value = value
    }
}

class DoublyLinkedList<T> {
    var head: LLNode<T>? = nil
    var tail: LLNode<T>? = nil
    var size: Int = 0
    //append the node to the linked list
    func append(value: T) {
        // create new node
        let newNode = LLNode(value: value)

        // check if the there is a head
        guard self.head != nil else {
            // 3
            self.head = newNode
            self.tail = newNode
            self.size += 1
            return
        }
      
        // appedn the node to the tail
        self.tail?.next = newNode
        newNode.prev = self.tail
        self.tail = newNode
        
        // set array size to plus 1
        self.size += 1
    }
    public var count: Int {
      guard var node = head else {
        return 0
      }
    
      var count = 1
      while let next = node.next {
        node = next
        count += 1
      }
      return count
    }
    public func GetIndex(atIndex index: Int) -> LLNode<T> {
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil { //(*1)
                    break
                }
            }
            return node!
        }
    }
}
