//
//  WordListInteractable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

protocol WordListInteractable: Interactable, NewWordListener {

    var router: WordListRouting? { get set }

    func remove(_ wordItem: WordItem, at position: Int)

    func navigateToNewWord()

    func navigateToSearch()
}
