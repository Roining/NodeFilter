#ifndef TREENODE_H
#define TREENODE_H


#include <QVariant>
#include <QVector>
#include <memory>
#include <QUuid>
class TreeItem
{

public:
    explicit TreeItem(const QVector<QVariant> data, TreeItem *parent = nullptr);
    ~TreeItem();
    TreeItem& operator=( TreeItem& other);
    TreeItem( TreeItem& other);
    bool operator==(const TreeItem& other) const;
    TreeItem & insertChildren2(int position, int count, int columns);
    TreeItem *child(int number);
    void setParent(TreeItem *parent);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
    TreeItem * insertChildren(int position, int count, int columns);
    TreeItem & insertChildren1(int position, int count, int columns, TreeItem *parent);
    TreeItem * insertChildrenRecursive(int position, int count, int columns, TreeItem *parent);
    bool insertColumns(int position, int columns);
    TreeItem *parent();
    bool isDescendantOfItself(TreeItem *parent,TreeItem *child);
    bool removeChildren(int position, int count);
    bool removeColumns(int position, int columns);
    int childNumber() const;
    bool setData(int column, const QVariant &value);
    QVariant& item();
    QVector<TreeItem*>& siblingItems();
    QVector<TreeItem*>& children();
    std::shared_ptr<QVector<QVariant>> itemData;
    std::shared_ptr<QVector<TreeItem*>> childItems;
    std::shared_ptr<QVector<TreeItem*>> siblings;
    TreeItem *parentItem;
    int numberOfChildren;
    QMultiMap<QUuid,int> position;
    QUuid id;//TODO make data members private again
    QVector<QUuid> tempParents;
    QVector<QUuid> parents;
    QVector<QUuid> copyChildren;

    bool acceptsCopies = true;
    bool visible = true;
    bool enabled = true;
    bool result;
private:




};
//! [0]

#endif // TREENODE_H
