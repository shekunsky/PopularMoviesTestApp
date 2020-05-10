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
                return "https://api.themoviedb.org/3/movie/popular?api_key=f2e5303a9c0817268cbce5beff650077&language=en-US&page="
            } else {
                return "https://api.themoviedb.org/3/movie/popular?api_key=f2e5303a9c0817268cbce5beff650077&language=en-US&page="
            }
        case .stage(let mode):
            if mode == ExecuteMode.test {
                return "https://api.themoviedb.org/3/movie/popular?api_key=f2e5303a9c0817268cbce5beff650077&language=en-US&page="
            } else {
                return "https://api.themoviedb.org/3/movie/popular?api_key=f2e5303a9c0817268cbce5beff650077&language=en-US&page="
            }
        case .production:
            return "https://api.themoviedb.org/3/movie/popular?api_key=f2e5303a9c0817268cbce5beff650077&language=en-US&page="
        }
    }
    
    var imagesURLAddress: String {
        switch self {
        case .development(let mode):
            if mode == ExecuteMode.test {
                return "https://image.tmdb.org/t/p/original"
            } else {
                return "https://image.tmdb.org/t/p/original"
            }
        case .stage(let mode):
            if mode == ExecuteMode.test {
                return "https://image.tmdb.org/t/p/original"
            } else {
                return "https://image.tmdb.org/t/p/original"
            }
        case .production:
            return "https://image.tmdb.org/t/p/original"
        }
    }
    
    var thumbnailURLAddress: String {
        switch self {
        case .development(let mode):
            if mode == ExecuteMode.test {
                return "https://image.tmdb.org/t/p/w200"
            } else {
                return "https://image.tmdb.org/t/p/w200"
            }
        case .stage(let mode):
            if mode == ExecuteMode.test {
                return "https://image.tmdb.org/t/p/w200"
            } else {
                return "https://image.tmdb.org/t/p/w200"
            }
        case .production:
            return "https://image.tmdb.org/t/p/w200"
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
