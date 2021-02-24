#include "filter.h"
#include "treeModel.h"
#include "TreeNode.h"
#include <functional>
#include <QRegularExpression>

TreeModel myClass1(nullptr); //TODO
Q_INVOKABLE bool Filtering::log()
{

     sourceModel->log();
return true;
}
Q_INVOKABLE bool Filtering::removeRows(int position, int rows, const QModelIndex &parent)
{
//    setBool(false);
     sourceModel->removeRows(position,rows,mapToSource(parent));

//     setBool(true);
     return true;
}
Q_INVOKABLE bool Filtering::getBool() const{
         return cond;//TODO
     }
Q_INVOKABLE void Filtering::setBool(bool var) {
         cond = var;
         return;
     }
Q_INVOKABLE bool Filtering::copyRows(int position, int rows,
                                   const QModelIndex &parent, const QPersistentModelIndex &source){
//    setBool(false);

     sourceModel->copyRows(position,rows,mapToSource(parent),sourceModel->getLastIndex());

//     setBool(true);
     return true;
};
Q_INVOKABLE void Filtering::saveIndex(const QModelIndex &index){

    sourceModel->saveIndex(mapToSource(index));
    return;

}
Q_INVOKABLE void Filtering::acceptsCopies(const QModelIndex &index, bool acceptsCopies){
   sourceModel->acceptsCopies(mapToSource(index),acceptsCopies);
   return;
}
Q_INVOKABLE void Filtering::saveIndex1(const QModelIndex &index){
auto f =  mapToSource(index);

}
bool Filtering::lessThan(const QModelIndex& left, const QModelIndex &right ) const{
    auto leftItem = sourceModel->getItem(left);
    auto rightItem = sourceModel->getItem(right);
    if(leftItem->item().toString().contains("Book")){
    auto tr = 5;
    }
    if(rightItem->item().toString().contains("Book")){
        auto tr = 5;
        }


    QVariant leftData = sourceModel->data(left, Qt::DisplayRole);
    QVariant rightData = sourceModel->data(right, Qt::DisplayRole);
   auto itemId =  query.mid(query.lastIndexOf(":")+1);
   auto itemIndex = sourceModel->match(sourceModel->index( 0, 0 ),Qt::UserRole +2,itemId,1,Qt::MatchRecursive);
   if(itemIndex.isEmpty()){
       return false;
   }
   auto queryItem = sourceModel->getItem(itemIndex[0]);
auto leftResult = sourceModel->isDescendant1(leftItem,queryItem);
auto rightResult = sourceModel->isDescendant1(rightItem,queryItem);
   if(!(sourceModel->isDescendant1(leftItem,queryItem))||!(sourceModel->isDescendant1(rightItem,queryItem))){
       return false;
   }
//    auto log = QString::localeAwareCompare(leftData.toString(), rightData.toString()) < 0;
    if(query.contains("sortNAsc:")){
//    return leftData.toInt() < rightData.toInt();
        if(leftResult->childCount()&&rightResult->childCount()){
        return sourceModel->isDescendant1(leftItem,queryItem)->children()[0]->item().toInt() < sourceModel->isDescendant1(rightItem,queryItem)->children()[0]->item().toInt();
        }
    }
    else if(query.contains("sortNDesc:")){
//       return leftData.toInt() > rightData.toInt();
        if(leftResult->childCount()&&rightResult->childCount()){
        return sourceModel->isDescendant1(leftItem,queryItem)->children()[0]->item().toInt() > sourceModel->isDescendant1(rightItem,queryItem)->children()[0]->item().toInt();
        }
    }
    else if(query.contains("sortAAsc:")){
//        return leftData.toString() < rightData.toString();
        if(leftResult->childCount()&&rightResult->childCount()){
        return sourceModel->isDescendant1(leftItem,queryItem)->children()[0]->item() < sourceModel->isDescendant1(rightItem,queryItem)->children()[0]->item();
        }
    }
    else if(    query.contains("sortADesc:")){
//        return leftData.toString() < rightData.toString();
        if(leftResult->childCount()&&rightResult->childCount()){
        return sourceModel->isDescendant1(leftItem,queryItem)->children()[0]->item() < sourceModel->isDescendant1(rightItem,queryItem)->children()[0]->item();
        }
    }
    else{
        return leftData.toString() < rightData.toString();
    }

}

Q_INVOKABLE QString Filtering::getId(const QModelIndex &index){
    return sourceModel->getId(mapToSource(index));
}
Q_INVOKABLE bool Filtering::insertRows(int position, int rows, const QModelIndex &parent, bool transclusion)
{
//    setBool(false);

    if(transclusion){
    sourceModel->insertRows1(position,rows,mapToSource(parent));
    }
    else{
        sourceModel->insertRows1(position,rows,mapToSource(parent),false);

    }

//    setBool(true);
    return true;
}

Q_INVOKABLE void Filtering::getIdToClipboard(const QModelIndex &index){
sourceModel->getIdToClipboard(mapToSource(index));
}
Q_INVOKABLE void Filtering::setQuery(QString string){


//if(query !=string){
//    setBool(true);
 queryChanged = true;
    query = string;
    if(query.contains("sort")){
    sort(0);
    }
    else{
    sort(-1);
    }
     invalidateFilter();
     queryChanged = false;

//setBool(true);
//}
    return;

}
//bool Filtering::ItemFilter(std::function<bool()>);
bool Filtering::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const  {

QModelIndex index = sourceModel->index(source_row, 0, source_parent);
 TreeItem *currentItem =  sourceModel->getItem(index);
 if(query == ""){

    currentItem->enabled =true;
    return true;
 }

//     currentItem->enabled =true;
//QStringList container = query.split(QRegExp("\\s"));
QStringList container = query.split("~");


bool finalResult = true;

for(int i =0;i < container.size();i++){
bool innerResult = true;
//if( container[i].startsWith("sort:")){
//    sourceModel->sort(0);
//    currentItem->enabled =true;
//   return true;
//}
 if( container[i].startsWith("r:")){
    auto string = container[i].mid(2);
    QRegularExpression regex(string);
    QRegularExpressionMatch match = regex.match(sourceModel->data(index,0).toString());
    if(!match.hasMatch()){
         currentItem->enabled =false;
        return false;
    }
}
//sourceModel->data(index,0).toString().contains(container[i].mid(2), Qt::CaseInsensitive	);

 else if( container[i].startsWith(">")){
    auto query = container[i].section(":",-1);
    auto itemIndex = sourceModel->match(sourceModel->index( 0, 0 ),Qt::UserRole +2,query,1,Qt::MatchRecursive);
    if(itemIndex.isEmpty()){
        return false;
    }
    auto parentItem = sourceModel->getItem(itemIndex[0]);
    if(!parentItem){
        return false; // check if item id is valid
    }

    if(container[i].startsWith(">>")){
        innerResult =false;
        for(int i = 0;i < parentItem->siblingItems().size();i++){
     if(sourceModel->isDescendant( parentItem->siblingItems()[i],currentItem,true)){
     innerResult =true;
     break;
        }
}

    }
    else{
     innerResult = sourceModel->isDescendant(parentItem,currentItem);
    }
    bool isInclusive = i>0 && container[i-1] == "OR";
    bool isInversed = i>0 && container[i-1] == "NOT";

    if(innerResult){
        if(isInclusive){
            currentItem->enabled =true;
            return true;


        }
        if(isInversed){
            currentItem->enabled =false;
            return false;
        }
    }
    else{
        if(isInclusive){
          finalResult = false;


        }

     if(!isInversed &&!isInclusive){


         currentItem->enabled =false;
         return false;


     }


     }
   }
  else if( container[i].startsWith("<")){
       auto query = container[i].section(":",-1);
       auto itemIndex = sourceModel->match(sourceModel->index( 0, 0 ),Qt::UserRole +2,query,1,Qt::MatchRecursive);
       if(itemIndex.isEmpty()){
           return false;
       }
       auto parentItem = sourceModel->getItem(itemIndex[0]);
       if(!parentItem){
           return false; // check if item id is valid
       }

       if(container[i].startsWith("<<")){
        innerResult = sourceModel->isDescendant( currentItem,parentItem,true);
   }
       else{
        innerResult = sourceModel->isDescendant(currentItem,parentItem);
       }
       bool isInclusive = i>0 && container[i-1] == "OR";
       bool isInversed = i>0 && container[i-1] == "NOT";

       if(innerResult){
           if(isInclusive){
               currentItem->enabled =true;
               return true;


           }
           if(isInversed){
               currentItem->enabled =false;
               return false;
           }
       }
       else{
           if(isInclusive){
             finalResult = false;


           }

        if(!isInversed &&!isInclusive){


            currentItem->enabled =false;
            return false;


        }


        }
   }
 else {
      auto trimmedQuery = container[i].section(":",-1);
 //     QStringList words = trimmedQuery.split("\\s");
      QStringList words = trimmedQuery.split(QRegExp("\\s"));
 //     TreeItem *itemPtr = currentItem;
          auto string = container[i].mid(2);
 //         auto u = (itemPtr)->item().toString();
      bool result = false;
      bool contains = false;
      for(int i = 0;i <words.size();i++){
 if(currentItem->item().toString().contains(words[i], Qt::CaseInsensitive)){
 contains = true;}
      }
      if(contains == true){
      for(int i = 0;i <words.size();i++){
          TreeItem *itemPtr = currentItem;
      while(true){

      if((((itemPtr)->item().toString().contains(words[i], Qt::CaseInsensitive)) )){
          result = true;
         break;
  //    if(child->parent() != parent)
      }
     else if(!itemPtr->parent()){
          result =  false;
          break;

      }
       else  {
             itemPtr = itemPtr->parent();

              }
      }
      if(result == false){
          break;
      }
      }
  }
      innerResult = result;
 //               innerResult = sourceModel->data(index,0).toString().contains(container[i].mid(2), Qt::CaseInsensitive	);
                bool isInclusive = i>0 && container[i-1] == "OR";
                bool isInversed = i>0 && container[i-1] == "NOT";

                if(innerResult){
                    if(isInclusive){
                        currentItem->enabled =true;
                        return true;


                    }
                    if(isInversed){
                        currentItem->enabled =false;
                        return false;
                    }
                }
                else{
                    if(isInclusive){
                      finalResult = false;


                    }

                 if(!isInversed &&!isInclusive){


                     currentItem->enabled =false;
                     return false;


                 }


                 }
    }

}
currentItem->enabled =finalResult;
return finalResult;
      return true;
};
Q_INVOKABLE void Filtering::enableFilter(bool enabled) {
       m_enabled = enabled;
//       invalidateFilter();
       return;
   }

Filtering::Filtering(QObject *parent):QSortFilterProxyModel(parent){
//    setSourceModel()
    sourceModel = &myClass1;
   setSourceModel(&myClass1);
   setRecursiveFilteringEnabled(true);
  setDynamicSortFilter(false);
  QObject::connect(&myClass1,&TreeModel::updateProxyFilter,this,&Filtering::updateFilter);
};
//Filtering::Filtering(QObject *parent, TreeModel* my):QSortFilterProxyModel(parent){
//   sourceModel = my;
//  setSourceModel(my);
//  setRecursiveFilteringEnabled(true);
// setDynamicSortFilter(true);


//};



