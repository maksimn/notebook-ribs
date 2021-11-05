//
//  WordTableController.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 05.10.2021.
//

import UIKit

final class WordTableDataSource: NSObject, UITableViewDataSource {

    var changedItemPosition: Int = -1

    var wordList: [WordItem] {
        willSet {
            previousWordCount = wordList.count
        }
        didSet {
            updateTableView()
        }
    }

    private var previousWordCount = -1

    private unowned let tableView: UITableView

    init(tableView: UITableView,
         wordList: [WordItem]) {
        self.tableView = tableView
        self.wordList = wordList
        super.init()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wordList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(WordItemCell.self)",
                                                       for: indexPath) as? WordItemCell else {
            return UITableViewCell()
        }
        let wordItem = wordList[indexPath.row]

        cell.set(wordItem: wordItem)

        return cell
    }

    // MARK: - Private

    private func updateTableView() {
        if wordList.count == previousWordCount - 1 {
            guard changedItemPosition > -1 && changedItemPosition <= wordList.count else { return }

            tableView.deleteRows(at: [IndexPath(row: changedItemPosition, section: 0)], with: .automatic)
        } else if wordList.count == previousWordCount {
            guard changedItemPosition > -1 && changedItemPosition < wordList.count else { return }

            tableView.reloadRows(at: [IndexPath(row: changedItemPosition, section: 0)], with: .automatic)
        } else if wordList.count == previousWordCount + 1 {
            let count = wordList.count - 1

            tableView.insertRows(at: [IndexPath(row: count, section: 0)], with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
}
