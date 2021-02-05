#include "filter.h"
#include "treeModel.h"
#include "TreeNode.h"
TreeModel myClass1(nullptr); //TODO
Q_INVOKABLE bool Filtering::log()
{

     sourceModel->log();
return true;
}
Q_INVOKABLE bool Filtering::removeRows(int position, int rows, const QModelIndex &parent)
{
    setBool(false);
     sourceModel->removeRows(position,rows,mapToSource(parent));
     setBool(true);
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
    setBool(false);

     sourceModel->copyRows(position,rows,mapToSource(parent),sourceModel->getLastIndex());

     setBool(true);
     return true;
};
Q_INVOKABLE void Filtering::saveIndex(const QModelIndex &index){

    sourceModel->saveIndex(mapToSource(index));
    return;

}
Q_INVOKABLE void Filtering::saveIndex1(const QModelIndex &index){
auto f =  mapToSource(index);

}
Q_INVOKABLE QString Filtering::getId(const QModelIndex &index){
    return sourceModel->getId(mapToSource(index));
}
Q_INVOKABLE bool Filtering::insertRows(int position, int rows, const QModelIndex &parent)
{
    setBool(false);


    sourceModel->insertRows1(position,rows,mapToSource(parent));

    setBool(true);
    return true;
}
Q_INVOKABLE void Filtering::getIdToClipboard(const QModelIndex &index){
sourceModel->getIdToClipboard(mapToSource(index));
}
Q_INVOKABLE void Filtering::setQuery(QString string){


if(query !=string){
//    setBool(true);
 queryChanged = true;
    query = string;
    QElapsedTimer timer;
        timer.start();

        invalidateFilter();

        qDebug() << "The slow operation took" << timer.elapsed() << "milliseconds";

//    setBool(false);
        queryChanged = false;
}
    return;

}

bool Filtering::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const  {

if(query == ""){

//currentItem->enabled =false;
    return true;
}
QElapsedTimer timer;
    timer.start();



if(queryChanged){
if(getBool()){
//bool result = true;
QModelIndex index = sourceModel->index(source_row, 0, source_parent);
 TreeItem *currentItem =  sourceModel->getItem(index);


//     currentItem->enabled =true;
QStringList container = query.split(QRegExp("\\s"));
for(int i =0;i < container.size();i++){

   if( container[i].startsWith("q:")){

        if (!(sourceModel->data(index,0).toString().contains(container[i].mid(2), Qt::CaseInsensitive	))){
currentItem->enabled =false;
               return false;
       }
   }
  if( container[i].startsWith(">")){
//      sourceModel->result = false;
    auto query = container[i].section(":",-1);
//    auto item = sourceModel->map.value(query);

    auto itemIndex = sourceModel->match(sourceModel->index( 0, 0 ),Qt::UserRole +2,query,1,Qt::MatchRecursive);
    if(itemIndex.isEmpty()){
        return false;
    }
    auto parentItem = sourceModel->getItem(itemIndex[0]);
    if(!parentItem){
        return false; // check if item id is valid
    }
//    bool isDescendant = sourceModel->result; //use result for reliable info
    qDebug() << "Before calling isDescendant()" << timer.elapsed() << "milliseconds";
    QElapsedTimer timer;
        timer.start();

    bool isDescendant = false;
    if(container[i].startsWith(">>")){
     isDescendant = sourceModel->isDescendant(parentItem ,currentItem,true);
}
    else{
     isDescendant = sourceModel->isDescendant(parentItem ,currentItem);
    }//use result for reliable info
    qDebug() << "isDescendant" << timer.elapsed() << "milliseconds";
    bool isInclusive = i>0 && container[i-1] == "OR";
    bool isInversed = i>0 && container[i-1] == "NOT";
       if(isDescendant){
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

        if(!isInversed && !isInclusive){

       currentItem->enabled =false;
          return false;

        }

        }


   }
   if( container[i].startsWith("<")){
       if(!(sourceModel->getItem(index)->isDescendantOfItself(currentItem,sourceModel->getItem(sourceModel->last)))){ //remove this part entirely?
//           p->enabled =false;
          return false;}
   }
}

return true;




     return false;
    }
}

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
};
//Filtering::Filtering(QObject *parent, TreeModel* my):QSortFilterProxyModel(parent){
//   sourceModel = my;
//  setSourceModel(my);
//  setRecursiveFilteringEnabled(true);
// setDynamicSortFilter(true);


//};



