//
//  OtherFile.swift
//  SomeStatLibrary
//
//  Created by bartoszp on 19/09/2022.
//

import Foundation

public class OtherType {
    public init() {
    }
    
    public func callTypeInStaticLib() {
        TypeInStaticLib().callFunction()
    }
}
