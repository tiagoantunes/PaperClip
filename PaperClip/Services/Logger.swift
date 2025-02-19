//
//  Logger.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

struct Logger {

    static func log(info: String) {
        #if !DEBUG
            return
        #endif

        let prefix = "ℹ️"
        print(prefix, info)
    }

    static func log(success: String) {
        #if !DEBUG
            return
        #endif

        let prefix = "👍"
        print(prefix, success)
    }

    static func log(error: String) {
        #if !DEBUG
            return
        #endif

        let prefix = "‼️"
        print(prefix, error)
    }
}
