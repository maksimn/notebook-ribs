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

    func add(_ wordItem: WordItem) {
        wordList.append(wordItem)
    }

    func update(_ wordItem: WordItem, _ position: Int) {
        view.set(changedItemPosition: position)
        wordList[position] = wordItem
    }

    func remove(_ wordItem: WordItem, _ position: Int) {
        view.set(changedItemPosition: position)
        wordList.remove(at: position)
        interactor?.removeFromRepository(wordItem)
    }

    func navigateToNewWord() {
        interactor?.navigateToNewWord()
    }

    func navigateToSearch() {
    }

    var wordList: [WordItem] = [] {
        didSet {
            view.set(wordList: wordList)
        }
    }
}
