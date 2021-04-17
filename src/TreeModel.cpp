#include "include/TreeModel.h"
#include "include/TreeNode.h"
#include <QClipboard>
#include <QDataStream>
#include <QDebug>
#include <QDir>
#include <QElapsedTimer>
#include <QGuiApplication>
#include <QRandomGenerator>
TreeModel::TreeModel(QObject *parent) {

  QDir::setCurrent(QDir::currentPath());
  QFile file("storage.dat");
  if (file.open(QIODevice::ReadWrite)) {
    QDataStream stream(&file);
    QVector<QVariant> rootData;

    rootItem = new TreeNode(rootData, nullptr);
    deserialize(*rootItem, stream);
    if (!rootItem->childCount()) {
      beginInsertRows(QModelIndex().parent(), 0, 1);
      rootItem->itemData.get()->append("data");
      endInsertRows();
      insertRows(0, 1, QModelIndex());
    }
    file.close();
  }
}

TreeModel::TreeModel(const QStringList &headers, const QString &data,
                     QObject *parent)
    : QAbstractItemModel(parent) {
  QVector<QVariant> rootData;
  for (const QString &header : headers)
    rootData << header;

  rootItem = new TreeNode(rootData);
  setupModelData(data.split('\n'), rootItem);
}

TreeModel::~TreeModel() { delete rootItem; }

QDataStream &operator>>(QDataStream &, TreeModel &);
QDebug operator<<(QDebug debug, const TreeNode &c) {
  QDebugStateSaver saver(debug);

  return debug;
}

QDataStream &operator<<(QDataStream &out, TreeNode &item) {
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

QDataStream &operator>>(QDataStream &in, TreeNode *item) {
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
QVariant TreeModel::data(const QModelIndex &index, int role) const {
  if (!index.isValid())
    return QVariant();
  if (role == Qt::UserRole + 1) {
    auto item = getItem(index);
    return item->isVisible;
  }
  if (role == Qt::UserRole + 2) {
    auto item1 = getItem(index);
    auto check = item1->id.toString();
    return item1->id.toString();
  }

  if (role != Qt::DisplayRole && role != Qt::EditRole)
    return QVariant();

  TreeNode *item = getItem(index);

  return item->data(index.column());
}
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

  TreeNode *parentItem = getItem(parent);
  if (!parentItem)
    return QModelIndex();

  TreeNode *childItem = parentItem->child(row);
  if (childItem)
    return createIndex(row, column, childItem);
  return QModelIndex();
}
QModelIndex TreeModel::parent(const QModelIndex &index) const {
  if (!index.isValid())
    return QModelIndex();

  TreeNode *childItem = getItem(index);
  TreeNode *parentItem = childItem ? childItem->parent() : nullptr;

  if (parentItem == rootItem || !parentItem)
    return QModelIndex();

  return createIndex(parentItem->childNumber(), 0, parentItem);
}
int TreeModel::rowCount(const QModelIndex &parent) const {
  const TreeNode *parentItem = getItem(parent);

  return parentItem ? parentItem->childCount() : 0;
}

int TreeModel::columnCount(const QModelIndex &parent) const { return 1; }
Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const {
  if (!index.isValid())
    return Qt::NoItemFlags;

  return Qt::ItemIsEditable | QAbstractItemModel::flags(index);
}
bool TreeModel::setData(const QModelIndex &index, const QVariant &value,
                        int role) {

  if (role == Qt::UserRole + 2) {
    TreeNode *item = getItem(index);
    if (item->id == QUuid()) {
      item->id = item->id.createUuid();
    }
    emit dataChanged(index, index, {Qt::UserRole + 2});
    return true;
  }

  if (role != Qt::EditRole)
    return false;

  TreeNode *item = getItem(index);
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
bool TreeModel::insertColumns(int position, int columns,
                              const QModelIndex &parent) {
  beginInsertColumns(parent, position, position + columns - 1);
  const bool success = rootItem->insertColumns(position, columns);
  endInsertColumns();
  return success;
}
bool TreeModel::removeColumns(int position, int columns,
                              const QModelIndex &parent) {
  beginRemoveColumns(parent, position, position + columns - 1);
  const bool success = rootItem->removeColumns(position, columns);
  endRemoveColumns();

  if (rootItem->columnCount() == 0)
    removeRows(0, rowCount());

  return success;
}
bool TreeModel::insertRows(int position, int rows, const QModelIndex &parent) {
  updateProxyFilter(false);
  TreeNode *parentItem = getItem(parent);
  if (!parentItem) {
    return false;
  }

  beginInsertRows(parent, position, position + rows - 1);

  parentItem->insertChildren(position, rows, rootItem->columnCount());

  const QModelIndex &child = this->index(position, 0, parent);

  this->setData(child, "", Qt::EditRole);
  this->setData(child, "Data", Qt::UserRole + 2);

  endInsertRows();

  if ((!parentItem->parents.isEmpty())) {

    for (int i = 0; i < parentItem->parents.size(); i++) {

      insertRowsRecursive(position, parentItem->id, parentItem->parents[i],
                          child);
    }
  }

  if ((!parentItem->copyChildren.isEmpty())) {

    for (int i = 0; i < parentItem->copyChildren.size(); i++) {

      insertRowsRecursive(position, parentItem->id, parentItem->copyChildren[i],
                          child);
    }
  }

  updateProxyFilter(true);

  return true; // TODO check for success of operation
}
void TreeModel::insertRowsRecursive(int position, QUuid callingId,
                                    QUuid calledId, const QModelIndex &child) {
  //  QElapsedTimer timer;
  //  timer.start();

  auto siblingIndex = match(index(0, 0), Qt::UserRole + 2, calledId.toString(),
                            1, Qt::MatchRecursive);
  //  qDebug() << timer.elapsed();

  auto item = getItem(siblingIndex[0]);
  if (item->acceptsCopies) {
    copyRowsAndChildren(position, 1, siblingIndex[0], child);
  }

  if ((!item->parents.isEmpty()) && (item->acceptsCopies)) {

    for (int i = 0; i < item->parents.size(); i++) {
      if (item->parents[i] != callingId) {
        insertRowsRecursive(position, calledId, item->parents[i], child);
      }
    }
  }

  if ((!item->copyChildren.isEmpty()) && (item->acceptsCopies)) {

    for (int i = 0; i < item->copyChildren.size(); i++) {
      if (item->copyChildren[i] != callingId) {
        insertRowsRecursive(position, calledId, item->copyChildren[i], child);
      }
    }
  }
  return;
}

bool TreeModel::removeRows(int position, int rows, const QModelIndex &parent) {
  updateProxyFilter(false);

  TreeNode *parentItem = getItem(parent);
  if (!parentItem) {
    return false;
  }
  if ((!parentItem->parentItem) && (parentItem->childCount() < 2)) {
    return false;
  }
  const QModelIndex &child = this->index(position, 0, parent);
  beginRemoveRows(parent, position, position + 1 - 1);

  const bool success = parentItem->removeChildren(position, 1);

  endRemoveRows();

  if ((!parentItem->parents.isEmpty())) {

    for (int i = 0; i < parentItem->parents.size(); i++) {

      removeRowsRecursive(position, parentItem->id, parentItem->parents[i],
                          child);
    }
  }

  if ((!parentItem->copyChildren.isEmpty())) {

    for (int i = 0; i < parentItem->copyChildren.size(); i++) {

      removeRowsRecursive(position, parentItem->id, parentItem->copyChildren[i],
                          child);
    }
  }

  updateProxyFilter(true);

  return true;
}

void TreeModel::removeRowsRecursive(int position, QUuid callingId,
                                    QUuid calledId, const QModelIndex &child) {

  auto siblingIndex = match(index(0, 0), Qt::UserRole + 2, calledId.toString(),
                            1, Qt::MatchRecursive);
  TreeNode *item;
  if (siblingIndex.isEmpty()) {
    siblingIndex.append(QModelIndex());
  }

  item = getItem(siblingIndex[0]);

  if (item->acceptsCopies) {
    if (item->childCount() && item->childCount() > position) {
      if (*item->children()[position] == *getItem(child)) {
        beginRemoveRows(siblingIndex[0], position, position + 1 - 1);

        const bool success = item->removeChildren(position, 1);

        endRemoveRows();
      }
    }
  }

  if ((!item->parents.isEmpty()) && (item->acceptsCopies)) {

    if (item->parents[0] != callingId) {
      removeRowsRecursive(position, calledId, item->parents[0], child);
    }
  }

  if ((!item->copyChildren.isEmpty()) && (item->acceptsCopies)) {

    for (int i = 0; i < item->copyChildren.size(); i++) {
      if (item->copyChildren[i] != callingId) {
        removeRowsRecursive(position, calledId, item->copyChildren[i], child);
      }
    }
  }
  return;
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
void TreeModel::save() {
  QDir::setCurrent(QDir::currentPath());
  QString path = QDir::currentPath();
  QFile file("storage.dat");
  int value = QRandomGenerator::global()->generate();

  QDir cachePath(QStringLiteral("%1/StorageCache").arg(path));
  if (!cachePath.exists()) {
    cachePath.mkdir(QStringLiteral("%1/StorageCache").arg(path));
  }
  auto isSuccessful =
      file.copy(QStringLiteral("%1/storage.dat").arg(path),
                QStringLiteral("%1/StorageCache/StorageCache%2.dat")
                    .arg(path)
                    .arg(value));
  if (file.open(QIODevice::WriteOnly | QIODevice::Truncate)) {
    QDataStream stream(&file);
    serializeClear(*rootItem);
    serializeCleanUp(*rootItem);
    serialize(*rootItem, stream);
    file.close();
  }
}
QPersistentModelIndex TreeModel::getLastIndex() { return last; }
bool TreeModel::isDescendant(TreeNode *parent, TreeNode *child, int depth,
                             bool searchClones) {
  if (depth == 0) {
    return false;
  }
  if (parent == child) {
    return true;
  } else if (searchClones) {
    if (*parent == *child) {
      return true;
    }
  }

  for (int i = 0; i < parent->childItems->size(); i++) {
    if (searchClones) {
      if (isDescendant((*parent->childItems.get())[i], child, depth - 1,
                       true)) {
        return true;
      }

    } else {
      if (isDescendant((*parent->childItems.get())[i], child, depth - 1)) {
        return true;
      }
    }
  }

  return false;
};
TreeNode *TreeModel::isDescendant1(TreeNode *parent, TreeNode *child) {

  if (*parent == *child) {
    return child;
  }

  for (int i = 0; i < parent->childItems->size(); i++) {
    auto match = isDescendant1((*parent->childItems.get())[i], child);

    if (match) {
      return match;
    }
  }

  return nullptr;
};
TreeNode *TreeModel::getItem(const QModelIndex &index) const {
  if (index.isValid()) {
    TreeNode *item = static_cast<TreeNode *>(index.internalPointer());
    if (item)
      return item;
  }
  return rootItem;
}
void TreeModel::serialize(TreeNode &node, QDataStream &stream) {
  stream << node;

  if (node.childCount()) {
    for (int i = 0; i < node.childCount(); i++) {

      serialize(*(node.children()[i]), stream);
    }
  }

  return;
}
void TreeModel::serializeCleanUp(TreeNode &node) {

  if (node.siblingItems().size() > 1) {

    for (int i = 0; i < node.siblingItems().size(); i++) {

      node.tempParents.append(node.siblingItems()[i]->parentItem->id);
    }
  }
  if (node.siblingItems().size() > 1) {
    TreeNode *check = nullptr;
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

  if (node.childCount()) {
    for (int i = 0; i < node.childCount(); i++) {

      serializeCleanUp(*node.children()[i]);
    }
  }
}
void TreeModel::serializeClear(TreeNode &node) {
  node.tempParents.clear();
  node.position.clear();
  node.numberOfChildren = node.childCount();
  if (node.childCount()) {
    for (int i = 0; i < node.childCount(); i++) {

      serializeClear(*node.children()[i]);
    }
  }
}
void TreeModel::deserialize(TreeNode &node, QDataStream &stream, bool check) {
  if (!check) { // if inserted node is not copied
    stream >> &node;

    if ((node.tempParents.size() > 1) &&
        (!check)) { // temp stores ids of parents.if more than 1 then node is
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
        QUuid()) { // if node is a not parent of a copied item

      deserialize(node.insertChildrenNew(i, 1, 0), stream);
    } else {
      TreeNode *check1 = nullptr;
      auto list = container.values(
          node.id); // list should contain ids of all potential children
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

        deserialize(node.insertChildrenSerialization(i, 1, 0, check1), stream,
                    true);
      } else {

        auto score = map.value(container.value(node.id));
        deserialize(node.insertChildrenNew(i, 1, 0), stream);
      }
      check1 = nullptr;
    }
  }
  return;
}

bool TreeModel::copyRows(int position, int rows, const QModelIndex &parent,
                         const QPersistentModelIndex &source) {
  updateProxyFilter(false);
  TreeNode *parentItem = getItem(parent);
  auto lastItem = getItem(source);
  if (!parentItem) {
    return false;
  }
  //  if ((isDescendant(lastItem, parentItem, 1000, true) &&
  //       lastItem->childCount()) ||
  //      ((*parentItem == *lastItem) && (lastItem->acceptsCopies))) {
  //    emit recurionSignal();
  //    return false;
  //  }

  copyRowsAndChildren(position, 1, parent, source);

  if (parentItem->acceptsCopies && parentItem->siblingItems().size() < 2000) {
    for (int i = 0; i < parentItem->copyChildren.size(); i++) {
      if (parentItem->copyChildren[i] != parentItem->id) {
      }
    }

    if ((!parentItem->copyChildren.isEmpty()) && (parentItem->acceptsCopies)) {

      for (int i = 0; i < parentItem->copyChildren.size(); i++) {
        //        if (parentItem->copyChildren[i] != parentItem->id) {
        copyRowsRecursive(position, parentItem->id, parentItem->copyChildren[i],
                          index(position, 0, parent));
        //        }
      }
    }

    if ((!parentItem->parents.isEmpty()) && (parentItem->acceptsCopies)) {

      for (int i = 0; i < parentItem->parents.size(); i++) {
        //        if (parentItem->parents[i] != parentItem->id) {
        copyRowsRecursive(position, parentItem->id, parentItem->parents[i],
                          index(position, 0, parent));
        //        }
      }
    }
  }
  updateProxyFilter(true);

  return true;
}

bool TreeModel::copyRowsAndChildren(int position, int rows,
                                    const QModelIndex &parent,
                                    const QPersistentModelIndex &source) {
  TreeNode *parentItem = getItem(parent);

  if (!parentItem) {
    return false;
  }
  TreeNode *lastItem = getItem(source);
  //  lastItem = getItem(source);
  if (isDirectDescendant1(lastItem, parentItem, 1000)) {
    return false;
  }

  if (lastItem == parentItem) {
    return false;
  }
  beginInsertRows(parent, position, position + rows - 1);
  TreeNode &success = parentItem->copyNodeChildren(
      position, rows, rootItem->columnCount(), lastItem);
  this->setData(index(position, 0, parent), "Data", Qt::UserRole + 2);

  endInsertRows();

  for (int i = 0; i < lastItem->childCount(); i++) {
    QPersistentModelIndex itemIndex = index(position, 0, parent);
    copyRowsAndChildren(i, 1, itemIndex, index(i, 0, source));
  }

  return true; // TODO check for success of operation
}
void TreeModel::copyRowsRecursive(int position, QUuid callingId, QUuid calledId,
                                  const QModelIndex &source) {

  auto siblingIndex = match(index(0, 0), Qt::UserRole + 2, calledId.toString(),
                            1, Qt::MatchRecursive);

  auto item = getItem(siblingIndex[0]);
  if (item->acceptsCopies) {

    copyRowsAndChildren(position, 1, siblingIndex[0], source);
  }

  if ((!item->copyChildren.isEmpty()) && (item->acceptsCopies)) {
    for (int i = 0; i < item->copyChildren.size(); i++) {
      if (item->copyChildren[i] != callingId) {
        copyRowsRecursive(position, calledId, item->copyChildren[i], source);
      }
    }
  }

  if ((item->parents.isEmpty()) && (item->acceptsCopies)) {
    for (int i = 0; i < item->parents.size(); i++) {
      if (item->parents[i] != callingId) {
        copyRowsRecursive(position, calledId, item->parents[i], source);
      }
    }
  }

  return;
}
QString TreeModel::getId(const QModelIndex &index) {
  auto item = getItem(index);
  QString string = item->id.toString();
  return string;
}
int TreeModel::position(const QModelIndex &index) {
  auto item = getItem(index);
  auto parentItem = getItem(index.parent());

  for (int i = 0; i < parentItem->children().size(); i++) {

    if (parentItem->children()[i]->id == item->id) {
      return i;
    }
  }
  return -1;
}
void TreeModel::getIdToClipboard(const QModelIndex &index) {
  QClipboard *clipboardItem = QGuiApplication::clipboard();
  clipboardItem->setText(getId(index));
}
void TreeModel::acceptsCopies(const QModelIndex &index, bool acceptsCopies) {
  auto item = getItem(index);
  item->acceptsCopies = acceptsCopies;
}

bool TreeModel::hasMultipleSiblings(const QModelIndex &index) {
  auto item = getItem(index);
  if (!item->parent()) {
    return false;
  }
  for (int i = 0; i < item->siblingItems().size(); i++) {
    if (!(*(item->siblingItems()[i]->parent()) == *(item->parent()))) {
      return true;
    }
  }

  return false;
}

void TreeModel::setupModelData(const QStringList &lines, TreeNode *parent) {
  QVector<TreeNode *> parents;
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
      TreeNode *parent = parents.last();
      parent->insertChildren(parent->childCount(), 1, rootItem->columnCount());
      for (int column = 0; column < columnData.size(); ++column)
        parent->child(parent->childCount() - 1)
            ->setData(column, columnData[column]);
    }
    ++number;
  }
}
bool TreeModel::acceptsCopies(const QModelIndex &index) {
  auto item = getItem(index);
  if (item->acceptsCopies) {
    return true;
  } else {
    return false;
  }
}
bool TreeModel::isDirectDescendant(TreeNode *parent, TreeNode *child,
                                   int depth) {

  while (true) {
    if (depth == 0) {
      return false;
    }
    if (child->parent() == nullptr) {

      return false;
    } else if ((*child->parent() == *parent) || (*child == *parent)) {

      return true;

    } else {
      child = child->parent();
      depth--;
    }
  };
}
bool TreeModel::isDirectDescendant1(TreeNode *parent, TreeNode *child,
                                    int depth) {

  while (true) {
    if (depth == 0) {
      return false;
    }
    if (child->parent() == nullptr) {

      return false;
    } else if ((child->parent() == parent) || (child == parent)) {

      return true;

    } else if (parent->copyChildren.contains(child->id)) {

      return true;

    } else {
      child = child->parent();
      depth--;
    }
  };
}
