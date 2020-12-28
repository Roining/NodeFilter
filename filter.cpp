#include "filter.h"
#include "treeModel.h"
#include "TreeNode.h"
Q_INVOKABLE bool Filtering::getBool() const{
         return sourceModel->cond;//TODO
     }
Q_INVOKABLE void Filtering::setBool(bool var) const{
         sourceModel->cond = var;
     }
Q_INVOKABLE bool Filtering::copyRows(int position, int rows,
                                   const QModelIndex &parent){
    setBool(false);
//    enableFilter(false);
     sourceModel->copyRows(position,rows,mapToSource(parent));
//     enableFilter(true);
     setBool(true);
};
Q_INVOKABLE void Filtering::saveIndex(const QModelIndex &index){

    sourceModel->saveIndex(mapToSource(index));

}
Q_INVOKABLE void Filtering::saveIndex1(const QModelIndex &index){
auto f =  mapToSource(index);

}
Q_INVOKABLE bool Filtering::insertRows(int position, int rows, const QModelIndex &parent)
{
    setBool(false);
//   enableFilter(false);
    sourceModel->insertRows(position,rows,mapToSource(parent));
//    enableFilter(true);
    setBool(true);
}
Q_INVOKABLE void Filtering::setQuery(QString string){
//    enableFilter(true);
    setBool(true);
    query = string;
    invalidateFilter();
    setBool(false);

}

bool Filtering::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const  {
    if(sourceModel->cond){
    QModelIndex index = sourceModel->index(source_row, 0, source_parent);

    auto test =  sourceModel->data(index,0);
  TreeItem *i =  sourceModel->getItem(index);
  if(query == ""){
      return true;
  }
//    if ( sourceModel->data(index,0).toString().contains(query)){

//        return true;
//}
  auto u = sourceModel->match(index,Qt::DisplayRole,"July",10,Qt::MatchContains|Qt::MatchRecursive);
//  auto l = u.isDescendant(i,sourceModel->rootItem->child(1));
  auto m = sourceModel->rootItem->child(1);
//  auto o = sourceModel->getItem(index)->isDescendant(sourceModel->rootItem->child(1),i);

    if(sourceModel->getItem(index)->isDescendant(sourceModel->getItem(sourceModel->last),i))
       return true;

     return false;
    }
    return true;
};
Q_INVOKABLE void Filtering::enableFilter(bool enabled) {
       m_enabled = enabled;
//       invalidateFilter();
   }

Filtering::Filtering(QObject *parent):QSortFilterProxyModel(parent){
//    setSourceModel()
};
Filtering::Filtering(QObject *parent, TreeModel* my):QSortFilterProxyModel(parent){
   sourceModel = my;
  setSourceModel(my);
  setRecursiveFilteringEnabled(true);
 setDynamicSortFilter(true);


};



