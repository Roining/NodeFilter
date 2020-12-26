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
    TreeItem& operator=( TreeItem& other);

    TreeItem( TreeItem& other);

    TreeItem *child(int number);
    void setParent(TreeItem *parent);
    int childCount() const;
    int columnCount() const;
    QVariant data(int column) const;
     TreeItem * insertChildren(int position, int count, int columns);
     TreeItem * insertChildren1(int position, int count, int columns, TreeItem *parent);
    bool insertColumns(int position, int columns);
    TreeItem *parent();
    bool isDescendant(TreeItem *parent,TreeItem *child);
    bool removeChildren(int position, int count);
    bool removeColumns(int position, int columns);
    int childNumber() const;
    bool setData(int column, const QVariant &value);
std::shared_ptr<QVector<QVariant>> itemData;
private:
    QVector<TreeItem*> childItems;
//QVector<TreeItem*> *parents;
    TreeItem *parentItem;
    bool result;
};
//! [0]

#endif // TREENODE_H
