//
//  WordListInteractor.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs

final class WordListInteractor: PresentableInteractor<WordListViewModellable>, WordListInteractable {

    private let wordListRepository: WordListRepository
    private let translationService: TranslationService

    private var data: WordListData = WordListData(wordList: [], changedItemPosition: nil) {
        didSet {
            viewModel?.wordListData = data
        }
    }

    private weak var viewModel: WordListViewModellable?

    init(viewModel: WordListViewModellable,
         wordListRepository: WordListRepository,
         translationService: TranslationService) {
        self.viewModel = viewModel
        self.wordListRepository = wordListRepository
        self.translationService = translationService
        super.init(presenter: viewModel)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchWordList()
        requestTranslationsIfNeeded()
    }

    // MARK: - WordListInteractable

    weak var router: WordListRouting?

    func remove(_ wordItem: WordItem, at position: Int) {
        var wordList = data.wordList

        wordList.remove(at: position)
        data = WordListData(wordList: wordList, changedItemPosition: position)
        wordListRepository.remove(with: wordItem.id, completion: nil)
    }

    func navigateToNewWord() {
        router?.routeToNewWord()
    }

    func navigateToSearch() {
        router?.routeToSearch()
    }

    // MARK: - NewWordListener

    func addNewWord(_ wordItem: WordItem) {
        var wordList = data.wordList

        wordList.append(wordItem)
        data = WordListData(wordList: wordList, changedItemPosition: nil)
        wordListRepository.add(wordItem, completion: nil)
        requestTranslation(for: wordItem, data.wordList.count - 1)
    }

    func dismissNewWord() {
        router?.hideNewWord()
    }

    // MARK: - Private

    private func fetchWordList() {
        data = WordListData(wordList: wordListRepository.wordList, changedItemPosition: nil)
    }

    private func requestTranslationsIfNeeded() {
        for position in 0..<data.wordList.count where data.wordList[position].translation == nil {
            requestTranslation(for: data.wordList[position], position)
        }
    }

    private func requestTranslation(for wordItem: WordItem, _ position: Int) {
        translationService.fetchTranslation(for: wordItem, { [weak self] result in
            switch result {
            case .success(let translation):
                self?.update(wordItem: wordItem, with: translation, at: position)
            case .failure:
                break
            }
        })
    }

    private func update(wordItem: WordItem, with translation: String, at position: Int) {
        let updatedWordItem = wordItem.update(translation: translation)
        var wordList = data.wordList

        guard position > -1 && position < wordList.count else { return }

        wordList[position] = updatedWordItem
        wordListRepository.update(updatedWordItem, completion: nil)
        data = WordListData(wordList: wordList, changedItemPosition: position)
    }
}
