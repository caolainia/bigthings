//
//  PPLog.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit

class PPLog: NSObject {
    private override init() {
        
    }
    
    /// print
    ///
    /// - Parameters:
    ///   - items: content
    ///   - file: file
    ///   - function: function
    ///   - line: line
    static func logger(items: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        print("""
            ------------------------------------PPLog Begin------------------------------------
            time:\t\(dateFormatter.string(from: Date()))
            fileName:\t\((file as NSString).lastPathComponent)
            line:\t\(line)
            functionName:\t\(function)
            content:\n\(items)
            ------------------------------------PPLog End---------------------------------------
            """)
        #endif
    }
    
    private static var dateFormatter: DateFormatter = {
        let object = DateFormatter()
        object.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return object
    }()
}
