//
//  ViewController.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.09.2021.
//

import UIKit

class WordListViewController: UIViewController, WordListView {

    var viewModel: WordListViewModel?

    let params: WordListViewParams

    let searchBar = UISearchBar()
    let tableView = UITableView()
    let newWordButton = UIButton()
    let navigateToSearchButton = UIButton()

    lazy var tableDataSource: WordTableDataSource = {
        WordTableDataSource(tableView: tableView, wordList: [])
    }()

    lazy var tableActions: WordTableDelegate = {
        WordTableDelegate(onDeleteTap: { [weak self] position in
                            self?.onDeleteWordTap(position)
                          },
                          deleteActionViewParams: DeleteActionViewParams(
                            staticContent: params.staticContent.deleteAction,
                            styles: params.styles.deleteAction
                          )
        )
    }()

    init(params: WordListViewParams) {
        self.params = params
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    // MARK: - WordListView

    func set(changedItemPosition: Int) {
        tableDataSource.changedItemPosition = changedItemPosition
    }

    func set(wordList: [WordItem]) {
        tableDataSource.wordList = wordList
    }

    // MARK: - User Action Handlers

    @objc
    func onDeleteWordTap(_ position: Int) {
        let item = tableDataSource.wordList[position]

        viewModel?.remove(item, at: position)
    }

    @objc
    func onNewWordButtonTap() {
        viewModel?.navigateToNewWord()
    }

    @objc
    func onNavigateToSearchButtonTap() {
        viewModel?.navigateToSearch()
    }
}
