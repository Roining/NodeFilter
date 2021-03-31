#include "include/ProxyModel.h"
#include "include/TreeModel.h"
#include "include/TreeNode.h"
#include <QRegularExpression>
#include <functional>

TreeModel myClass1(nullptr);

ProxyModel::ProxyModel(QObject *parent) : QSortFilterProxyModel(parent) {

  sourceModel = &myClass1;
  setSourceModel(&myClass1);
  setRecursiveFilteringEnabled(true);
  setDynamicSortFilter(false);
  QObject::connect(&myClass1, &TreeModel::updateProxyFilter, this,
                   &ProxyModel::updateFilter);
};
void ProxyModel::queryProcessing() {
  QStringList stringontainer1 = query.split("&&");
  itemContainer.clear();
  for (int i = 0; i < stringontainer1.size(); i++) {
    if (stringontainer1[i].startsWith(">") ||
        stringontainer1[i].startsWith("<")) {
      auto queryTrimmed = stringontainer1[i].section(":", -1);
      auto itemIndex =
          sourceModel->match(sourceModel->index(0, 0), Qt::UserRole + 2,
                             queryTrimmed, 1, Qt::MatchRecursive);
      if (!itemIndex.isEmpty()) {
        auto parentItem = sourceModel->getItem(itemIndex[0]);
        if (parentItem) {
          itemContainer.insert(queryTrimmed, parentItem);
        }
      }
    }
  }
}
bool ProxyModel::filterAcceptsRow(int source_row,
                                  const QModelIndex &source_parent) const {
  QModelIndex index = sourceModel->index(source_row, 0, source_parent);
  TreeNode *currentItem = sourceModel->getItem(index);

  if (!queryChanged) {
    return true;
  }
  if (query == "") {
    currentItem->setVisible(true);
    return true;
  }

  QStringList container = query.split("&&");

  bool finalResult = true;
  for (int i = 0; i < container.size(); i++) {
    int depth = 999;
    bool innerResult = true;

    if (container[i].startsWith("r:")) {
      auto string = container[i].mid(2);
      QRegularExpression regex(string);
      QRegularExpressionMatch match =
          regex.match(sourceModel->data(index, 0).toString());
      if (!match.hasMatch()) {
        currentItem->setVisible(false);
        return false;
      }
    } else if (container[i].startsWith("NOT") ||
               container[i].startsWith("OR")) {
      continue;
    }

    else if (container[i].startsWith(">")) {

      auto query1 = container[i].section(":", -1);
      auto depthIndex = container[i].indexOf(":");

      if (container[i][depthIndex - 1].digitValue() != -1) {
        depth = container[i][depthIndex - 1].digitValue();
      }

      auto queryId = itemContainer.value(query1);
      if (!queryId) {
        currentItem->setVisible(false);
        return false;
      }
      if (!queryId->siblingItems().size()) {
        return false;
      }

      if (container[i].startsWith(">>")) {
        //        innerResult = sourceModel->isDescendant(queryId,
        //        currentItem,depth, true);
        innerResult = false;
        for (int i = 0; i < queryId->siblingItems().size(); i++) {
          if (sourceModel->isDescendant(queryId->siblingItems()[i], currentItem,
                                        depth, true)) {
            innerResult = true;
            break;
          }
        }

      } else {
        innerResult = sourceModel->isDescendant(queryId, currentItem, depth);
      }
      bool isInclusive = i > 0 && container[i - 1] == "OR";
      bool isInversed = i > 0 && container[i - 1] == "NOT";

      if (innerResult) {
        if (isInclusive) {
          currentItem->setVisible(true);
          return true;
        }
        if (isInversed) {
          currentItem->setVisible(false);
          return false;
        }
      } else {
        if (isInclusive) {
          finalResult = false;
        }

        if (!isInversed && !isInclusive) {

          currentItem->setVisible(false);
          return false;
        }
      }
    } else if (container[i].startsWith("<")) {
      auto query1 = container[i].section(":", -1);
      auto queryId = itemContainer.value(query1);
      if (!queryId) {
        currentItem->setVisible(false);
        return false;
      }

      if (container[i].startsWith("<<")) {
        innerResult =
            sourceModel->isDescendant(currentItem, queryId, depth, true);
      } else {
        innerResult = sourceModel->isDescendant(currentItem, queryId, depth);
      }
      bool isInclusive = i > 0 && container[i - 1] == "OR";
      bool isInversed = i > 0 && container[i - 1] == "NOT";

      if (innerResult) {
        if (isInclusive) {
          currentItem->setVisible(true);
          return true;
        }
        if (isInversed) {
          currentItem->setVisible(false);
          return false;
        }
      } else {
        if (isInclusive) {
          finalResult = false;
        }

        if (!isInversed && !isInclusive) {

          currentItem->setVisible(false);
          return false;
        }
      }
    } else {
      auto trimmedQuery = container[i].section(":", -1);

      QStringList words = trimmedQuery.split(QRegExp("\\s"));

      auto string = container[i].mid(2);

      bool result = false;
      bool contains = false;
      for (int i = 0; i < words.size(); i++) {
        if (currentItem->item().toString().contains(words[i],
                                                    Qt::CaseInsensitive)) {
          contains = true;
        }
      }
      if (contains == true) {
        for (int i = 0; i < words.size(); i++) {
          TreeNode *itemPtr = currentItem;
          while (true) {

            if ((((itemPtr)->item().toString().contains(
                    words[i], Qt::CaseInsensitive)))) {
              result = true;
              break;
            } else if (!itemPtr->parent()) {
              result = false;
              break;

            } else {
              itemPtr = itemPtr->parent();
            }
          }
          if (result == false) {
            break;
          }
        }
      }
      innerResult = result;

      bool isInclusive = i > 0 && container[i - 1] == "OR";
      bool isInversed = i > 0 && container[i - 1] == "NOT";

      if (innerResult) {
        if (isInclusive) {
          currentItem->setVisible(true);
          return true;
        }
        if (isInversed) {
          currentItem->setVisible(false);
          return false;
        }
      } else {
        if (isInclusive) {
          finalResult = false;
        }

        if (!isInversed && !isInclusive) {

          currentItem->setVisible(false);
          return false;
        }
      }
    }
  }
  currentItem->setVisible(finalResult);
  return finalResult;
  return true;
};
Q_INVOKABLE void ProxyModel::setQuery(QString string) {
  query = string;
  queryProcessing();

  if (query.contains("sort")) {
    sort(0);
  } else {
    sort(-1);
  }
  sourceModel->updateProxyFilter(true);
  invalidateFilter();

  return;
}
Q_INVOKABLE void ProxyModel::queryIsChanged(bool condition) {
  queryChanged = condition;
}
