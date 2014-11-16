//
//  SwiftTests.swift
//  MABlockClosureFramework
//
//  Created by Jason Markham on 11/15/14.
//  Copyright (c) 2014 Jason Markham. All rights reserved.
//

import Cocoa
import XCTest
import MABlockClosureFramework

class SwiftTests: XCTestCase {
    var called:Bool!
    override func setUp() {
        called = false
    }

    func testDoesItWork_SimpleCallback(){
        //without @objc_block : fatal error: can't unsafeBitCast between types of different sizes
        typealias SwiftCB = @objc_block()->Int32
        let callback:SwiftCB = {
            self.called = true
            return   32
        }
        //cannot downcast to non objc protocol...
        //let callbackAsAnyObj = callback as AnyObject
        let callbackAsAnyObj: AnyObject = unsafeBitCast(callback, AnyObject.self)
        
        let closure = MABlockClosure(block: callbackAsAnyObj)
        let fptr:UnsafeMutablePointer<Void> = closure.fptr
        let cptr = COpaquePointer(fptr)
        let myCallback:simpleCallback = CFunctionPointer<(() -> Int32)>(cptr)
        let result = test_simpleCallback(myCallback)
        
        XCTAssertEqual(Int32(32),result)
        assert(called)
    }
    
    func testDoesItWork_MoreRealistic(){
        typealias RealCallback = @objc_block(UserData, ProvidedToCallback, UnsafeMutablePointer<Void>) -> Int32
        let myClosure:RealCallback = {(user,extra,reserved)->Int32 in
            self.called=true
            return 32
        }
        
        let converter = MABlockClosure(block: unsafeBitCast(myClosure, AnyObject.self))
        let cptr = COpaquePointer(converter.fptr)
        //CFunctionPointer<((UserData, ProvidedToCallback, UnsafeMutablePointer<Void>) -> Int32)>
        let callback:MoreRealisticCallback = CFunctionPointer<(UserData,ProvidedToCallback,UnsafeMutablePointer<Void>)->Int32>(cptr)
        let selfOpaque =   Unmanaged.passUnretained(self).toOpaque()
        let selfPtr =  UnsafeMutablePointer<SwiftTests>(selfOpaque)
        let userData:UserData = UnsafeMutablePointer<Void>(selfPtr)
        let result = test_moreRealistic(callback, userData)
        
        XCTAssertEqual(Int32(32),result)
        assert(called)
        
    }
}
