//
//  WordListInteractor.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 28.10.2021.
//

import RIBs
import RxSwift

protocol WordListListener: AnyObject {
    // Declare methods the interactor can invoke to communicate with other RIBs.
}

final class WordListInteractor: PresentableInteractor<WordListViewModellable>, WordListInteractable {

    weak var router: WordListRouting?
    weak var listener: WordListListener?

    private let wordListRepository: WordListRepository
    private let translationService: TranslationService

    init(viewModel: WordListViewModellable,
         wordListRepository: WordListRepository,
         translationService: TranslationService) {
        self.wordListRepository = wordListRepository
        self.translationService = translationService
        super.init(presenter: viewModel)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchWordList()
        requestTranslationsIfNeeded()
    }

    override func willResignActive() {
        super.willResignActive()
        // Pause any business logic.
    }

    private func fetchWordList() {
        presenter.wordList = wordListRepository.wordList
    }

    func add(_ wordItem: WordItem) {
        let position = presenter.wordList.count

        presenter.add(wordItem)
        wordListRepository.add(wordItem, completion: nil)
        requestTranslation(for: wordItem, position)
    }

    func remove(wordItem: WordItem) {
        guard let position = presenter.wordList.firstIndex(where: { $0.id == wordItem.id }) else { return }

        presenter.remove(wordItem, position)
    }

    func removeFromRepository(_ wordItem: WordItem) {
        wordListRepository.remove(with: wordItem.id, completion: nil)
    }

    private func requestTranslationsIfNeeded() {
        let wordList = presenter.wordList

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
                self?.presenter.update(updatedWordItem, position)
            case .failure:
                break
            }
        })
    }
}
