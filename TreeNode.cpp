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



#include "TreeNode.h"
#include <iostream>


TreeItem::TreeItem(const QVector<QVariant> data, TreeItem *parent)
    : itemData(std::make_shared<QVector<QVariant>>(data)),
      parentItem(parent),childItems(std::make_shared<QVector<TreeItem*>>()),id(id.createUuid()),acceptsCopies(true),siblings(std::make_shared<QVector<TreeItem*>>())
{

siblings->append(this);
}

TreeItem& TreeItem::operator=( TreeItem& other){
   if(&other !=this)
   {

//        parentItem = &other;
        parentItem = nullptr;
//        acceptsCopies = other.acceptsCopies;
        siblings = other.siblings;//TODO1: setParent alternative
siblings->append(this);
        itemData = other.itemData;
//        parents.append(other.id);
//         other.copyChildren.append(this->id);
        //        childItems = other.childItems;

   }
   return *this;
}
TreeItem::TreeItem( TreeItem& other){
    childItems = other.childItems;
//    if(parentItem){
//        parents->remove(parents->indexOf(parentItem)); //TODO is parentItem properly cleaned up?
//    }
    parentItem = &other;
//    acceptsCopies = other.acceptsCopies;
    siblings = other.siblings;
    siblings->append(this);
    parents.append(other.id);
    other.copyChildren.append(this->id);
    itemData = other.itemData;
}

//! [1]
TreeItem::~TreeItem()
{
//    for(int i = 0;i< childItems->size();i++){
//      (*childItems.get())[i]->parents->erase(std::find( (*childItems.get())[i]->parents->begin(),  (*childItems.get())[i]->parents->end(), this));

//    }
    siblings->erase(std::find( siblings->begin(),  siblings->end(), this)); //TODO switch to siblings
   for(int i = 0;i <siblings->size();i++){
if(!parents.isEmpty()){
   if(siblingItems()[i]->id ==  parents[0]){
//       delete siblingItems()[i];
       siblingItems()[i]->copyChildren.erase(std::find( siblingItems()[i]->copyChildren.begin(),  siblingItems()[i]->copyChildren.end(),  id));
     siblingItems()[i]->copyChildren.append(copyChildren);
   }
}

   }
   for(int i = 0;i <siblings->size();i++){

      if( copyChildren.contains(siblingItems()[i]->id)){
          siblingItems()[i]->parents.clear();
          if(!parents.isEmpty()){
               siblingItems()[i]->parents.append(parents[0]);
          }


      }


//       delete siblingItems()[i];
//       siblingItems()[i]->copyChildren.erase(std::find( siblingItems()[i]->copyChildren.begin(),  siblingItems()[i]->copyChildren.end(),  id));



   }


    qDeleteAll(*childItems);
//    childItems->clear();//TODO double check if valid



}
bool TreeItem::operator==(const TreeItem& other) const{
    auto i1 = this->itemData;
    auto u1 = other.itemData;
    auto comp = this->itemData == other.itemData;
    auto i = (*this->itemData.get());
    auto u = (*other.itemData.get());
    auto h = (this->itemData.get()[0]) == (other.itemData.get()[0]);
        auto ye = (this->itemData.get()[0][0]) == (other.itemData.get()[0][0]);
    auto t = (this->itemData.get()[0][0]);
    auto e = (other.itemData.get()[0][0]);
    auto t1 = (this->itemData.get()[0]);
    auto e2 = (other.itemData.get()[0]);
    if((this->itemData->contains("July 31"))){
            auto rt = 45;
}
//    return (this->itemData.get()[0]) == (other.itemData.get()[0]);
//    return (this->itemData.get()[0][0]) == (other.itemData.get()[0][0]);
//    return (*this->itemData.get()) ==(*other.itemData.get());
//    return this->itemData == other.itemData;
    if((this->itemData.get()) == (other.itemData.get())){
        auto ty = 8;
    }
    return (this->itemData.get()) == (other.itemData.get());
}
//! [1]
//!

//! [2]
TreeItem *TreeItem::child(int number)
{
    if (number < 0 || number >= childItems->size())
        return nullptr;
    return childItems->at(number);
}
//! [2]3

QVariant& TreeItem::item(){
    return (itemData.get())[0][0];
}
QVector<TreeItem*>& TreeItem::siblingItems(){
    return *(siblings.get());
}
QVector<TreeItem*>& TreeItem::children(){
    return *(childItems.get());
}
void TreeItem::setParent(TreeItem *parent){
//    if(parentItem){
//        parents->remove(parents->indexOf(parentItem)); //TODO is parentItem properly cleaned up?
//    }
    parentItem = parent;

//    siblings->append(parent); //TODO1

}
//! [3]
int TreeItem::childCount() const
{
    return childItems.get()->count();
}
//! [3]

//! [4]
int TreeItem::childNumber() const
{
    if (parentItem)
        return parentItem->childItems->indexOf(const_cast<TreeItem*>(this));
    return 0;
}
//! [4]

//! [5]
int TreeItem::columnCount() const
{
    return itemData->count();
}
//! [5]

//! [6]
QVariant TreeItem::data(int column) const
{
    if (column < 0 || column >= itemData->size())
        return QVariant();
    return itemData->at(column);
}
//! [6]
TreeItem & TreeItem::insertChildren12(int position, int count, int columns,  TreeItem *parent)
{
   if (position < 0 || position > childItems->size())
       return *children()[0];

   for (int row = 0; row < count; ++row) {
       QVector<QVariant> data(columns);
       TreeItem *item = new TreeItem(data, this);
       *item = *parent;

       item->setParent(this);
       childItems->insert(position, item);

   }
   return *children()[position];
}

TreeItem & TreeItem::insertChildren1(int position, int count, int columns,  TreeItem *parent)
{
   if (position < 0 || position > childItems->size())
       return *children()[position];

   for (int row = 0; row < count; ++row) {
       QVector<QVariant> data(columns);
       TreeItem *item = new TreeItem(data, this);
       *item = *parent;
       item->parents.append(parent->id);
        parent->copyChildren.append(item->id);
       item->setParent(this);
       childItems->insert(position, item);

   }
   return *children()[position];
}
TreeItem * TreeItem::insertChildrenRecursive(int position, int count, int columns,  TreeItem *copiedItem)
{
   if (position < 0 || position > childItems->size())
       return (*childItems.get())[0];

   for (int row = 0; row < count; ++row) {
       QVector<QVariant> data(columns);
       TreeItem *item = new TreeItem(data, this);
       *item = *copiedItem;
       item->setParent(this);
       childItems->insert(position, item);
        for(int i = 0; i < copiedItem->childCount();i++){
            insertChildrenRecursive(i, 0,0, (*copiedItem->childItems.get())[i] );
        }

   }
   return (*childItems.get())[position];
}
//! [7]
 TreeItem * TreeItem::insertChildren(int position, int count, int columns)
{
    if (position < 0 || position > childItems->size())
        return (*childItems.get())[0];

    for (int row = 0; row < count; ++row) {
        QVector<QVariant> data(columns);
        TreeItem *item = new TreeItem(data, this);
        childItems->insert(position, item);

    }

    return (*childItems.get())[position];
}
//! [7]
 TreeItem & TreeItem::insertChildren2(int position, int count, int columns)
{
    if (position < 0 || position > childItems->size())
        return *(children()[0]);

    for (int row = 0; row < count; ++row) {
        QVector<QVariant> data(columns);
        TreeItem *item = new TreeItem(data, this);

        childItems->insert(position, item);

    }

    return *(children()[position]);
}
//! [8]
bool TreeItem::insertColumns(int position, int columns)
{
    if (position < 0 || position > itemData->size())
        return false;

    for (int column = 0; column < columns; ++column)
        itemData->insert(position, QVariant());

    for (TreeItem *child : qAsConst(*childItems))
        child->insertColumns(position, columns);

    return true;
}
//! [8]

//! [9]
//!
bool TreeItem::
isDescendantOfItself(TreeItem *parent,TreeItem *child){

    bool result;
    while(true){
    if(!child->parent()){
        result =  false;
        return  result;
    }
    else if((*(child->parent()) == *parent)||(*(child) == *parent)){
        result = true;
        return result;
//    if(child->parent() != parent)
    }
     else  {
           child = child->parent();

            }
    };
};


TreeItem *TreeItem::parent()
{
    return parentItem;
}
//! [9]

//! [10]
bool TreeItem::removeChildren(int position, int count)
{
    if (position < 0 || position + count > childItems->size())
        return false;

    for (int row = 0; row < count; ++row)
        delete childItems->takeAt(position);

    return true;
}
//! [10]

bool TreeItem::removeColumns(int position, int columns)
{
    if (position < 0 || position + columns > itemData->size())
        return false;

    for (int column = 0; column < columns; ++column)
        itemData->remove(position);

    for (TreeItem *child : qAsConst(*childItems))
        child->removeColumns(position, columns);

    return true;
}

//! [11]
bool TreeItem::setData(int column, const QVariant &value)
{
    if (column < 0 || column >= itemData->size())
        return false;
(*itemData.get())[column] = value ;
//(*t)[column] = value;
// this->itemData[column] = value;
    return true;
}
//! [11]
