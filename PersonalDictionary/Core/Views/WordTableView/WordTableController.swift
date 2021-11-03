//
//  WordTableController.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 05.10.2021.
//

import UIKit

struct DeleteActionViewParams {

    let staticContent: StaticContent
    let styles: Styles

    struct StaticContent {
        let image: UIImage
    }

    struct Styles {
        let backgroundColor: UIColor
    }
}

final class WordTableController: NSObject, UITableViewDataSource, UITableViewDelegate {

    var wordList: [WordItem]

    private let deleteActionViewParams: DeleteActionViewParams?
    private var onDeleteTap: ((Int) -> Void)?

    init(wordList: [WordItem],
         onDeleteTap: ((Int) -> Void)?,
         deleteActionViewParams: DeleteActionViewParams?) {
        self.wordList = wordList
        self.onDeleteTap = onDeleteTap
        self.deleteActionViewParams = deleteActionViewParams
        super.init()
    }

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

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let onDeleteTap = onDeleteTap,
              let deleteActionViewParams = deleteActionViewParams else {
            return nil
        }
        let deleteAction = UIContextualAction(style: .normal, title: "",
                                              handler: { (_, _, success: (Bool) -> Void) in
                                                onDeleteTap(indexPath.row)
                                                success(true)
                                              })

        deleteAction.image = deleteActionViewParams.staticContent.image
        deleteAction.backgroundColor = deleteActionViewParams.styles.backgroundColor

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
