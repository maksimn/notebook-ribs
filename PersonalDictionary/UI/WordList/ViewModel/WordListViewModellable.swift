//
//  WordListViewModellable.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

protocol WordListViewModellable: AnyObject {

    var wordListData: WordListData { get set }

    func remove(_ wordItem: WordItem, at position: Int)

    func navigateToNewWord()

    func navigateToSearch()
}
