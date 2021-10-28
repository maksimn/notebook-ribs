//
//  WordListViewModel.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

class WordListViewModel: WordListViewModellable {

    unowned let view: WordListView
    weak var interactor: WordListInteractable?

    private var previousWordCount = -1
    private var removedItemPosition = -1
    private var updatedItemPosition = -1

    init(view: WordListView) {
        self.view = view
    }

    func add(_ wordItem: WordItem) {
        wordList.append(wordItem)
    }

    func update(_ wordItem: WordItem, _ position: Int) {
        updatedItemPosition = position
        wordList[position] = wordItem
    }

    func remove(_ wordItem: WordItem, _ position: Int) {
        removedItemPosition = position
        wordList.remove(at: position)
        interactor?.removeFromRepository(wordItem)
    }

    func navigateToNewWord() {
    }

    func navigateToSearch() {
    }

    var wordList: [WordItem] = [] {
        willSet {
            previousWordCount = wordList.count
        }
        didSet {
            view.set(wordList: self.wordList)

            if wordList.count == previousWordCount - 1 {
                view.removeRowAt(removedItemPosition)
            } else if wordList.count == previousWordCount {
                view.updateRowAt(updatedItemPosition)
            } else if wordList.count == previousWordCount + 1 {
                view.addNewRowToList()
            } else {
                view.reloadList()
            }
        }
    }
}
