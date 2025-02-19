//
//  WebViewURLModel.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import Foundation

struct WebViewURL: Identifiable, Equatable {

    let title: String
    let id = UUID()
    let url: URL
}
