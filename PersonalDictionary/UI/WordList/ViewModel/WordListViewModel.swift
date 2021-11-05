//
//  WordListViewModel.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

class WordListViewModel: WordListViewModellable {

    unowned let view: WordListView
    weak var interactor: WordListInteractable?

    init(view: WordListView) {
        self.view = view
    }

    var wordList: [WordItem] = [] {
        didSet {
            view.set(wordList: wordList)
        }
    }

    var changedItemPosition: Int = -1 {
        didSet {
            view.set(changedItemPosition: changedItemPosition)
        }
    }

    func remove(_ wordItem: WordItem, at position: Int) {
        interactor?.remove(wordItem, at: position)
    }

    func navigateToNewWord() {
        interactor?.navigateToNewWord()
    }

    func navigateToSearch() {
        interactor?.navigateToSearch()
    }
}
