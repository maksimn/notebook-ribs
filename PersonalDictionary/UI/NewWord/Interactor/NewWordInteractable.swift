//
//  NewWordInteractable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.10.2021.
//

import RIBs

protocol NewWordInteractable: Interactable {

    var listener: NewWordListener? { get set }

    var viewModel: NewWordViewModel? { get set }

    func save(sourceLang: Lang)

    func save(targetLang: Lang)

    func sendNewWord()

    func dismiss()
}
