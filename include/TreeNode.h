#ifndef TREENODE_H
#define TREENODE_H

#include "TreeModel.h"
#include <QUuid>
#include <QVariant>
#include <QVector>
#include <memory>

class TreeNode {

public:
  explicit TreeNode(const QVector<QVariant> data, TreeNode *parent = nullptr);
  TreeNode &operator=(TreeNode &other);
  TreeNode(TreeNode &other);
  ~TreeNode();
  bool operator==(const TreeNode &other) const;
  QVariant data(int column) const;
  bool insertColumns(int position, int columns);
  bool removeColumns(int position, int columns);
  int columnCount() const;
  bool setData(int column, const QVariant &value);
  TreeNode *insertChildren(int position, int count, int columns);
  TreeNode &copyNodeChildren(int position, int count, int columns,
                             TreeNode *parent);
  TreeNode *insertChildrenRecursive(int position, int count, int columns,
                                    TreeNode *parent);
  TreeNode &insertChildrenSerialization(int position, int count, int columns,
                                        TreeNode *parent);
  TreeNode &insertChildrenNew(int position, int count, int columns);
  bool removeChildren(int position, int count);

  TreeNode *child(int number);
  int childCount() const;
  int childNumber() const;
  TreeNode *parent();
  void setParent(TreeNode *parent);
  QVariant &item();
  QVector<TreeNode *> &siblingItems();
  QVector<TreeNode *> &children();
  void setVisible(bool isVisible);

private:
  friend class TreeModel;
  friend QDataStream &operator>>(QDataStream &in, TreeNode *item);
  friend QDataStream &operator<<(QDataStream &out, TreeNode &item);
  std::shared_ptr<QVector<QVariant>> itemData;
  std::shared_ptr<QVector<TreeNode *>> childItems;
  std::shared_ptr<QVector<TreeNode *>> siblings;
  TreeNode *parentItem;
  int numberOfChildren;
  QMap<QUuid, int> position;
  QUuid id;
  QVector<QUuid> tempParents;
  QVector<QUuid> parents;
  QVector<QUuid> copyChildren;
  bool acceptsCopies = true;
  bool isVisible = true;
};

#endif // TREENODE_H
