//
//  WordListInteractorTests.swift
//  PersonalDictionaryTests
//
//  Created by Maxim Ivanov on 06.11.2021.
//

@testable import PersonalDictionary
import Cuckoo
import XCTest

class WordListInteractorTests: XCTestCase {

    func test_navigateToNewWord_callsCorrectRouterMethod() throws {
        // Arrange:
        let routerMock = MockWordListRouting()
        let viewModelMock = MockWordListViewModellable()
        let wordListRepositoryMock = MockWordListRepository()
        let translationServiceMock = MockTranslationService()
        let interactor = WordListInteractor(viewModel: viewModelMock,
                                            wordListRepository: wordListRepositoryMock,
                                            translationService: translationServiceMock)
        interactor.router = routerMock

        stub(routerMock) { mock in
            when(mock.routeToNewWord()).then { _ in }
        }

        // Act:
        interactor.navigateToNewWord()

        // Assert:
        verify(routerMock).routeToNewWord()
    }
}
