//
//  NewWordView.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.09.2021.
//

protocol NewWordView: AnyObject {

    func set(allLangs: [Lang])

    func set(sourceLang: Lang)

    func set(targetLang: Lang)
}
