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
std::shared_ptr<QVector<TreeItem*>> childItems;
std::shared_ptr<QVector<TreeItem*>> parents;
TreeItem *parentItem;
 QUuid id;//TODO make data members private again

bool visible = true;
 bool enabled = true;
private:

//QVector<TreeItem*> *parents;

    bool result;

};
//! [0]

#endif // TREENODE_H
