//
//  ProprietiesMirror.swift
//  correct42
//
//  Created by larry on 27/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

protocol PropertiesMirror {
	func propertyNames() -> [String]
	func propertyValue() -> [Any]
}

extension PropertiesMirror
{
	func propertyNames() -> [String] {
		return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
	}
	
	func propertyValue() -> [Any] {
		return Mirror(reflecting: self).children.filter { $0.value != nil }.map { $0.value }
	}
}

