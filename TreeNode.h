#ifndef TREENODE_H
#define TREENODE_H



#include <QVariant>
#include <QVector>
#include <memory>
class TreeItem
{
public:
    explicit TreeItem(const QVector<QVariant> data, TreeItem *parent = nullptr);
    ~TreeItem();
//    TreeItem(const TreeItem& other)
//      : size(other.size), data(other.data) {}
    TreeItem *child(int number);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
     TreeItem * insertChildren(int position, int count, int columns);
    bool insertColumns(int position, int columns);
    TreeItem *parent();
    bool removeChildren(int position, int count);
    bool removeColumns(int position, int columns);
    int childNumber() const;
    bool setData(int column, const QVariant &value);

private:
    QVector<TreeItem*> childItems;
   std::shared_ptr<QVector<QVariant>> itemData;
    TreeItem *parentItem;
};
//! [0]

#endif // TREENODE_H
