//
//  Helpers.swift
//
//  Created by Md. Mehedi Hasan on 1/11/20.
//

import Foundation

class Helpers {
    
    class func generateHtml(content: String) -> String {
        let htmlStr = """
        <DOCTYPE HTML>
        <html lang='en'>
        <head>
            <meta charset='UTF-8'>
            <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
            <style> body {text-align: justify; margin: 6px 12px 6px 12px;} </style>
        </head>
        <body>
            \(content)
        </body>
        </html>
        """
        return htmlStr
    }
    
    class func generateHtml(content: String, header: String) -> String {
        let contentStr = """
            <h2>\(header)</h2>
            \(content)
            """
        return Helpers.generateHtml(content: contentStr)
    }
}
