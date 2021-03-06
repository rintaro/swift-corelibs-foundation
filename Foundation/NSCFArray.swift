// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//


import CoreFoundation

internal final class _NSCFArray : NSMutableArray {
    deinit {
        _CFDeinit(self)
        _CFZeroUnsafeIvars(&_storage)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    required init(objects: UnsafePointer<AnyObject?>, count cnt: Int) {
        fatalError()
    }
    
    override var count: Int {
        return CFArrayGetCount(_cfObject)
    }
    
    override func objectAtIndex(_ index: Int) -> AnyObject {
        let value = CFArrayGetValueAtIndex(_cfObject, index)
        return unsafeBitCast(value, to: AnyObject.self)
    }
    
    override func insertObject(_ anObject: AnyObject, atIndex index: Int) {
        CFArrayInsertValueAtIndex(_cfMutableObject, index, unsafeBitCast(anObject, to: UnsafePointer<Void>.self))
    }
    
    override func removeObjectAtIndex(_ index: Int) {
        CFArrayRemoveValueAtIndex(_cfMutableObject, index)
    }
    
    override var classForCoder: AnyClass {
        return NSMutableArray.self
    }
}

internal func _CFSwiftArrayGetCount(_ array: AnyObject) -> CFIndex {
    return (array as! NSArray).count
}

internal func _CFSwiftArrayGetValueAtIndex(_ array: AnyObject, _ index: CFIndex) -> Unmanaged<AnyObject> {
    return Unmanaged.passUnretained((array as! NSArray).objectAtIndex(index))
}

internal func _CFSwiftArrayGetValues(_ array: AnyObject, _ range: CFRange, _ values: UnsafeMutablePointer<Unmanaged<AnyObject>?>) {
    for idx in 0..<range.length {
        let obj = (array as! NSArray).objectAtIndex(idx + range.location)
        values[idx] = Unmanaged.passUnretained(obj)
    }
}

internal func _CFSwiftArrayAppendValue(_ array: AnyObject, _ value: AnyObject) {
    (array as! NSMutableArray).addObject(value)
}

internal func _CFSwiftArraySetValueAtIndex(_ array: AnyObject, _ value: AnyObject, _ idx: CFIndex) {
    (array as! NSMutableArray).replaceObjectAtIndex(idx, withObject: value)
}

internal func _CFSwiftArrayReplaceValueAtIndex(_ array: AnyObject, _ idx: CFIndex, _ value: AnyObject) {
    (array as! NSMutableArray).replaceObjectAtIndex(idx, withObject: value)
}

internal func _CFSwiftArrayInsertValueAtIndex(_ array: AnyObject, _ idx: CFIndex, _ value: AnyObject) {
    (array as! NSMutableArray).insertObject(value, atIndex: idx)
}

internal func _CFSwiftArrayExchangeValuesAtIndices(_ array: AnyObject, _ idx1: CFIndex, _ idx2: CFIndex) {
    (array as! NSMutableArray).exchangeObjectAtIndex(idx1, withObjectAtIndex: idx2)
}

internal func _CFSwiftArrayRemoveValueAtIndex(_ array: AnyObject, _ idx: CFIndex) {
    (array as! NSMutableArray).removeObjectAtIndex(idx)
}

internal func _CFSwiftArrayRemoveAllValues(_ array: AnyObject) {
    (array as! NSMutableArray).removeAllObjects()
}

internal func _CFSwiftArrayReplaceValues(_ array: AnyObject, _ range: CFRange, _ newValues: UnsafeMutablePointer<Unmanaged<AnyObject>>, _ newCount: CFIndex) {
    NSUnimplemented()
//    (array as! NSMutableArray).replaceObjectsInRange(NSMakeRange(range.location, range.length), withObjectsFromArray: newValues.array(newCount))
}
