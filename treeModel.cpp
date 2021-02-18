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


#include "TreeModel.h"
#include "TreeNode.h"
#include <iostream>
#include <QDataStream>
#include <QDebug>
#include <QClipboard>
#include <QGuiApplication>
#include <string>
#include <QTime>
#include <QRandomGenerator>





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
out << item.acceptsCopies;
qDebug() << "serialising siblings: " << *item.siblings;
//TODO check smwhere if there's more than 1 parent

out << item.tempParents;
out << item.position;




//qDebug << item.itemData;
return out;
}


QDataStream &operator>>(QDataStream &in,  TreeItem *item){


in >> *item->itemData;
in >> item->numberOfChildren; //TODO move out of class members
in >> item->id;
in >>item->acceptsCopies;
//list of parents' ids
in >> item->tempParents;
in >> item->position;


qDebug() << "deserialising parents before: " << *item->siblings;
//in >> *item->parents;
qDebug() << "serialising parents after: " << *item->siblings;

qDebug() << "before " << *item->childItems;

//in >> *temp;




return in;
}

Q_INVOKABLE void TreeModel::deserialize( TreeItem  &node ,QDataStream &stream, bool check){
 if(!check){ // if inserted node is not copied
    stream >> &node;
    if(node.item().toString().contains("Data")){
    auto tr = 5;
    }
    if(node.item().toString().contains("ly 30")){
    auto tr = 5;
    }
    if(node.item().toString().contains("ly 29")){
    auto tr = 5;
    }
    if((node.tempParents.size() >1)&& (!check)){ //temp stores id's of parents.if more than 1 then node is copied further
        map.insert(node.id,&node);// corresponds id of not copied nodes to a pointer to the node
     for(int i = 0; i < node.tempParents.size();i++){

//if(node->temp[i] !=node->parentItem->id){
    container.insert(node.tempParents[i],node.id); //keys are parents, current item(to be copied) is value

     }
//     }
     auto cont = container.find(node.parentItem->id,node.id);
//          container.erase(container.find(node.parentItem->id,node.id));

     if(!node.position.isEmpty()){
//        node.position.erase(node.
//                            position.find(node.parentItem->id,node.parent()->children().indexOf(&node)));
     }
     }}
else{ //if node is copied
     stream >> &node;
}

 if(node.item().toString().contains("heee")){
 auto tr = 5;
 }
 if(node.id.toString() == "{7ccabdf5-c278-4012-a4ec-36ff9bef8ecd}" ){
 auto tr = 5;
 }
 if(node.item().toString().contains("ly 29")){
 auto tr = 5;
 }

     for(int i = 0; i < node.numberOfChildren;i++){
         if(i ==4){
             ;
             auto u = 4;
         }
        if(container.value(node.id) == QUuid()){ //if item is a not parent of a copied item

    deserialize(node.insertChildren2(i,1,0),stream);
        }
        else{


 TreeItem* check1 = nullptr;
auto list = container.values(node.id); //list should contain id's of all potential children
for(int j = 0;j<list.size();j++){
    auto tr = map.value(list[j]);
    auto ht = map.value(list[j])->position.keys();
   for( auto& item : map.value(list[j])->position.keys()){
       auto y = map.value(list[j]);
       auto m = map.value(list[j])->position.value(item);
       auto u = item;

       if(item == node.id&& map.value(list[j])->position.values(item).contains(i)){



       check1 = map.value(list[j]);
//       container.erase(container.find(node.id,list[j]));
       break;
   }
   }
//    auto test = map.value(list[j]);

//    if (map.value(list[j])->position[0] == i){

//        check1 = map.value(list[j]);
////        container.remove(node.id,list[j]);
//        container.erase(container.find(node.id,list[j]));
//        break;

//    }
}
if(check1 != nullptr){
//    auto f = check1; //copy constructor?
    auto o = check1->
            position.find(node.id,i);
//    check1->
//            position.erase(check1->
//                           position.find(node.id,i));

//    container.remove(node->id,container.value(node->id)); //TODO


    deserialize( node.insertChildren1(i,1,0,check1),stream,true);
}
else{
    if(node.item().toString().contains("ly 29")){
    auto tr = 5;
    }
    auto score = map.value(container.value(node.id));
    deserialize(node.insertChildren2(i,1,0),stream);

}
check1 = nullptr;
    }
    }     
return;
}

void TreeModel::serialize1( TreeItem  &node){

    node.tempParents.clear();
    node.position.clear();
    if(node.item().toString().contains("Avoid")){
    auto tr = 5;
    }
    if(node.item().toString().contains("ly 29")){
    auto tr = 5;
    }
    if(node.item().toString().contains("ly 30")){
    auto tr = 5;
    }
    if (node.siblingItems().size() >1){
        //check if item has more than 1 parent; al
    for(int i = 0; i < node.siblingItems().size();i++){
//        if ((*node->parents.get())[i] != nullptr){ //check for nullptr
       node.tempParents.append(node.siblingItems()[i]->parentItem->id);

//        }
    }
    }
    if (node.siblingItems().size() >1){//TODO: repeats condition above?
        TreeItem* check = nullptr;
        for(int i = 0; i < node.siblingItems().size();i++){

if( !(node.siblingItems()[i]->position.isEmpty())){
                    check = node.siblingItems()[i];
                }           
        }
   if(check !=nullptr){
       check->position.insert(node.parentItem->id,node.parent()->children().indexOf(&node));

   }
   else{
       node.position.insert(node.parentItem->id,node.parent()->children().indexOf(&node));
   }

    }

node.numberOfChildren = node.childCount();
if(node.childCount()){ //TODO replace with numberOfChildren?
    for(int i = 0; i < node.childCount();i++){


        serialize1(*node.children()[i]);

    }
}
}

Q_INVOKABLE void TreeModel::serialize( TreeItem  &node ,QDataStream &stream){
    stream << node;

if(node.childCount()){ //TODO replace with numberOfChildren?
    for(int i = 0; i < node.childCount();i++){

        serialize(*(node.children()[i]),stream);

    }
}

return;
}


Q_INVOKABLE void TreeModel::log(){
    QString path = "C:\\Users\\medve\\Documents\\build-untitled-Desktop_Qt_5_15_1_MinGW_64_bit-Debug\\debug\\";
    QFile file(QStringLiteral("%1\\file.dat").arg(path));
     int value = QRandomGenerator::global()->generate();
   auto test =  file.copy(QStringLiteral("%1\\file.dat").arg(path), QStringLiteral("%1\\SavedFilesCache\\fileCacheo%2.dat").arg(path).arg(value));
    if(file.open(QIODevice::WriteOnly|QIODevice::Truncate)){
    QDataStream stream( &file );
//    rootItem->numberOfChildren = rootItem->childCount();
    serialize1(*rootItem);
        serialize(*rootItem,stream);
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
deserialize(*rootItem,stream);

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
    if(role == Qt::UserRole +2){
        auto item1 = getItem(index);
        auto check = item1->id.toString();
        return item1->id.toString();
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
//!
//TreeItem* TreeModel::getItemFromId(QUuid id){
//   return 0;
//}
bool TreeModel::isDescendantFromId(QUuid parent,QUuid child){
    auto parentItem = map.value(parent);
    auto childItem = map.value(child);
    bool result;
    while(true){
    if(childItem->parent() == nullptr){
        result =  false;
        return  result;
    }
    else if((childItem->parent() == parentItem)||(childItem == parentItem)){
        result = true;
        return result;
//    if(child->parent() != parent)
    }
     else  {
           childItem = childItem->parent();

            }
    };
};
Q_INVOKABLE QString TreeModel::getId(const QModelIndex &index){
    auto item = getItem(index);
    QString string = item->id.toString();
    return string;
}
Q_INVOKABLE void TreeModel::getIdToClipboard(const QModelIndex &index){
    QClipboard *clipboardItem = QGuiApplication::clipboard();
    clipboardItem->setText(getId(index));


}

bool TreeModel::insertColumns(int position, int columns, const QModelIndex &parent)
{
    beginInsertColumns(parent, position, position + columns - 1);
    const bool success = rootItem->insertColumns(position, columns);
    endInsertColumns();

    return success;
}
Q_INVOKABLE QPersistentModelIndex TreeModel::getLastIndex(){
    return last;
}
Q_INVOKABLE   bool TreeModel::copyRows1(int position,int rows,const QModelIndex &parent,const QPersistentModelIndex &source ){
    TreeItem *parentItem = getItem(parent);

    if (!parentItem){
        return false;}
    TreeItem *lastItem = getItem(source);
    lastItem = getItem(source);
//    if(!lastItem->enabled){
//        qDebug() << "Not enabled";
//        return false;
//    }
    if(isDescendant(lastItem,parentItem,true)){
        qDebug() << "Parent item descends from inserted item";
        return false;
    }
    beginInsertRows(parent, position, position + rows - 1);
     TreeItem & success = parentItem->insertChildren1(position,
                                                rows,
                                                  rootItem->columnCount(),lastItem);
     this->setData(index(position,0, parent),"Data",Qt::UserRole +2);

     endInsertRows();


     for(int i = 0; i < lastItem->childCount();i++){
          QPersistentModelIndex  itemIndex = index(position,0, parent);
         copyRows1(i, 1, itemIndex,index(i,0, source) );

     }

    return true; //TODO check for success of operation







}


Q_INVOKABLE   bool TreeModel::copyRows(int position,int rows,const QModelIndex &parent,const QPersistentModelIndex &source ){
//   copyRows1(position,rows,parent,source);
   TreeItem *parentItem = getItem(parent);
   if (!parentItem){
       return false;}


       if( parentItem->siblingItems().size() >1){
  for(int i = 0; i < parentItem->siblingItems().size();i++){

  auto sibling =  parentItem->siblingItems()[i];
  if((parentItem->siblingItems()[i]->acceptsCopies)||(parentItem->siblingItems()[i]->id == parentItem->id)){
  auto check = sibling->id.toString();
  auto siblingIndex = match(index( 0, 0 ),Qt::UserRole +2,sibling->id.toString(),1,Qt::MatchRecursive);

  auto res = sibling->id.toString();

  copyRows1(position,1,siblingIndex[0],source);
          }
       }
   }

       else{
          copyRows1(position,rows,parent,source);
       }

updateProxyFilter();
   return true;
}
//bool TreeModel::isDescendant(TreeItem *parent,TreeItem *child){
//    result = false;
//  for(int i = 0;i < parent->childItems->size();i++){
//      auto* m = (*parent->childItems.get())[i];
//      auto* y  = child;
//      if(*(*parent->childItems.get())[i] == *child){
//          *(*parent->childItems.get())[i] == *child;
//          result = true;
//          return result;
//      }
//      else{
//          isDescendant((*parent->childItems.get())[i],child);
//      }

//  }
//  return result;
//};
  void TreeModel::acceptsCopies(const QModelIndex &index, bool acceptsCopies){
    auto item = getItem(index);
    item->acceptsCopies = acceptsCopies;
}
bool TreeModel::isDescendant(TreeItem *parent,TreeItem *child,bool searchClones){

    if(parent == child){


        return true;
    }
    else if(searchClones){
        if(*parent == *child){


            return true;
        }
    }

         for(int i = 0;i < parent->childItems->size();i++){
             if(searchClones){
                 if(isDescendant((*parent->childItems.get())[i],child,true)){
                     return true;
                 }

             }
             else{
             if(isDescendant((*parent->childItems.get())[i],child)){
                 return true;
             }
             }
         }


  return false;
};

TreeItem* TreeModel::isDescendant1(TreeItem *parent,TreeItem *child,bool searchClones){

    if(*parent == *child){


        return parent;
    }
    else if(searchClones){
        if(*parent == *child){


            return parent;
        }
    }

         for(int i = 0;i < parent->childItems->size();i++){
             if(searchClones){

                 if(isDescendant1((*parent->childItems.get())[i],child,true)){
                     return parent;
                 }

             }
             else{
                 auto item = isDescendant1((*parent->childItems.get())[i],child);
                 if(item){
                     return item;
                 }
//             if(isDescendant1((*parent->childItems.get())[i],child)){
//                 return child;
//             }
             }
         }


  return nullptr;
};
//bool TreeModel::isDescendant(TreeItem *parent,TreeItem *child){
//    result = false;
//    if(parent == child){

//        result = true;
//        return result;
//    }
//    else{
//         for(int i = 0;i < parent->childItems->size();i++){
//             if(isDescendant((*parent->childItems.get())[i],child)){
//                 return result;
//             }
//         }
//    }

//  return result;
//};
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
Q_INVOKABLE bool TreeModel::insertRows1(int position, int rows, const QModelIndex &parent,bool transclusion){
TreeItem *parentItem = getItem(parent);
if (!parentItem)
    return false;

beginInsertRows(parent, position, position + rows - 1);

    parentItem->insertChildren(position,
                                                   rows,
                                                 rootItem->columnCount());
    const QModelIndex &child  = this->index(position, 0, parent); //TODO swap this code for smth sane

       this->setData(child,"Data",Qt::EditRole);
    this->setData(child,"Data",Qt::UserRole +2);
 endInsertRows();
// if(transclusion){
if(parentItem->siblingItems().size() > 1){
    QVector<TreeItem*> siblingCopy = (parentItem->siblingItems());
    siblingCopy.erase(std::find( siblingCopy.begin(),  siblingCopy.end(), parentItem));
for(int i = 0; i < siblingCopy.size();i++){

auto sibling =  siblingCopy[i];
if(sibling->acceptsCopies|| !transclusion){
auto check = sibling->id.toString();
auto siblingIndex = match(index( 0, 0 ),Qt::UserRole +2,sibling->id.toString(),1,Qt::MatchRecursive);

auto res = sibling->id.toString();
copyRows1(position,1,siblingIndex[0],child);
}


        }
}
//}


updateProxyFilter();
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
    if (!parentItem){
        return false;}
    const QModelIndex &child  = this->index(position, 0, parent);

   for(int i = 0; i < parentItem->siblingItems().size();i++){

   auto sibling =  parentItem->siblingItems()[i];
   auto check = sibling->id.toString();
   auto siblingIndex = match(index( 0, 0 ),Qt::UserRole +2,sibling->id.toString(),1,Qt::MatchRecursive);
   auto res = sibling->id.toString();
   if(siblingIndex.isEmpty()){
       beginRemoveRows(QModelIndex(), position, position + rows - 1);
       const bool success = sibling->removeChildren(position, rows);

        endRemoveRows();
   }
   else{
   beginRemoveRows(siblingIndex[0], position, position + rows - 1);
   const bool success = sibling->removeChildren(position, rows);

    endRemoveRows();
   }
             //  parentItem->position.append((*parentItem->parents.get())[i]->childItems->indexOf(&(*(*(*(*parentItem->parents.get())[i]).childItems.get())[j])));




           }




updateProxyFilter();
    return true;
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
    if(role == Qt::UserRole +2){
          TreeItem *item = getItem(index);
          if(item->id == QUuid()){
          item->id = item->id.createUuid();
          }
           emit dataChanged(index, index,  {Qt::UserRole +2});
return true;
    }

    if (role != Qt::EditRole)
        return false;

    TreeItem *item = getItem(index);
    bool result = item->setData(index.column(), value);

    if (result)
        emit dataChanged(index, index, {Qt::DisplayRole, Qt::EditRole, Qt::UserRole +2});

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
    return { {Qt::DisplayRole, "display"},{Qt::EditRole,"edit"} ,{Qt::UserRole +1, "enabled"}, {Qt::UserRole +2, "id"}};
    }
void TreeModel::saveIndex(const QModelIndex &index){

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
