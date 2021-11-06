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

    var wordListData: WordListData = WordListData(wordList: [], changedItemPosition: nil) {
        didSet {
            view.set(wordListData)
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
