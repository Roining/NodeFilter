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
//TreeModel::TreeModel(QObject *parent){


//    const QStringList headers({("Title")});
//      QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\default.txt");
//       file.open(QIODevice::ReadOnly);
//       const QString data = file.readAll();
////        TreeModel *model = new TreeModel(headers, file.readAll()); //TODO clean this up


//    QVector<QVariant> rootData;
//    for (const QString &header : headers)
//        rootData << header;

//deserialize(rootItem,stream);
//    rootItem = new TreeItem(rootData);
////    setupModelData(data.split('\n'), rootItem);

//    file.close();

//}
//QDataStream &operator>>(QDataStream &in,  TreeItem *&item){
////<<*item.childItems
////    item = new TreeItem(0,0);
//    std::shared_ptr<QVector<QVariant>> itemData1 = std::make_shared<QVector<QVariant>>();
//    item = new TreeItem(*itemData1);
//in >> *item->itemData;
//        in>> item->parentItem;

//        in>> *item->childItems;
//        in>> item->id;
//        in>> *item->parents;
//return in;
//}

#include "TreeModel.h"
#include "TreeNode.h"
#include <iostream>
#include <QDataStream>
#include <QDebug>



QDebug operator<<(QDebug debug, const TreeItem &c)
{
    QDebugStateSaver saver(debug);
    debug.nospace() << '(' << c.itemData.get() << ", " << c.childItems.get() << ')';

    return debug;
}

QDataStream &operator<<(QDataStream &out,  TreeItem &item){
out << *item.itemData;
out << item.numberOfChildren;
out << item.id;
qDebug() << "serialising parents: " << *item.parents;
//TODO check smwhere if there's more than 1 parent
if ((*item.parents.get()).size() >1){ //check if item has more than 1 parent; al
for(int i = 0; i < (*item.parents.get()).size();i++){
    if ((*item.parents.get())[i] != nullptr){ //check for nullptr
   item.temp.append((*item.parents.get())[i]->id);
    }
}
}
out << item.temp;
out << item.position;




//qDebug << item.itemData;
return out;
}


QDataStream &operator>>(QDataStream &in,  TreeItem *item){


in >> *item->itemData;
in >> item->numberOfChildren; //TODO move out of class members
in >> item->id;
//list of parents' ids
in >> item->temp;
in >> item->position;


qDebug() << "deserialising parents before: " << *item->parents;
//in >> *item->parents;
qDebug() << "serialising parents after: " << *item->parents;

qDebug() << "before " << *item->childItems;

//in >> *temp;




return in;
}
Q_INVOKABLE void TreeModel::deserialize( TreeItem  *node ,QDataStream &stream, bool check){
if(!check){ // if inserted node is not copied
    stream >> node;}
else{ //if node is copied
//     clone = node;
    stream >> node;
//    node->childItems->clear(); //delete(onle from container?) constructed children. Does info get lost when reconstructing? e.g. when there are copied nodes in children?
//    node->parents->clear(); //TODO

}
map.insert(node->id,node);
//     map.insert(node->id,node);
    if((node->temp.size() >1)&& (!check)){ //temp stores id's of parents.if more than 1 then node is copied
     for(int i = 0; i < node->temp.size();i++){
//         auto p = node->temp[i];

//     auto v = map.key(node->parentItem);
//     auto f1 = map.value(container.key(node->id));
//         if(node->temp[i] != map.key(node->parentItem)){ //TODO what if copies are placed in same row? //if one of parents id's doesn't match parentItem/

//             container.insert(node->id,node->temp[i]); //container has id's of items linked to their parents' items

//         }
          //TODO what if copies are placed in same row? //if one of parents id's doesn't match parentItem/

             container.insert(node->id,node->temp[i]); //container has id's of items linked to their parents' items ids
//probable dont need to check for parent now. Likely caused bugs of other otems had item's parent as a parent

     }
     }


if(node->numberOfChildren){
//    auto l = map.value(container.key(node->id))->position;
    for(int i = 0; i < node->numberOfChildren;i++){
//         auto r = map.value(container.key(node->id));

        if(container.key(node->id) == QUuid()){ //if item is a not parent of a copied item
 deserialize(node->insertChildren2(i,1,0),stream);
        }
        else if (map.value(container.key(node->id))->position[0] != i){
 deserialize(node->insertChildren2(i,1,0),stream);
        }
        else{//if item is not a parent of a copied item
//            auto k = container.key(node->id);
            auto f = map.value(container.key(node->id));

map.value(container.key(node->id))->position.remove(0);

container.remove(container.key(node->id),node->id); //TODO

//            node->insertChildren1(i,1,0,f);
            deserialize( node->insertChildren1(i,1,0,f),stream,true);


        }

    }
//    if(!check){
//        for(int i = 0;i<node->childItems->size();i++){
//            (*node->childItems.get())[i] = clone;

//        }
//    }
}
return;
}

Q_INVOKABLE void TreeModel::serialize( TreeItem  *node ,QDataStream &stream){
    if (node->parents->size() >1){
//        for(int i = 0;i< (*node->parents.get())[i]->childItems )
//        if((node->parentItem->childItems.get()[i])
//node->position.append(node->parentItem->childItems->indexOf(node));
for(int i = 0; i < node->parents->size();i++){
    for(int j = 0;j< (*node->parents.get())[i]->childItems->size();j++){
//        auto temp =  (*(*node->parents.get())[i]);
//        auto n = *(*temp.childItems.get())[j];
//        auto t1 = (*node->parents.get())[i]->childItems->size();
//         QVector<TreeItem*> pi2 = (temp.childItems.get()[j]);
//        TreeItem* pi = (temp.childItems.get()[j][j]);
//        auto t = *node;
//        auto iu = temp.childItems.get()[j][0];
//        if( temp.childItems.get()[j][0] == node){
//      auto r =   *(temp.childItems.get()[0][j]);
        if( (*(*(*(*node->parents.get())[i]).childItems.get())[j]) == *node){
//            auto copy = (*temp.childItems.get())[j];
//            auto copy = temp.childItems.get()[j][0];
//             TreeItem&  copy = (*(*(*(*node->parents.get())[i]).childItems.get())[j]);
//            auto p = (*node->parents.get())[i]->childItems->indexOf(&copy);
            node->position.append((*node->parents.get())[i]->childItems->indexOf(&(*(*(*(*node->parents.get())[i]).childItems.get())[j])));
        }
    }
//auto u = (*node->parents.get())[i]->childItems->indexOf((*node->parents.get())[i]->childItems.);
//auto k = (*node->parents.get())[i];

//    node->position.append((*node->parents.get())[i]->childItems->indexOf((*node->parents.get())[i])); //
}
    }

node->numberOfChildren = node->childCount();
    stream << *node;

if(node->childCount()){ //TODO replace with numberOfChildren?
    for(int i = 0; i < node->childCount();i++){
        TreeItem* childNode = (*node->childItems.get())[i];

        serialize(childNode,stream);

    }
}
return;
}
Q_INVOKABLE void TreeModel::log1(){
    QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\file.dat");
    if(file.open(QIODevice::WriteOnly)){
    QDataStream stream( &file );
    //stream << *rootItem->child(1);
    //serialize(rootItem,stream);
    rootItem->numberOfChildren = rootItem->childCount();
        serialize(rootItem,stream);
         file.close();
    }
}
Q_INVOKABLE void TreeModel::log(){
    QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\file.dat");
    if(file.open(QIODevice::WriteOnly)){
    QDataStream stream( &file );
    //stream << *rootItem->child(1);
    //serialize(rootItem,stream);
    rootItem->numberOfChildren = rootItem->childCount();
        serialize(rootItem,stream);
         file.close();
    }
}
//! [0]
TreeModel::TreeModel(QObject *parent){



    QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\file.dat");
    if(file.open(QIODevice::ReadWrite)){
    QDataStream stream( &file );

//const QStringList headers({("Title")});
    QVector<QVariant> rootData;
//    for (const QString &header : headers)
//        rootData << header;
    rootItem = new TreeItem(rootData);
deserialize(rootItem,stream);

//    setupModelData(data.split('\n'), rootItem);

    file.close();
    }

}
//TreeModel::TreeModel(QObject *parent){


//    const QStringList headers({("Title")});
//      QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\default.txt");
//       file.open(QIODevice::ReadOnly);
//       const QString data = file.readAll();
////        TreeModel *model = new TreeModel(headers, file.readAll()); //TODO clean this up


//    QVector<QVariant> rootData;
//    for (const QString &header : headers)
//        rootData << header;


//    rootItem = new TreeItem(rootData);
//    setupModelData(data.split('\n'), rootItem);

//    file.close();

//}
TreeModel::TreeModel(const QStringList &headers, const QString &data, QObject *parent)
    : QAbstractItemModel(parent)
{
    QVector<QVariant> rootData;
    for (const QString &header : headers)
        rootData << header;

    rootItem = new TreeItem(rootData);
    setupModelData(data.split('\n'), rootItem);
}
//! [0]

//! [1]
TreeModel::~TreeModel()
{
    delete rootItem;
}
//! [1]

//! [2]

    QDataStream &operator>>(QDataStream &, TreeModel &);
\
    int TreeModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return rootItem->columnCount();
}
//! [2]

Q_INVOKABLE QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    if(role == Qt::UserRole +1){
        auto item = getItem(index);
        return item->enabled;
    }

    if (role != Qt::DisplayRole && role != Qt::EditRole)
        return QVariant();

    TreeItem *item = getItem(index);

    return item->data(index.column());
}

//! [3]
Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable | QAbstractItemModel::flags(index);
}
//! [3]

//! [4]
Q_INVOKABLE TreeItem *TreeModel::getItem(const QModelIndex &index) const
{
    if (index.isValid()) {
        TreeItem *item = static_cast<TreeItem*>(index.internalPointer());
        if (item)
            return item;
    }
    return rootItem;
}
//! [4]

QVariant TreeModel::headerData(int section, Qt::Orientation orientation,
                               int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return rootItem->data(section);

    return QVariant();
}

//! [5]
QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (parent.isValid() && parent.column() != 0)
        return QModelIndex();
//! [5]

//! [6]
    TreeItem *parentItem = getItem(parent);
    if (!parentItem)
        return QModelIndex();

    TreeItem *childItem = parentItem->child(row);
    if (childItem)
        return createIndex(row, column, childItem);
    return QModelIndex();
}
//! [6]

bool TreeModel::insertColumns(int position, int columns, const QModelIndex &parent)
{
    beginInsertColumns(parent, position, position + columns - 1);
    const bool success = rootItem->insertColumns(position, columns);
    endInsertColumns();

    return success;
}

Q_INVOKABLE   bool TreeModel::copyRows(int position,int rows,const QModelIndex &parent ){
    TreeItem *parentItem = getItem(parent);
    if (!parentItem)
        return false;
    TreeItem *lastItem = getItem(last);
    beginInsertRows(parent, position, position + rows - 1);
     TreeItem * success = parentItem->insertChildren1(position,
                                                    rows,
                                                  rootItem->columnCount(),lastItem);
     endInsertRows();

    return success; //TODO check for success of operation







}


Q_INVOKABLE bool TreeModel::insertRows(int position, int rows, const QModelIndex &parent)
{

    TreeItem *parentItem = getItem(parent);
    if (!parentItem)
        return false;
    TreeItem *lastItem = getItem(last);
    beginInsertRows(parent, position, position + rows - 1);

        parentItem->insertChildren(position,
                                                       rows,
                                                     rootItem->columnCount());
        const QModelIndex &child  = this->index(position, 0, parent); //TODO swap this code for smth sane

           this->setData(child,"Data",Qt::EditRole);




//     std::cout << "aaa  " << success->itemData << std::endl;
//     std::cout << "aaa  " << success->itemData << std::endl;


     endInsertRows();
//     emit dataChanged();

    return true; //TODO check for success of operation
}
Q_INVOKABLE bool TreeModel::insertRows1(int position, int rows, const QModelIndex &parent){

//    QDataStream out(&file);
//    out << *this;
//insertRows(parent.row()+1,1,parent.parent());
TreeItem *parentItem = getItem(parent);
if (!parentItem)
    return false;
TreeItem *lastItem = getItem(last);
QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\file.dat");
if(file.open(QIODevice::WriteOnly)){
QDataStream stream( &file );
//stream << *rootItem->child(1);
//serialize(rootItem,stream);


file.close();
}
beginInsertRows(parent, position, position + rows - 1);

    parentItem->insertChildren(position,
                                                   rows,
                                                 rootItem->columnCount());
    const QModelIndex &child  = this->index(position, 0, parent); //TODO swap this code for smth sane

       this->setData(child,"Data",Qt::EditRole);




//     std::cout << "aaa  " << success->itemData << std::endl;
//     std::cout << "aaa  " << success->itemData << std::endl;


 endInsertRows();

return true; //TODO check for success of operation
}
//! [7]
Q_INVOKABLE QModelIndex TreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return QModelIndex();

    TreeItem *childItem = getItem(index);
    TreeItem *parentItem = childItem ? childItem->parent() : nullptr;

    if (parentItem == rootItem || !parentItem)
        return QModelIndex();

    return createIndex(parentItem->childNumber(), 0, parentItem);
}
//! [7]

bool TreeModel::removeColumns(int position, int columns, const QModelIndex &parent)
{
    beginRemoveColumns(parent, position, position + columns - 1);
    const bool success = rootItem->removeColumns(position, columns);
    endRemoveColumns();

    if (rootItem->columnCount() == 0)
        removeRows(0, rowCount());

    return success;
}

Q_INVOKABLE bool TreeModel::removeRows(int position, int rows, const QModelIndex &parent)
{
    TreeItem *parentItem = getItem(parent);
    if (!parentItem)
        return false;

    beginRemoveRows(parent, position, position + rows - 1);
    const bool success = parentItem->removeChildren(position, rows);
    endRemoveRows();

    return success;
}

//! [8]
int TreeModel::rowCount(const QModelIndex &parent) const
{
    const TreeItem *parentItem = getItem(parent);

    return parentItem ? parentItem->childCount() : 0;
}
//! [8]

bool TreeModel::setData(const QModelIndex &index, const QVariant &value, int role)
{

    if (role != Qt::EditRole)
        return false;

    TreeItem *item = getItem(index);
    bool result = item->setData(index.column(), value);

    if (result)
        emit dataChanged(index, index, {Qt::DisplayRole, Qt::EditRole});

    return result;
}

bool TreeModel::setHeaderData(int section, Qt::Orientation orientation,
                              const QVariant &value, int role)
{
    if (role != Qt::EditRole || orientation != Qt::Horizontal)
        return false;

    const bool result = rootItem->setData(section, value);

    if (result)
        emit headerDataChanged(orientation, section, section);


    return result;
}

QHash<int, QByteArray> TreeModel::roleNames() const
    {
    return { {Qt::DisplayRole, "display"},{Qt::EditRole,"edit"} ,{Qt::UserRole +1, "enabled"}};
    }
void TreeModel::saveIndex(const QModelIndex &index){
//    QFile file("C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\file.dat");
//    if(file.open(QIODevice::ReadWrite)){
//    QDataStream stream( &file );
//     deserialize(rootItem,stream);
//    stream >> *rootItem->child(1);
//    }
//    deserialize(rootItem,stream);


//    file.close();
//    }
    last = index;
    return;

}


void TreeModel::setupModelData(const QStringList &lines, TreeItem *parent)
{
    QVector<TreeItem*> parents;
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
                    parents << parents.last()->child(parents.last()->childCount()-1);
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
                parent->child(parent->childCount() - 1)->setData(column, columnData[column]);
        }
        ++number;
    }



}
