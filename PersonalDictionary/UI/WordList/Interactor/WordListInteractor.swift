//
//  WordListInteractor.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs
import RxSwift

final class WordListInteractor: PresentableInteractor<WordListViewModellable>, WordListInteractable {

    private let wordListRepository: WordListRepository
    private let translationService: TranslationService

    private var wordList: [WordItem] = [] {
        didSet {
            viewModel?.wordList = wordList
        }
    }

    private var changedItemPosition: Int = -1 {
        didSet {
            viewModel?.changedItemPosition = changedItemPosition
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
        changedItemPosition = position
        wordList.remove(at: position)
        wordListRepository.remove(with: wordItem.id, completion: nil)
    }

    func navigateToNewWord() {
        router?.routeToNewWord()
    }

    func navigateToSearch() {

    }

    // MARK: - NewWordListener

    func addNewWord(_ wordItem: WordItem) {
        let position = wordList.count

        wordList.append(wordItem)
        wordListRepository.add(wordItem, completion: nil)
        requestTranslation(for: wordItem, position)
    }

    func dismissNewWord() {
        router?.hideNewWord()
    }

    // MARK: - Private

    private func fetchWordList() {
        wordList = wordListRepository.wordList
    }

    private func requestTranslationsIfNeeded() {
        for position in 0..<wordList.count where wordList[position].translation == nil {
            requestTranslation(for: wordList[position], position)
        }
    }

    private func requestTranslation(for wordItem: WordItem, _ position: Int) {
        translationService.fetchTranslation(for: wordItem, { [weak self] result in
            switch result {
            case .success(let translation):
                let updatedWordItem = wordItem.update(translation: translation)

                self?.wordListRepository.update(updatedWordItem, completion: nil)
                self?.changedItemPosition = position
                self?.wordList[position] = updatedWordItem
            case .failure:
                break
            }
        })
    }
}
