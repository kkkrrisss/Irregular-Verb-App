//
//  Verb.swift
//  MVCLesson
//
//  Created by Кристина Олейник on 24.07.2025.
//

import Foundation

struct Verb {
    let infinitive: String
    let pastSimple: String
    let participle: String
    var translation: String {
        NSLocalizedString(self.infinitive, comment: "")
    }
}
