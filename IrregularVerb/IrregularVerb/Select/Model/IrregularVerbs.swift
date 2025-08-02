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
    }
    
    //MARK: - Properties
    var selectedVerbs: [Verb] = []
    
    private(set) var verbs: [Verb] = []
    
    //MARK: - Methods
    private func configureVerbs() {
        verbs = [
            Verb(infinitive: "be", pastSimple: "was/were", participle: "been"),
            Verb(infinitive: "become", pastSimple: "became", participle: "become"),
            Verb(infinitive: "begin", pastSimple: "began", participle: "begun"),
            Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
            Verb(infinitive: "break", pastSimple: "broke", participle: "broken"),
            Verb(infinitive: "bring", pastSimple: "brought", participle: "brought"),
            Verb(infinitive: "build", pastSimple: "built", participle: "built"),
            Verb(infinitive: "buy", pastSimple: "bought", participle: "bought"),
            Verb(infinitive: "catch", pastSimple: "caught", participle: "caught"),
            Verb(infinitive: "choose", pastSimple: "chose", participle: "chosen"),
            Verb(infinitive: "come", pastSimple: "came", participle: "come"),
            Verb(infinitive: "do", pastSimple: "did", participle: "done"),
            Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
            Verb(infinitive: "drink", pastSimple: "drank", participle: "drunk"),
            Verb(infinitive: "drive", pastSimple: "drove", participle: "driven"),
            Verb(infinitive: "eat", pastSimple: "ate", participle: "eaten"),
            Verb(infinitive: "fall", pastSimple: "fell", participle: "fallen"),
            Verb(infinitive: "feel", pastSimple: "felt", participle: "felt"),
            Verb(infinitive: "find", pastSimple: "found", participle: "found"),
            Verb(infinitive: "fly", pastSimple: "flew", participle: "flown"),
            Verb(infinitive: "forget", pastSimple: "forgot", participle: "forgotten"),
            Verb(infinitive: "get", pastSimple: "got", participle: "got/gotten"),
            Verb(infinitive: "give", pastSimple: "gave", participle: "given"),
            Verb(infinitive: "go", pastSimple: "went", participle: "gone"),
            Verb(infinitive: "grow", pastSimple: "grew", participle: "grown"),
            Verb(infinitive: "have", pastSimple: "had", participle: "had"),
            Verb(infinitive: "hear", pastSimple: "heard", participle: "heard"),
            Verb(infinitive: "hold", pastSimple: "held", participle: "held"),
            Verb(infinitive: "keep", pastSimple: "kept", participle: "kept"),
            Verb(infinitive: "know", pastSimple: "knew", participle: "known"),
            Verb(infinitive: "leave", pastSimple: "left", participle: "left"),
            Verb(infinitive: "lose", pastSimple: "lost", participle: "lost"),
            Verb(infinitive: "make", pastSimple: "made", participle: "made"),
            Verb(infinitive: "meet", pastSimple: "met", participle: "met"),
            Verb(infinitive: "pay", pastSimple: "paid", participle: "paid"),
            Verb(infinitive: "read", pastSimple: "read", participle: "read"),
            Verb(infinitive: "ride", pastSimple: "rode", participle: "ridden"),
            Verb(infinitive: "run", pastSimple: "ran", participle: "run"),
            Verb(infinitive: "say", pastSimple: "said", participle: "said"),
            Verb(infinitive: "see", pastSimple: "saw", participle: "seen"),
            Verb(infinitive: "sell", pastSimple: "sold", participle: "sold"),
            Verb(infinitive: "send", pastSimple: "sent", participle: "sent"),
            Verb(infinitive: "sing", pastSimple: "sang", participle: "sung"),
            Verb(infinitive: "sit", pastSimple: "sat", participle: "sat"),
            Verb(infinitive: "sleep", pastSimple: "slept", participle: "slept"),
            Verb(infinitive: "speak", pastSimple: "spoke", participle: "spoken"),
            Verb(infinitive: "stand", pastSimple: "stood", participle: "stood"),
            Verb(infinitive: "swim", pastSimple: "swam", participle: "swum"),
            Verb(infinitive: "take", pastSimple: "took", participle: "taken"),
            Verb(infinitive: "teach", pastSimple: "taught", participle: "taught"),
            Verb(infinitive: "tell", pastSimple: "told", participle: "told"),
            Verb(infinitive: "think", pastSimple: "thought", participle: "thought"),
            Verb(infinitive: "understand", pastSimple: "understood", participle: "understood"),
            Verb(infinitive: "wake", pastSimple: "woke", participle: "woken"),
            Verb(infinitive: "wear", pastSimple: "wore", participle: "worn"),
            Verb(infinitive: "win", pastSimple: "won", participle: "won"),
            Verb(infinitive: "write", pastSimple: "wrote", participle: "written")
        ]
    }
}

