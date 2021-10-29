//
//  NewWordViewModel.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

protocol NewWordViewModel: AnyObject {

    var allLangs: [Lang] { get set }

    var sourceLang: Lang { get set }

    var targetLang: Lang { get set }

    func sendNewWord(_ text: String)
}
