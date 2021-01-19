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
         return sourceModel->cond;//TODO
     }
Q_INVOKABLE void Filtering::setBool(bool var) const{
         sourceModel->cond = var;
         return;
     }
Q_INVOKABLE bool Filtering::copyRows(int position, int rows,
                                   const QModelIndex &parent){
    setBool(false);

     sourceModel->copyRows(position,rows,mapToSource(parent));

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
Q_INVOKABLE bool Filtering::insertRows(int position, int rows, const QModelIndex &parent)
{
    setBool(false);


    sourceModel->insertRows1(position,rows,mapToSource(parent));

    setBool(true);
    return true;
}
Q_INVOKABLE void Filtering::setQuery(QString string){

    setBool(true);


    query = string;
    invalidateFilter();
    setBool(false);
    return;

}

bool Filtering::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const  {

    if(sourceModel->cond){

    QModelIndex index = sourceModel->index(source_row, 0, source_parent);
     TreeItem *p =  sourceModel->getItem(index);
     p->enabled =true;
QStringList container = query.split(QRegExp("\\s"));
auto y = container.size();
auto k = query.mid(2);
if(query == ""){
p->enabled =false;
    return true;
}
for(int i =0;i < container.size();i++){

   if( container[i].startsWith("q:")){

        if (!(sourceModel->data(index,0).toString().contains(container[i].mid(2), Qt::CaseInsensitive	))){
p->enabled =false;
               return false;
       }
   }
  if( container[i].startsWith(">")){
   if(!(sourceModel->getItem(index)->isDescendant(sourceModel->getItem(sourceModel->last),p))){
//       p->enabled =false;
          return false;}

   }
   if( container[i].startsWith("<")){
       if(!(sourceModel->getItem(index)->isDescendant(p,sourceModel->getItem(sourceModel->last)))){
//           p->enabled =false;
          return false;}
   }
}

return true;
    auto test =  sourceModel->data(index,0);


  auto u = sourceModel->match(index,Qt::DisplayRole,"July",10,Qt::MatchContains|Qt::MatchRecursive);
  auto m = sourceModel->rootItem->child(1);


    if(sourceModel->getItem(index)->isDescendant(sourceModel->getItem(sourceModel->last),p))
       return true;

     return false;
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
  setDynamicSortFilter(true);
};
//Filtering::Filtering(QObject *parent, TreeModel* my):QSortFilterProxyModel(parent){
//   sourceModel = my;
//  setSourceModel(my);
//  setRecursiveFilteringEnabled(true);
// setDynamicSortFilter(true);


//};



