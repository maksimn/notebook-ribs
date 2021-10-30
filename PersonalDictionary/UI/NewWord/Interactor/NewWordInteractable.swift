//
//  NewWordInteractable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.10.2021.
//

import RIBs

protocol NewWordInteractable: Interactable {

    var router: NewWordRouting? { get set }

    var listener: NewWordListener? { get set }

    var viewModel: NewWordViewModel? { get set }

    func save(sourceLang: Lang)

    func save(targetLang: Lang)

    func sendNewWord(_ text: String)

    func dismiss()
}
