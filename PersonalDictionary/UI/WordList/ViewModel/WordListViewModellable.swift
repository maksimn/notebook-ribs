//
//  WordListViewModellable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

protocol WordListViewModellable: AnyObject {

    var wordList: [WordItem] { get set }

    func add(_ wordItem: WordItem)

    func update(_ wordItem: WordItem, _ position: Int)

    func remove(_ wordItem: WordItem, _ position: Int)

    func navigateToNewWord()

    func navigateToSearch()
}
