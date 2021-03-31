#include "include/TreeNode.h"
#include <iostream>

TreeNode::TreeNode(const QVector<QVariant> data, TreeNode *parent)
    : itemData(std::make_shared<QVector<QVariant>>(data)), parentItem(parent),
      childItems(std::make_shared<QVector<TreeNode *>>()), id(id.createUuid()),
      acceptsCopies(true), siblings(std::make_shared<QVector<TreeNode *>>()) {

  siblings->append(this);
}

TreeNode &TreeNode::operator=(TreeNode &other) {
  if (&other != this) {
    parentItem = nullptr;
    siblings = other.siblings;
    siblings->append(this);
    itemData = other.itemData;
  }
  return *this;
}
TreeNode::TreeNode(TreeNode &other) {
  childItems = other.childItems;

  parentItem = &other;

  siblings = other.siblings;
  siblings->append(this);
  parents.append(other.id);
  other.copyChildren.append(this->id);
  itemData = other.itemData;
}

TreeNode::~TreeNode() {

  siblings->erase(std::find(siblings->begin(), siblings->end(), this));
  for (int i = 0; i < siblings->size(); i++) {
    if (!parents.isEmpty()) {
      if (siblingItems()[i]->id == parents[0]) {

        siblingItems()[i]->copyChildren.erase(
            std::find(siblingItems()[i]->copyChildren.begin(),
                      siblingItems()[i]->copyChildren.end(), id));
        siblingItems()[i]->copyChildren.append(copyChildren);
      }
    }
  }
  for (int i = 0; i < siblings->size(); i++) {

    if (copyChildren.contains(siblingItems()[i]->id)) {
      siblingItems()[i]->parents.clear();
      if (!parents.isEmpty()) {
        siblingItems()[i]->parents.append(parents[0]);
      }
    }
  }

  qDeleteAll(*childItems);
}
bool TreeNode::operator==(const TreeNode &other) const {

  return (this->itemData.get()) == (other.itemData.get());
}
QVariant TreeNode::data(int column) const {
  if (column < 0 || column >= itemData->size())
    return QVariant();
  return itemData->at(column);
}
bool TreeNode::insertColumns(int position, int columns) {
  if (position < 0 || position > itemData->size())
    return false;

  for (int column = 0; column < columns; ++column)
    itemData->insert(position, QVariant());

  for (TreeNode *child : qAsConst(*childItems))
    child->insertColumns(position, columns);

  return true;
}

int TreeNode::columnCount() const { return itemData->count(); }

bool TreeNode::setData(int column, const QVariant &value) {
  if (column < 0 || column >= itemData->size())
    return false;
  (*itemData.get())[column] = value;

  return true;
}
TreeNode *TreeNode::insertChildren(int position, int count, int columns) {
  if (position < 0 || position > childItems->size())
    return (*childItems.get())[0];

  for (int row = 0; row < count; ++row) {
    QVector<QVariant> data(columns);
    TreeNode *item = new TreeNode(data, this);
    childItems->insert(position, item);
  }

  return (*childItems.get())[position];
}
TreeNode &TreeNode::copyNodeChildren(int position, int count, int columns,
                                     TreeNode *parent) {
  if (position < 0 || position > childItems->size())
    return *children()[position];

  for (int row = 0; row < count; ++row) {
    QVector<QVariant> data(columns);
    TreeNode *item = new TreeNode(data, this);
    *item = *parent;
    item->parents.append(parent->id);
    parent->copyChildren.append(item->id);
    item->setParent(this);
    childItems->insert(position, item);
  }
  return *children()[position];
}

TreeNode *TreeNode::insertChildrenRecursive(int position, int count,
                                            int columns, TreeNode *copiedItem) {
  if (position < 0 || position > childItems->size())
    return (*childItems.get())[0];

  for (int row = 0; row < count; ++row) {
    QVector<QVariant> data(columns);
    TreeNode *item = new TreeNode(data, this);
    *item = *copiedItem;
    item->setParent(this);
    childItems->insert(position, item);
    for (int i = 0; i < copiedItem->childCount(); i++) {
      insertChildrenRecursive(i, 0, 0, (*copiedItem->childItems.get())[i]);
    }
  }
  return (*childItems.get())[position];
}

TreeNode &TreeNode::insertChildrenSerialization(int position, int count,
                                                int columns, TreeNode *parent) {
  if (position < 0 || position > childItems->size())
    return *children()[0];

  for (int row = 0; row < count; ++row) {
    QVector<QVariant> data(columns);
    TreeNode *item = new TreeNode(data, this);
    *item = *parent;

    item->setParent(this);
    childItems->insert(position, item);
  }
  return *children()[position];
}
TreeNode &TreeNode::insertChildrenNew(int position, int count, int columns) {
  if (position < 0 || position > childItems->size())
    return *(children()[0]);

  for (int row = 0; row < count; ++row) {
    QVector<QVariant> data(columns);
    TreeNode *item = new TreeNode(data, this);

    childItems->insert(position, item);
  }

  return *(children()[position]);
}
bool TreeNode::removeChildren(int position, int count) {
  if (position < 0 || position + count > childItems->size())
    return false;

  for (int row = 0; row < count; ++row)
    delete childItems->takeAt(position);

  return true;
}
bool TreeNode::removeColumns(int position, int columns) {
  if (position < 0 || position + columns > itemData->size())
    return false;

  for (int column = 0; column < columns; ++column)
    itemData->remove(position);

  for (TreeNode *child : qAsConst(*childItems))
    child->removeColumns(position, columns);

  return true;
}
TreeNode *TreeNode::child(int number) {
  if (number < 0 || number >= childItems->size())
    return nullptr;
  return childItems->at(number);
}
int TreeNode::childCount() const { return childItems.get()->count(); }

int TreeNode::childNumber() const {
  if (parentItem)
    return parentItem->childItems->indexOf(const_cast<TreeNode *>(this));
  return 0;
}

TreeNode *TreeNode::parent() { return parentItem; }
void TreeNode::setParent(TreeNode *parent) { parentItem = parent; }

QVariant &TreeNode::item() { return (itemData.get())[0][0]; }
QVector<TreeNode *> &TreeNode::siblingItems() { return *(siblings.get()); }
QVector<TreeNode *> &TreeNode::children() { return *(childItems.get()); }
void TreeNode::setVisible(bool isVisible) { this->isVisible = isVisible; }
