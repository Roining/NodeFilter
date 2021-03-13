/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "TreeModel.h"
#include "TreeNode.h"
#include <QClipboard>
#include <QDataStream>
#include <QDebug>
#include <QGuiApplication>
#include <QRandomGenerator>
#include <QTime>
#include <iostream>
#include <string>

QDebug operator<<(QDebug debug, const TreeItem &c) {
  QDebugStateSaver saver(debug);
  debug.nospace() << '(' << c.itemData.get() << ", " << c.childItems.get()
                  << ')';

  return debug;
}

QDataStream &operator<<(QDataStream &out, TreeItem &item) {
  out << *item.itemData;
  out << item.numberOfChildren;
  out << item.id;
  out << item.acceptsCopies;
  out << item.tempParents;
  out << item.position;
  out << item.parents;
  out << item.copyChildren;

  return out;
}

QDataStream &operator>>(QDataStream &in, TreeItem *item) {
  in >> *item->itemData;
  in >> item->numberOfChildren; // TODO move out of class members
  in >> item->id;
  in >> item->acceptsCopies;
  in >> item->tempParents;
  in >> item->position;
  in >> item->parents;
  in >> item->copyChildren;
  return in;
}
// Q_INVOKABLE void TreeModel::dataChangedSignal() {
//    emit dataChanged()
//}
Q_INVOKABLE void TreeModel::deserialize(TreeItem &node, QDataStream &stream,
                                        bool check) {
  if (!check) { // if inserted node is not copied
    stream >> &node;

    if ((node.tempParents.size() > 1) &&
        (!check)) { // temp stores id's of parents.if more than 1 then node is
                    // copied further
      map.insert(
          node.id,
          &node); // corresponds id of not copied nodes to a pointer to the node
      for (int i = 0; i < node.tempParents.size(); i++) {

        container.insert(
            node.tempParents[i],
            node.id); // keys are parents, current item(to be copied) is value
      }

      auto cont = container.find(node.parentItem->id, node.id);

      if (!node.position.isEmpty()) {
      }
    }
  } else { // if node is copied
    stream >> &node;
  }

  for (int i = 0; i < node.numberOfChildren; i++) {

    if (container.value(node.id) ==
        QUuid()) { // if item is a not parent of a copied item

      deserialize(node.insertChildren2(i, 1, 0), stream);
    } else {
      TreeItem *check1 = nullptr;
      auto list = container.values(
          node.id); // list should contain id's of all potential children
      for (int j = 0; j < list.size(); j++) {

        auto ht = map.value(list[j])->position.keys();
        for (auto &item : map.value(list[j])->position.keys()) {

          if (item == node.id &&
              map.value(list[j])->position.values(item).contains(i)) {
            check1 = map.value(list[j]);

            break;
          }
        }
      }
      if (check1 != nullptr) {

        deserialize(node.insertChildren12(i, 1, 0, check1), stream, true);
      } else {

        auto score = map.value(container.value(node.id));
        deserialize(node.insertChildren2(i, 1, 0), stream);
      }
      check1 = nullptr;
    }
  }
  return;
}
void TreeModel::serialize2(TreeItem &node) {
  node.tempParents.clear();
  node.position.clear();
  node.numberOfChildren = node.childCount();
  if (node.childCount()) { // TODO replace with numberOfChildren?
    for (int i = 0; i < node.childCount(); i++) {

      serialize2(*node.children()[i]);
    }
  }
}

void TreeModel::serialize1(TreeItem &node) {

  if (node.siblingItems().size() > 1) {

    for (int i = 0; i < node.siblingItems().size(); i++) {

      node.tempParents.append(node.siblingItems()[i]->parentItem->id);
    }
  }
  if (node.siblingItems().size() > 1) { // TODO: repeats condition above?
    TreeItem *check = nullptr;
    for (int i = 0; i < node.siblingItems().size(); i++) {

      if (!(node.siblingItems()[i]->position.isEmpty())) {
        check = node.siblingItems()[i];
      }
    }
    if (check != nullptr) {
      check->position.insert(node.parentItem->id,
                             node.parent()->children().indexOf(&node));

    } else {
      node.position.insert(node.parentItem->id,
                           node.parent()->children().indexOf(&node));
    }
  }

  if (node.childCount()) { // TODO replace with numberOfChildren?
    for (int i = 0; i < node.childCount(); i++) {

      serialize1(*node.children()[i]);
    }
  }
}

Q_INVOKABLE void TreeModel::serialize(TreeItem &node, QDataStream &stream) {
  stream << node;

  if (node.childCount()) { // TODO replace with numberOfChildren?
    for (int i = 0; i < node.childCount(); i++) {

      serialize(*(node.children()[i]), stream);
    }
  }

  return;
}

Q_INVOKABLE void TreeModel::log() {
  QString path = "C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_"
                 "1_MinGW_64_bit-Debug\\debug\\";
  QFile file(QStringLiteral("%1\\storage.dat").arg(path));
  int value = QRandomGenerator::global()->generate();
  auto test =
      file.copy(QStringLiteral("%1\\storage.dat").arg(path),
                QStringLiteral("%1\\SavedFilesCache\\StorageCache%2.dat")
                    .arg(path)
                    .arg(value));
  if (file.open(QIODevice::WriteOnly | QIODevice::Truncate)) {
    QDataStream stream(&file);

    serialize2(*rootItem);
    serialize1(*rootItem);
    serialize(*rootItem, stream);
    file.close();
  }
}
//! [0]
TreeModel::TreeModel(QObject *parent) {

  QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_"
             "MinGW_64_bit-Debug\\debug\\storage.dat");
  if (file.open(QIODevice::ReadWrite)) {
    QDataStream stream(&file);

    QVector<QVariant> rootData;

    rootItem = new TreeItem(rootData, nullptr);
    deserialize(*rootItem, stream);

    file.close();
  }
}
// TreeModel::TreeModel(QObject *parent){

//    const QStringList headers({("Title")});
//      QFile
//      file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\default.txt");
//       file.open(QIODevice::ReadOnly);
//       const QString data = file.readAll();
////        TreeModel *model = new TreeModel(headers, file.readAll()); //TODO
/// clean this up

//    QVector<QVariant> rootData;
//    for (const QString &header : headers)
//        rootData << header;

//    rootItem = new TreeItem(rootData);
//    setupModelData(data.split('\n'), rootItem);

//    file.close();

//}
TreeModel::TreeModel(const QStringList &headers, const QString &data,
                     QObject *parent)
    : QAbstractItemModel(parent) {
  QVector<QVariant> rootData;
  for (const QString &header : headers)
    rootData << header;

  rootItem = new TreeItem(rootData);
  setupModelData(data.split('\n'), rootItem);
}
//! [0]

//! [1]
TreeModel::~TreeModel() { delete rootItem; }
//! [1]

//! [2]

QDataStream &operator>>(QDataStream &, TreeModel &);

int TreeModel::columnCount(const QModelIndex &parent) const {
  Q_UNUSED(parent);
  return rootItem->columnCount();
}
//! [2]

Q_INVOKABLE QVariant TreeModel::data(const QModelIndex &index, int role) const {
  if (!index.isValid())
    return QVariant();
  if (role == Qt::UserRole + 1) {
    auto item = getItem(index);
    return item->enabled;
  }
  if (role == Qt::UserRole + 2) {
    auto item1 = getItem(index);
    auto check = item1->id.toString();
    return item1->id.toString();
  }

  if (role != Qt::DisplayRole && role != Qt::EditRole)
    return QVariant();

  TreeItem *item = getItem(index);

  return item->data(index.column());
}

//! [3]
Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const {
  if (!index.isValid())
    return Qt::NoItemFlags;

  return Qt::ItemIsEditable | QAbstractItemModel::flags(index);
}
//! [3]

//! [4]
Q_INVOKABLE TreeItem *TreeModel::getItem(const QModelIndex &index) const {
  if (index.isValid()) {
    TreeItem *item = static_cast<TreeItem *>(index.internalPointer());
    if (item)
      return item;
  }
  return rootItem;
}
//! [4]

QVariant TreeModel::headerData(int section, Qt::Orientation orientation,
                               int role) const {
  if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
    return rootItem->data(section);

  return QVariant();
}

QModelIndex TreeModel::index(int row, int column,
                             const QModelIndex &parent) const {
  if (parent.isValid() && parent.column() != 0)
    return QModelIndex();

  TreeItem *parentItem = getItem(parent);
  if (!parentItem)
    return QModelIndex();

  TreeItem *childItem = parentItem->child(row);
  if (childItem)
    return createIndex(row, column, childItem);
  return QModelIndex();
}

bool TreeModel::isDescendantFromId(QUuid parent, QUuid child) {
  auto parentItem = map.value(parent);
  auto childItem = map.value(child);
  bool result;
  while (true) {
    if (childItem->parent() == nullptr) {
      result = false;
      return result;
    } else if ((childItem->parent() == parentItem) ||
               (childItem == parentItem)) {
      result = true;
      return result;
    } else {
      childItem = childItem->parent();
    }
  };
};
Q_INVOKABLE QString TreeModel::getId(const QModelIndex &index) {
  auto item = getItem(index);
  QString string = item->id.toString();
  return string;
}
Q_INVOKABLE bool TreeModel::hasMultipleSiblings(const QModelIndex &index) {
  auto item = getItem(index);
  if (item->siblingItems().size() > 1) {
    return true;

  } else {
    return false;
  }
}
Q_INVOKABLE void TreeModel::getIdToClipboard(const QModelIndex &index) {
  QClipboard *clipboardItem = QGuiApplication::clipboard();
  clipboardItem->setText(getId(index));
}

bool TreeModel::insertColumns(int position, int columns,
                              const QModelIndex &parent) {
  beginInsertColumns(parent, position, position + columns - 1);
  const bool success = rootItem->insertColumns(position, columns);
  endInsertColumns();
  return success;
}
Q_INVOKABLE QPersistentModelIndex TreeModel::getLastIndex() { return last; }
Q_INVOKABLE bool TreeModel::copyRows1(int position, int rows,
                                      const QModelIndex &parent,
                                      const QPersistentModelIndex &source) {
  TreeItem *parentItem = getItem(parent);

  if (!parentItem) {
    return false;
  }
  TreeItem *lastItem = getItem(source);
  lastItem = getItem(source);

  beginInsertRows(parent, position, position + rows - 1);
  TreeItem &success = parentItem->insertChildren1(
      position, rows, rootItem->columnCount(), lastItem);
  this->setData(index(position, 0, parent), "Data", Qt::UserRole + 2);

  endInsertRows();

  for (int i = 0; i < lastItem->childCount(); i++) {
    QPersistentModelIndex itemIndex = index(position, 0, parent);
    copyRows1(i, 1, itemIndex, index(i, 0, source));
  }

  return true; // TODO check for success of operation
}

void TreeModel::copyRows12(int position, QUuid callingId, QUuid calledId,
                           const QModelIndex &source) {

  auto siblingIndex = match(index(0, 0), Qt::UserRole + 2, calledId.toString(),
                            1, Qt::MatchRecursive);
  auto item = getItem(siblingIndex[0]);
  if (item->acceptsCopies) {
    copyRows1(position, 1, siblingIndex[0], source);
  }

  if ((!item->parents.isEmpty()) && (item->acceptsCopies)) {
    for (int i = 0; i < item->parents.size(); i++) {
      if (item->parents[i] != callingId) {
        copyRows12(position, calledId, item->parents[i], source);
      }
    }
  }

  if ((!item->copyChildren.isEmpty()) && (item->acceptsCopies)) {
    for (int i = 0; i < item->copyChildren.size(); i++) {
      if (item->copyChildren[i] != callingId) {
        copyRows12(position, calledId, item->copyChildren[i], source);
      }
    }
  }
  return;
}
Q_INVOKABLE bool TreeModel::copyRows(int position, int rows,
                                     const QModelIndex &parent,
                                     const QPersistentModelIndex &source) {
  TreeItem *parentItem = getItem(parent);
  auto lastItem = getItem(source);
  if (!parentItem) {
    return false;
  }
  if (isDescendant(lastItem, parentItem, true) && lastItem->childCount()) {
    qDebug() << "Parent item descends from inserted item";
    return false;
  }
  copyRows1(position, 1, parent, source);

  if (parentItem->acceptsCopies) {

    if ((!parentItem->parents.isEmpty()) && (parentItem->acceptsCopies)) {

      for (int i = 0; i < parentItem->parents.size(); i++) {

        copyRows12(position, parentItem->id, parentItem->parents[i],
                   index(position, 0, parent));
      }
    }

    if ((!parentItem->copyChildren.isEmpty()) && (parentItem->acceptsCopies)) {

      for (int i = 0; i < parentItem->copyChildren.size(); i++) {

        insertrowsRecursive(position, parentItem->id,
                            parentItem->copyChildren[i],
                            index(position, 0, parent));
      }
    }
  }

  // updateProxyFilter();
  return true;
}

Q_INVOKABLE void TreeModel::acceptsCopies(const QModelIndex &index,
                                          bool acceptsCopies) {
  auto item = getItem(index);
  item->acceptsCopies = acceptsCopies;
}
bool TreeModel::isDescendant(TreeItem *parent, TreeItem *child,
                             bool searchClones) {

  if (parent == child) {
    return true;
  } else if (searchClones) {
    if (*parent == *child) {
      return true;
    }
  }

  for (int i = 0; i < parent->childItems->size(); i++) {
    if (searchClones) {
      if (isDescendant((*parent->childItems.get())[i], child, true)) {
        return true;
      }

    } else {
      if (isDescendant((*parent->childItems.get())[i], child)) {
        return true;
      }
    }
  }

  return false;
};

TreeItem *TreeModel::isDescendant1(TreeItem *parent, TreeItem *child,
                                   bool searchClones) {

  if (*parent == *child) {

    return parent;
  } else if (searchClones) {
    if (*parent == *child) {

      return parent;
    }
  }

  for (int i = 0; i < parent->childItems->size(); i++) {
    if (searchClones) {

      if (isDescendant1((*parent->childItems.get())[i], child, true)) {
        return parent;
      }

    } else {
      auto item = isDescendant1((*parent->childItems.get())[i], child);
      if (item) {
        return item;
      }
      //             if(isDescendant1((*parent->childItems.get())[i],child)){
      //                 return child;
      //             }
    }
  }

  return nullptr;
};

bool TreeModel::insertRows(int position, int rows, const QModelIndex &parent) {

  TreeItem *parentItem = getItem(parent);
  if (!parentItem) {
    return false;
  }
  beginInsertRows(parent, position, position + rows - 1);

  parentItem->insertChildren(position, rows, rootItem->columnCount());
  const QModelIndex &child =
      this->index(position, 0, parent); // TODO swap this code for smth sane

  this->setData(child, "", Qt::EditRole);
  this->setData(child, "Data", Qt::UserRole + 2);
  endInsertRows();

  if (true) {

    if ((!parentItem->parents.isEmpty())) {

      for (int i = 0; i < parentItem->parents.size(); i++) {

        insertrowsRecursive(position, parentItem->id, parentItem->parents[i],
                            child);
      }
    }

    if ((!parentItem->copyChildren.isEmpty())) {

      for (int i = 0; i < parentItem->copyChildren.size(); i++) {

        insertrowsRecursive(position, parentItem->id,
                            parentItem->copyChildren[i], child);
      }
    }
  }

  // updateProxyFilter();
  return true; // TODO check for success of operation
}
Q_INVOKABLE void TreeModel::insertrowsRecursive(int position, QUuid callingId,
                                                QUuid calledId,
                                                const QModelIndex &child) {
  auto siblingIndex = match(index(0, 0), Qt::UserRole + 2, calledId.toString(),
                            1, Qt::MatchRecursive);
  auto item = getItem(siblingIndex[0]);
  if (item->acceptsCopies) {
    copyRows1(position, 1, siblingIndex[0], child);
  }

  if ((!item->parents.isEmpty()) && (item->acceptsCopies)) {

    for (int i = 0; i < item->parents.size(); i++) {
      if (item->parents[i] != callingId) {
        insertrowsRecursive(position, calledId, item->parents[i], child);
      }
    }
  }

  if ((!item->copyChildren.isEmpty()) && (item->acceptsCopies)) {

    for (int i = 0; i < item->copyChildren.size(); i++) {
      if (item->copyChildren[i] != callingId) {
        insertrowsRecursive(position, calledId, item->copyChildren[i], child);
      }
    }
  }
  return;
}
// Q_INVOKABLE bool TreeModel::insertRows1(int position, int rows,
//                                        const QModelIndex &parent,
//                                        bool transclusion) {
//  TreeItem *parentItem = getItem(parent);
//  if (!parentItem) {
//    return false;
//  }
//  beginInsertRows(parent, position, position + rows - 1);

//  parentItem->insertChildren(position, rows, rootItem->columnCount());
//  const QModelIndex &child =
//      this->index(position, 0, parent); // TODO swap this code for smth sane

//  this->setData(child, "", Qt::EditRole);
//  this->setData(child, "Data", Qt::UserRole + 2);
//  endInsertRows();

//  if (true) {

//    if ((!parentItem->parents.isEmpty())) {

//      for (int i = 0; i < parentItem->parents.size(); i++) {

//        insertRows12(position, parentItem->id, parentItem->parents[i], child);
//      }
//    }

//    if ((!parentItem->copyChildren.isEmpty())) {

//      for (int i = 0; i < parentItem->copyChildren.size(); i++) {

//        insertRows12(position, parentItem->id, parentItem->copyChildren[i],
//                     child);
//      }
//    }
//  }

//  // updateProxyFilter();
//  return true; // TODO check for success of operation
//}
//! [7]
Q_INVOKABLE QModelIndex TreeModel::parent(const QModelIndex &index) const {
  if (!index.isValid())
    return QModelIndex();

  TreeItem *childItem = getItem(index);
  TreeItem *parentItem = childItem ? childItem->parent() : nullptr;

  if (parentItem == rootItem || !parentItem)
    return QModelIndex();

  return createIndex(parentItem->childNumber(), 0, parentItem);
}
//! [7]

bool TreeModel::removeColumns(int position, int columns,
                              const QModelIndex &parent) {
  beginRemoveColumns(parent, position, position + columns - 1);
  const bool success = rootItem->removeColumns(position, columns);
  endRemoveColumns();

  if (rootItem->columnCount() == 0)
    removeRows(0, rowCount());

  return success;
}

void TreeModel::removeRows1(int position, QUuid callingId, QUuid calledId,
                            const QModelIndex &child) {

  auto siblingIndex = match(index(0, 0), Qt::UserRole + 2, calledId.toString(),
                            1, Qt::MatchRecursive);
  TreeItem *item;
  if (siblingIndex.isEmpty()) {
    siblingIndex.append(QModelIndex());
  }

  item = getItem(siblingIndex[0]);

  if (item->acceptsCopies) {

    beginRemoveRows(siblingIndex[0], position, position + 1 - 1);

    const bool success = item->removeChildren(position, 1);

    endRemoveRows();
  }

  if ((!item->parents.isEmpty()) && (item->acceptsCopies)) {

    if (item->parents[0] != callingId) {
      removeRows1(position, calledId, item->parents[0], child);
    }
  }

  if ((!item->copyChildren.isEmpty()) && (item->acceptsCopies)) {

    for (int i = 0; i < item->copyChildren.size(); i++) {
      if (item->copyChildren[i] != callingId) {
        removeRows1(position, calledId, item->copyChildren[i], child);
      }
    }
  }
  return;
}
Q_INVOKABLE int TreeModel::position(const QModelIndex &index) {
  auto item = getItem(index);
  auto parentItem = getItem(index.parent());

  for (int i = 0; i < parentItem->children().size(); i++) {

    if (parentItem->children()[i]->id == item->id) {
      return i;
    }
  }
}
Q_INVOKABLE bool TreeModel::removeRows(int position, int rows,
                                       const QModelIndex &parent) {
  TreeItem *parentItem = getItem(parent);
  if (!parentItem) {
    return false;
  }
  const QModelIndex &child = this->index(position, 0, parent);
  beginRemoveRows(parent, position, position + 1 - 1);

  const bool success = parentItem->removeChildren(position, 1);

  endRemoveRows();

  if ((!parentItem->parents.isEmpty())) {

    for (int i = 0; i < parentItem->parents.size(); i++) {

      removeRows1(position, parentItem->id, parentItem->parents[i], child);
    }
  }

  if ((!parentItem->copyChildren.isEmpty())) {

    for (int i = 0; i < parentItem->copyChildren.size(); i++) {

      removeRows1(position, parentItem->id, parentItem->copyChildren[i], child);
    }
  }
  // updateProxyFilter();
  return true;
}

//! [8]
int TreeModel::rowCount(const QModelIndex &parent) const {
  const TreeItem *parentItem = getItem(parent);

  return parentItem ? parentItem->childCount() : 0;
}
//! [8]

bool TreeModel::setData(const QModelIndex &index, const QVariant &value,
                        int role) {
  if (role == Qt::UserRole + 2) {
    TreeItem *item = getItem(index);
    if (item->id == QUuid()) {
      item->id = item->id.createUuid();
    }
    //           emit dataChanged(index, index,  {Qt::UserRole +2});
    return true;
  }

  if (role != Qt::EditRole)
    return false;

  TreeItem *item = getItem(index);
  bool result = item->setData(index.column(), value);

  if (result)

    emit dataChanged(index, index,
                     {Qt::DisplayRole, Qt::EditRole, Qt::UserRole + 2});

  return result;
}

bool TreeModel::setHeaderData(int section, Qt::Orientation orientation,
                              const QVariant &value, int role) {
  if (role != Qt::EditRole || orientation != Qt::Horizontal)
    return false;

  const bool result = rootItem->setData(section, value);

  if (result)
    emit headerDataChanged(orientation, section, section);

  return result;
}

QHash<int, QByteArray> TreeModel::roleNames() const {
  return {{Qt::DisplayRole, "display"},
          {Qt::EditRole, "edit"},
          {Qt::UserRole + 1, "enabled"},
          {Qt::UserRole + 2, "id"}};
}
void TreeModel::saveIndex(const QModelIndex &index) {

  last = index;
  return;
}

void TreeModel::setupModelData(const QStringList &lines, TreeItem *parent) {
  QVector<TreeItem *> parents;
  QVector<int> indentations;
  parents << parent;
  indentations << 0;

  int number = 0;

  while (number < lines.count()) {
    int position = 0;
    while (position < lines[number].length()) {
      if (lines[number].at(position) != ' ')
        break;
      ++position;
    }

    const QString lineData = lines[number].mid(position).trimmed();

    if (!lineData.isEmpty()) {
      // Read the column data from the rest of the line.
      const QStringList columnStrings =
          lineData.split(QLatin1Char('\t'), Qt::SkipEmptyParts);
      QVector<QVariant> columnData;
      columnData.reserve(columnStrings.size());
      for (const QString &columnString : columnStrings)
        columnData << columnString;

      if (position > indentations.last()) {
        // The last child of the current parent is now the new parent
        // unless the current parent has no children.

        if (parents.last()->childCount() > 0) {
          parents << parents.last()->child(parents.last()->childCount() - 1);
          indentations << position;
        }
      } else {
        while (position < indentations.last() && parents.count() > 0) {
          parents.pop_back();
          indentations.pop_back();
        }
      }

      // Append a new item to the current parent's list of children.
      TreeItem *parent = parents.last();
      parent->insertChildren(parent->childCount(), 1, rootItem->columnCount());
      for (int column = 0; column < columnData.size(); ++column)
        parent->child(parent->childCount() - 1)
            ->setData(column, columnData[column]);
    }
    ++number;
  }
}
