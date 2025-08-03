//
//  IrregularVerbs.swift
//  MVCLesson
//
//  Created by Кристина Олейник on 24.07.2025.
//

import Foundation

class IrregularVerbs {
    
    //Singleton
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
        addAllVerbs()
    }
    
    //MARK: - Properties
    var selectedVerbs: [Verb] = []
    
    private(set) var verbs: [Verb] = []
    
    //MARK: - Methods
    
    private func addAllVerbs() {
        verbs.forEach { verb in
            selectedVerbs.append(verb)
        }
    }
    
    private func configureVerbs() {
        verbs = [
            Verb(infinitive: "become", pastSimple: "became", participle: "become"),
            Verb(infinitive: "begin", pastSimple: "began", participle: "begun"),
            Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
            Verb(infinitive: "break", pastSimple: "broke", participle: "broken"),
            Verb(infinitive: "come", pastSimple: "came", participle: "come"),
            Verb(infinitive: "do", pastSimple: "did", participle: "done"),
            Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
            Verb(infinitive: "drink", pastSimple: "drank", participle: "drunk"),
            Verb(infinitive: "drive", pastSimple: "drove", participle: "driven"),
            Verb(infinitive: "give", pastSimple: "gave", participle: "given"),
            Verb(infinitive: "go", pastSimple: "went", participle: "gone"),
            Verb(infinitive: "grow", pastSimple: "grew", participle: "grown"),
            Verb(infinitive: "lose", pastSimple: "lost", participle: "lost"),
            Verb(infinitive: "make", pastSimple: "made", participle: "made"),
            Verb(infinitive: "meet", pastSimple: "met", participle: "met"),
            Verb(infinitive: "swim", pastSimple: "swam", participle: "swum"),
            Verb(infinitive: "take", pastSimple: "took", participle: "taken"),
            Verb(infinitive: "tell", pastSimple: "told", participle: "told"),
            Verb(infinitive: "win", pastSimple: "won", participle: "won"),
            Verb(infinitive: "write", pastSimple: "wrote", participle: "written")
        ]
    }
}

