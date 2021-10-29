//
//  WordListInteractable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListInteractable: Interactable, NewWordListener {

    var router: WordListRouting? { get set }

    var listener: WordListListener? { get set }

    func removeFromRepository(_ wordItem: WordItem)

    func navigateToNewWord()
}
