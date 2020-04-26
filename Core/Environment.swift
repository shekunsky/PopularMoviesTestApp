//
//  Environment.swift
//  Base-Project
//
//  Created by Alex2 on 20.04.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//
import Foundation

/// Enum is used to define on which backend target will point application
public enum Environment {
    case development(ExecuteMode)
    case stage(ExecuteMode)
    case production
    
    /// Target API url
    var baseURLAddress: String {
        switch self {
        case .development(let mode):
            if mode == ExecuteMode.test {
                return "http://[::1]:8080"
            } else {
                return "https://api.github.com"
            }
        case .stage(let mode):
            if mode == ExecuteMode.test {
                return "http://[::1]:8080"
            } else {
                return "https://api.github.com"
            }
        case .production:
            return "https://api.github.com"
        }
    }
    
    public enum ExecuteMode {
        case normal
        case test
    }
}

extension Environment.ExecuteMode{
    public var mode: String {
        switch self {
        case .normal:
            return "normalExecutionMode"
        case .test:
            return "testExecutionMode"
        }
    }
}
