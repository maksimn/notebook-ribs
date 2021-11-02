//
//  NewWordInteractor.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 29.10.2021.
//

import RIBs
import RxSwift

protocol NewWordListener: AnyObject {
    // Declare methods the interactor can invoke to communicate with other RIBs.
    func addNewWord(_ wordItem: WordItem)

    func dismissNewWord()
}

final class NewWordInteractor: PresentableInteractor<NewWordViewModel>, NewWordInteractable {

    weak var router: NewWordRouting?
    weak var listener: NewWordListener?

    weak var viewModel: NewWordViewModel?

    private var langRepository: LangRepository

    // Add additional dependencies to constructor. Do not perform any logic in constructor.
    init(viewModel: NewWordViewModel, langRepository: LangRepository) {
        self.langRepository = langRepository
        self.viewModel = viewModel
        super.init(presenter: viewModel)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchData()
    }

    override func willResignActive() {
        super.willResignActive()
        // Pause any business logic.
    }

    private func fetchData() {
        viewModel?.allLangs = langRepository.allLangs
        viewModel?.sourceLang = langRepository.sourceLang
        viewModel?.targetLang = langRepository.targetLang
    }

    func save(sourceLang: Lang) {
        langRepository.sourceLang = sourceLang
    }

    func save(targetLang: Lang) {
        langRepository.targetLang = targetLang
    }

    func sendNewWord(_ text: String) {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty,
              let sourceLang = viewModel?.sourceLang,
              let targetLang = viewModel?.targetLang else {
            return
        }
        let wordItem = WordItem(text: text, sourceLang: sourceLang, targetLang: targetLang)

        listener?.addNewWord(wordItem)
    }

    func dismiss() {
        listener?.dismissNewWord()
    }
}
