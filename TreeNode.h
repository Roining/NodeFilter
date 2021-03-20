#ifndef TREENODE_H
#define TREENODE_H

#include "TreeModel.h"
#include <QUuid>
#include <QVariant>
#include <QVector>
#include <memory>

class TreeItem {

public:
  explicit TreeItem(const QVector<QVariant> data, TreeItem *parent = nullptr);
  TreeItem &operator=(TreeItem &other);
  TreeItem(TreeItem &other);
  ~TreeItem();
  bool operator==(const TreeItem &other) const;

  QVariant data(int column) const;
  bool insertColumns(int position, int columns);
  bool removeColumns(int position, int columns);
  int columnCount() const;
  bool setData(int column, const QVariant &value);
  TreeItem *insertChildren(int position, int count, int columns);
  TreeItem &insertChildren1(int position, int count, int columns,
                            TreeItem *parent);
  TreeItem *insertChildrenRecursive(int position, int count, int columns,
                                    TreeItem *parent);
  TreeItem &insertChildren12(int position, int count, int columns,
                             TreeItem *parent);
  TreeItem &insertChildren2(int position, int count, int columns);
  bool removeChildren(int position, int count);

  TreeItem *child(int number);
  int childCount() const;
  int childNumber() const;
  TreeItem *parent();
  void setParent(TreeItem *parent);
  QVariant &item();
  QVector<TreeItem *> &siblingItems();
  QVector<TreeItem *> &children();
  void setVisible(bool isVisible);

private:
  friend class TreeModel;
  friend QDataStream &operator>>(QDataStream &in, TreeItem *item);
  friend QDataStream &operator<<(QDataStream &out, TreeItem &item);
  std::shared_ptr<QVector<QVariant>> itemData;
  std::shared_ptr<QVector<TreeItem *>> childItems;
  std::shared_ptr<QVector<TreeItem *>> siblings;
  TreeItem *parentItem;
  int numberOfChildren;
  QMultiMap<QUuid, int> position;
  QUuid id; // TODO make data members private again
  QVector<QUuid> tempParents;
  QVector<QUuid> parents;
  QVector<QUuid> copyChildren;
  bool acceptsCopies = true;
  bool enabled = true;
};
//! [0]

#endif // TREENODE_H
