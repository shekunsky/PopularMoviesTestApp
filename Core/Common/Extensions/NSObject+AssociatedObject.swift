//
//  NSObject+AssociatedObject.swift
//  Core
//
//  Created by Alex2 on 26.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation

public enum AssociationPolicy {
    case assign
    case retainNonatomic
    case copyNonatomic
    case retain
    case copy
    fileprivate var rawValue: objc_AssociationPolicy {
        switch self {
        case .assign: return .OBJC_ASSOCIATION_ASSIGN
        case .retainNonatomic: return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        case .copyNonatomic: return .OBJC_ASSOCIATION_COPY_NONATOMIC
        case .retain: return .OBJC_ASSOCIATION_RETAIN
        case .copy: return .OBJC_ASSOCIATION_COPY
        }
    }
}

public extension NSObject {
    func setAssociatedObject<T>(value: T, key: UnsafeRawPointer, policy: AssociationPolicy) {
        objc_setAssociatedObject(self, key, value as AnyObject, policy.rawValue)
    }
    func getAssociatedObject<T>(key: UnsafeRawPointer) -> T? {
        return (objc_getAssociatedObject(self, key) as AnyObject) as? T
    }
    func removeAssociatedObject(key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, nil, AssociationPolicy.retain.rawValue)
    }
}
