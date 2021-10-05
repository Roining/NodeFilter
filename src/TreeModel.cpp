#include "include/TreeModel.h"
#include "include/TreeNode.h"
#include <QClipboard>
#include <QDataStream>
#include <QDebug>
#include <QDir>
#include <QElapsedTimer>
#include <QGuiApplication>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QRandomGenerator>

TreeModel::TreeModel(QObject *parent) {

  QDir::setCurrent(QDir::currentPath());
  QFile file("storage.dat");
  if (file.open(QIODevice::ReadWrite)) {
    QDataStream stream(&file);
    QVector<QVariant> rootData;
    QMultiMap<QUuid, QUuid> container;
    QMap<QUuid, TreeNode *> map;

    rootItem = new TreeNode(rootData, nullptr);
    deserializeDat(*rootItem, stream, container, map);
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
QJsonArray listArray;
QJsonArray inputArray;
int inputArrayIterator = 0;
Q_INVOKABLE void TreeModel::loadFile() {

  delete rootItem;
  listArray = QJsonArray();
  inputArrayIterator = 0;
  beginResetModel();

  QDir::setCurrent(QDir::currentPath());
  QFile file("storage.dat");
  QFile fileJSON("storage.json");
  fileJSON.open(QIODevice::ReadOnly);
  QJsonParseError jsonError;
  inputArray = QJsonDocument::fromJson(fileJSON.readAll(), &jsonError).array();
  if (jsonError.error != QJsonParseError::NoError) {
  }

  QDataStream stream(&file);
  QVector<QVariant> rootData;
  QMultiMap<QUuid, QUuid> container;
  QMap<QUuid, TreeNode *> map;
  rootItem = new TreeNode(rootData, nullptr);
  deserialize(*rootItem, stream, container, map);
  if (!rootItem->childCount()) {
    beginInsertRows(QModelIndex().parent(), 0, 1);
    rootItem->itemData.get()->append("data");
    endInsertRows();
    insertRows(0, 1, QModelIndex());
  }
  //  }
  file.close();
  fileJSON.close();
  endResetModel();
}
Q_INVOKABLE void TreeModel::loadHierarchy(const QModelIndex &index) {

  listArray = QJsonArray();
  inputArrayIterator = 0;
  auto parentItem = getItem(index);
  QDir::setCurrent(QDir::currentPath());

  QFile fileJSON("hierarchy.json");
  fileJSON.open(QIODevice::ReadOnly);
  QJsonParseError jsonError;
  QJsonObject document =
      QJsonDocument::fromJson(fileJSON.readAll(), &jsonError).object();
  if (jsonError.error != QJsonParseError::NoError) {
  }
  QVector<TreeNode *> parentsMap;
  listArray = document.value("concepts").toArray();

  QHash<QString, QJsonObject> hash;
  for (int i = 0; i < listArray.count(); i++) {
    hash[listArray[i].toObject().value("uri").toString()] =
        listArray[i].toObject();
  }

  for (int i = 0; i < listArray.count(); i++) {
    auto list = listArray[i].toObject().value("prefLabel").toObject().keys();
    if (list.isEmpty()) {
      continue;
    }
    if (listArray[i]
            .toObject()
            .value("prefLabel")
            .toObject()
            .value(list[0])
            .toString() == parentItem->item().toString()) {

      readJson(listArray[i].toObject(), hash, parentItem, parentsMap, nullptr);
      break;
    }
  }

  QVector<QVariant> rootData;

  fileJSON.close();
}
void TreeModel::readJson(QJsonObject object, QHash<QString, QJsonObject> &array,
                         TreeNode *parent, QVector<TreeNode *> &parentsMap,
                         TreeNode *isCopied) {
  auto list = object.value("prefLabel").toObject().keys();
  if (list.isEmpty()) {
    return;
  }
  if (object.value("prefLabel").toObject().value(list[0]).toString() == "") {
    return;
  }
  if (isCopied) {

    TreeNode &success =
        parent->copyNodeChildren(parent->childCount(), 1, 0, isCopied);
    return;
  }

  auto node = &parent->insertChildrenNew(parent->childCount(), 1, 0);
  node->itemData.get()->append(
      object.value("prefLabel").toObject().value(list[0]).toString());
  // endInsertRows();
  if (object.value("broader").toArray().count() > 1 && !isCopied) {
    parentsMap.append(node);
  }

  auto children = object.value("narrower").toArray();

  for (int o = 0; o < children.count(); o++) {
    QElapsedTimer timer;
    timer.start();
    QHash<QString, QJsonObject>::const_iterator child =
        array.find(children[o].toObject().value("uri").toString());

    if (child != array.end()) {

      if (child->value("broader").toArray().count() > 1) {
        auto listChild = child->value("prefLabel").toObject().keys();
        if (listChild.isEmpty()) {
          continue;
        }
        bool isAlreadyInserted = false;
        for (int p = 0; p < parentsMap.length(); p++) {

          if (parentsMap[p]->item().toString() == child->value("prefLabel")
                                                      .toObject()
                                                      .value(listChild[0])
                                                      .toString()) {
            readJson(*child, array, node, parentsMap, parentsMap[p]);
            isAlreadyInserted = true;
          }
        }
        if (!isAlreadyInserted) {
          readJson(*child, array, node, parentsMap, nullptr);
        }
      } else {
        readJson(*child, array, node, parentsMap, nullptr);
      }
    }
  }
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

  endInsertRows();
  const QModelIndex &child = this->index(position, 0, parent);

  this->setData(child, "", Qt::EditRole);
  this->setData(child, "Data", Qt::UserRole + 2);
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

  auto siblingIndex = match(index(0, 0), Qt::UserRole + 2, calledId.toString(),
                            1, Qt::MatchRecursive);

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
  const QPersistentModelIndex &child = this->index(position, 0, parent);

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
  beginRemoveRows(parent, position, position + 1 - 1);

  const bool success = parentItem->removeChildren(position, 1);

  endRemoveRows();
  updateProxyFilter(true);

  return true;
}

void TreeModel::removeRowsRecursive(int position, QUuid callingId,
                                    QUuid calledId,
                                    const QPersistentModelIndex &child) {

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

  if (file.open(QIODevice::WriteOnly | QIODevice::Truncate)) {

    QDataStream stream(&file);
    serializeClear(*rootItem);
    serializeCleanUp(*rootItem);
    serialize(*rootItem, stream);

    file.close();
  }
}
void TreeModel::saveAtExit() {

  QDir::setCurrent(QDir::currentPath());
  QString path = QDir::currentPath();
  QFile file("storage.dat");

  if (file.open(QIODevice::WriteOnly | QIODevice::Truncate)) {

    QDataStream stream(&file);
    serializeClear(*rootItem);
    serializeCleanUp(*rootItem);
    serialize(*rootItem, stream);

    file.close();
  }
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
}
void TreeModel::saveJSON() {
  QDir::setCurrent(QDir::currentPath());
  QFile fileJSON("storage.json");
  fileJSON.remove();

  listArray = QJsonArray();
  inputArray = QJsonArray();

  inputArrayIterator = 0;

  if (fileJSON.open(QIODevice::Append | QIODevice::Text)) {

    serializeClear(*rootItem);
    serializeCleanUp(*rootItem);
    serializeJSON(*rootItem);
    QJsonDocument doc(listArray);
    fileJSON.write(doc.toJson(QJsonDocument::Indented));
    fileJSON.close();
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

bool TreeModel::isDescendantReverse(TreeNode *parent, TreeNode *child,
                                    int depth, bool searchClones) {
  if (depth == 0) {
    return false;
  }

  if (isDescendant(parent, child, depth, searchClones)) {
    return true;
  }
  for (int i = 0; i < child->childItems->size(); i++) {
    if (searchClones) {
      if (isDescendantReverse(parent, (*child->childItems.get())[i], depth - 1,
                              true)) {
        return true;
      }

    } else {
      if (isDescendantReverse(parent, (*child->childItems.get())[i],
                              depth - 1)) {
        return true;
      }
    }
  }

  return false;
};
TreeNode *TreeModel::isDescendantNode(TreeNode *parent, TreeNode *child) {

  if (*parent == *child) {
    return parent;
  }

  for (int i = 0; i < parent->childItems->size(); i++) {
    auto match = isDescendantNode((*parent->childItems.get())[i], child);

    if (match) {
      return match;
    }
  }

  return nullptr;
};
bool TreeModel::isCopiedFromNode(TreeNode *copiedNode, TreeNode *originalNode) {

  if (copiedNode->parents.isEmpty()) {
    return false;
  }
  if ((copiedNode->parents.first() == originalNode->id) ||
      copiedNode->id == originalNode->id || !originalNode->acceptsCopies) {
    return true;
  } else {
    //      const auto& parentNode = map.value(copiedNode->parents.first());
    TreeNode *parentNode = nullptr;
    for (int i = 0; i < copiedNode->siblingItems().length(); i++) {
      if (copiedNode->siblingItems()[i]->copyChildren.contains(
              copiedNode->id)) {
        parentNode = copiedNode->siblingItems()[i];
      }
    }
    if (!isCopiedFromNode(parentNode, originalNode)) {
      return false;
    } else {
      return true;
    }
  }
}

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
void TreeModel::serializeJSON(TreeNode &node) {

  QFile file("storage.json");
  file.open(QIODevice::Append | QIODevice::Text);

  QJsonObject defectObject;
  defectObject.insert("itemData", node.item().toString());
  defectObject.insert("numberOfChildren", node.numberOfChildren);
  defectObject.insert("id", node.id.toString());
  defectObject.insert("acceptsCopies", node.acceptsCopies);
  QJsonObject json;
  QMap<QString, int> myMap;

  QMapIterator<QUuid, int> i(node.position);
  while (i.hasNext()) {
    i.next();
    myMap.insertMulti(i.key().toString(), i.value());
  }
  if (node.item().toString().contains("test12")) {
  }
  assert(myMap.size() == node.position.size());
  QMapIterator<QString, int> j(myMap);
  while (j.hasNext()) {
    j.next();
    QJsonArray array;
    for (auto it : myMap.values(j.key())) {
      array.append(it);
    }

    json.insert(j.key(), array);
  }

  defectObject.insert("position", json);

  QJsonArray tempParents1;
  for (QUuid e : node.tempParents) {

    tempParents1.append(e.toString());
  }
  defectObject.insert("tempParents", tempParents1);

  QJsonArray parents1;
  for (QUuid e : node.parents) {

    parents1.append(e.toString());
  }
  defectObject.insert("parents", parents1);
  QJsonArray copyChildren1;
  for (QUuid e : node.copyChildren) {

    copyChildren1.append(e.toString());
  }
  defectObject.insert("copyChildren", copyChildren1);

  listArray.push_back(defectObject);

  if (node.childCount()) {
    for (int i = 0; i < node.childCount(); i++) {

      serializeJSON(*(node.children()[i]));
    }
  }
  file.close();
  return;
}
void TreeModel::serializeCleanUp(TreeNode &node) {

  if (node.siblingItems().size() > 1) {
    TreeNode *check = nullptr;
    for (int i = 0; i < node.siblingItems().size(); i++) {

      if (!(node.siblingItems()[i]->position.isEmpty())) {
        check = node.siblingItems()[i];
      }
    }
    if (check != nullptr) {
      check->position.insertMulti(node.parentItem->id,
                                  node.parent()->children().indexOf(&node));

    } else {
      for (int i = 0; i < node.siblingItems().size(); i++) {

        node.tempParents.append(node.siblingItems()[i]->parentItem->id);
      }
      node.position.insertMulti(node.parentItem->id,
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
void TreeModel::deserializeDat(TreeNode &node, QDataStream &stream,
                               QMultiMap<QUuid, QUuid> &container,
                               QMap<QUuid, TreeNode *> &map, bool check) {
  if (!check) {
    stream >> &node;
    //         if inserted node is not copied

    if ((node.tempParents.size() > 1) &&
        (!check)) { // temp stores ids of parents.if more than 1 then node is
                    // copied further
                    /*  map.insert(node.id,
                                 &node); */// corresponds id of not copied nodes to a pointer to
                         // the node
      for (int i = 0; i < node.tempParents.size(); i++) {

        container.insert(
            node.tempParents[i],
            node.id); // keys are parents, current item(to be copied) is value
      }

      if (!node.position.isEmpty()) {
      }
    }
  } else { // if node is copied
    stream >> &node;
  }
  map.insert(node.id, &node);
  for (int i = 0; i < node.numberOfChildren; i++) {

    if (container.value(node.id) ==
        QUuid()) { // if node is a not parent of a copied item

      deserializeDat(node.insertChildrenNew(i, 1, 0), stream, container, map);
    } else {
      TreeNode *check1 = nullptr;
      auto list = container.values(
          node.id); // list should contain ids of all potential children
      for (int j = 0; j < list.size(); j++) {

        for (auto &item : map.value(list[j])->position.keys()) {

          if (item == node.id &&
              map.value(list[j])->position.values(item).contains(i)) {
            check1 = map.value(list[j]);

            break;
          }
        }
      }
      if (check1 != nullptr) {

        deserializeDat(node.insertChildrenSerialization(i, 1, 0, check1),
                       stream, container, map, true);
      } else {

        deserializeDat(node.insertChildrenNew(i, 1, 0), stream, container, map);
      }
      check1 = nullptr;
    }
  }
  return;
}
void TreeModel::deserialize(TreeNode &node, QDataStream &stream,
                            QMultiMap<QUuid, QUuid> &container,
                            QMap<QUuid, TreeNode *> &map, bool check) {
  if (!check) {

    auto nodeInfo = inputArray[inputArrayIterator++].toObject();

    node.itemData->append(nodeInfo.value("itemData").toString());

    node.numberOfChildren = nodeInfo.value("numberOfChildren").toInt();

    node.id = QUuid(nodeInfo.value("id").toString());

    node.acceptsCopies = nodeInfo.value("acceptsCopies").toBool();

    for (const auto &e : nodeInfo.value("tempParents").toArray()) {

      node.tempParents.append(QUuid(e.toString()));
    }

    for (const auto &e : nodeInfo.value("parents").toArray()) {

      node.parents.append(QUuid(e.toString()));
    }

    for (const auto &e : nodeInfo.value("copyChildren").toArray()) {

      node.copyChildren.append(QUuid(e.toString()));
    }

    for (const auto &e : nodeInfo.value("position").toObject().keys()) {

      for (auto it : nodeInfo.value("position").toObject().value(e).toArray()) {
        node.position.insertMulti(QUuid(e), it.toInt());
      }
    }

    if ((node.tempParents.size() > 1) &&
        (!check)) { // temp stores ids of parents.if more than 1 then node is
                    // copied further
      map.insert(node.id,
                 &node); // corresponds id of not copied nodes to a pointer to
                         // the node
      for (int i = 0; i < node.tempParents.size(); i++) {

        container.insert(
            node.tempParents[i],
            node.id); // keys are parents, current item(to be copied) is value
      }

      if (!node.position.isEmpty()) {
      }
    }
  } else { // if node is copied
           //    stream >> &node;
    auto nodeInfo = inputArray[inputArrayIterator++].toObject();

    node.item() = nodeInfo.value("itemData").toString();

    node.numberOfChildren = nodeInfo.value("numberOfChildren").toInt();
    node.numberOfChildren;

    node.id = QUuid(nodeInfo.value("id").toString());

    node.acceptsCopies = nodeInfo.value("acceptsCopies").toBool();

    for (const auto &e : nodeInfo.value("tempParents").toArray()) {

      node.tempParents.append(QUuid(e.toString()));
    }

    for (const auto &e : nodeInfo.value("parents").toArray()) {

      node.parents.append(QUuid(e.toString()));
    }

    for (const auto &e : nodeInfo.value("copyChildren").toArray()) {

      node.copyChildren.append(QUuid(e.toString()));
    }

    for (const auto &e : nodeInfo.value("position").toObject().keys()) {

      for (auto it : nodeInfo.value("position").toObject().value(e).toArray()) {
        node.position.insertMulti(QUuid(e), it.toInt());
      }
    }
  }

  for (int i = 0; i < node.numberOfChildren; i++) {

    if (container.value(node.id) ==
        QUuid()) { // if node is a not parent of a copied item

      deserialize(node.insertChildrenNew(i, 1, 0), stream, container, map);
    } else {
      TreeNode *check1 = nullptr;
      auto list = container.values(
          node.id); // list should contain ids of all potential children
      for (int j = 0; j < list.size(); j++) {

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
                    container, map, true);
      } else {

        deserialize(node.insertChildrenNew(i, 1, 0), stream, container, map);
      }
      check1 = nullptr;
    }
  }
  return;
}

bool TreeModel::copyRows(int position, int rows, const QModelIndex &parent,
                         const QPersistentModelIndex &source, bool isDetached) {
  updateProxyFilter(false);
  TreeNode *parentItem = getItem(parent);
  auto lastItem = getItem(source);
  if (!parentItem) {
    return false;
  }
  if (!lastItem->parent()) {
    emit recursionSignal();
    return false;
  }

  if (!copyRowsAndChildren(position, 1, parent, source, isDetached)) {
    return false;
  }

  if ((!parentItem->copyChildren.isEmpty())) {

    for (int i = 0; i < parentItem->copyChildren.size(); i++) {
      copyRowsRecursive(position, parentItem->id, parentItem->copyChildren[i],
                        index(position, 0, parent));
    }
  }

  if ((!parentItem->parents.isEmpty())) {

    for (int i = 0; i < parentItem->parents.size(); i++) {
      copyRowsRecursive(position, parentItem->id, parentItem->parents[i],
                        index(position, 0, parent));
    }
  }

  updateProxyFilter(true);

  return true;
}

bool TreeModel::copyRowsAndChildren(int position, int rows,
                                    const QModelIndex &parent,
                                    const QPersistentModelIndex &source,
                                    bool isDetached) {
  TreeNode *parentItem = getItem(parent);

  if (!parentItem) {
    return false;
  }
  TreeNode *lastItem = getItem(source);
  QVector<TreeNode *> result =
      isDirectDescendantNode(lastItem, parentItem, 1000);
  if (!result.isEmpty()) {
    for (int i = 0; i < result.length(); i++) {
      //    auto bool1 = isCoiedFromNode(lastItem->id, result);
      //    auto bool2 = isCoiedFromNode(result->id, lastItem);
      if ((isCopiedFromNode(lastItem, result[i]) ||
           isCopiedFromNode(result[i], lastItem)) ||
          lastItem == result[i]) {

        return false;
      }
      //      if (lastItem == result[i]) {

      //        return false;
      //      }
    }
  }

  if (parentItem->children().length() >= position) {
    beginInsertRows(parent, position, position + rows - 1);
    TreeNode &success = parentItem->copyNodeChildren(
        position, rows, rootItem->columnCount(), lastItem);
    this->setData(index(position, 0, parent), "Data", Qt::UserRole + 2);

    endInsertRows();
    if (isDetached) {
      for (int i = 0; i < success.siblings->size(); i++) {
        if (!success.parents.isEmpty()) {
          if (success.siblingItems()[i]->id == success.parents[0]) {
            success.siblingItems()[i]->copyChildren.erase(std::find(
                success.siblingItems()[i]->copyChildren.begin(),
                success.siblingItems()[i]->copyChildren.end(), success.id));
          }
        }
      }
      success.parents.clear();
      return true;
    }
  }

  for (int i = 0; i < lastItem->childCount(); i++) {
    QPersistentModelIndex itemIndex = index(position, 0, parent);
    //    copyRowsAndChildren(i, 1, itemIndex, index(i, 0, source));
    if (!copyRowsAndChildren(i, 1, itemIndex, index(i, 0, source))) {
      return false;
    }
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

  if ((!item->parents.isEmpty()) && (item->acceptsCopies)) {
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
bool TreeModel::isDirectDescendant(TreeNode *parent, TreeNode *child, int depth,
                                   bool searchClones) {

  while (true) {
    if (depth == 0) {
      return false;
    }
    if (child->parent() == nullptr) {

      return false;
    } else if ((*child->parent() == *parent) || (*child == *parent)) {
      if (searchClones) {
        return true;
      } else {
        if ((child->parent() == parent) || (child == parent)) {
          return true;
        }
      }
    }
    child = child->parent();
    depth--;
  };
}

QVector<TreeNode *> TreeModel::isDirectDescendantNode(TreeNode *parent,
                                                      TreeNode *child,
                                                      int depth) {
  QVector<TreeNode *> array;
  while (true) {

    if (child->parent() == nullptr) {

      //      return nullptr;
      return array;
    } else if (*child == *parent) {

      //      return child;
      array.append(child);

    } /*else if (parent->copyChildren.contains(child->id)) {

      return true;

    }*/
    //    else {
    child = child->parent();
    depth--;
    //    }
  };
}
