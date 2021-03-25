#ifndef FILTER_H
#define FILTER_H

#include <QMap>
#include <QSortFilterProxyModel>
#include <QUuid>

class TreeModel;
class TreeItem;
class ProxyModel : public QSortFilterProxyModel {
  Q_OBJECT
public slots:
  void updateFilter(bool cond) {
      isChanged(cond);
//      if(cond){
//                invalidateFilter();

//      }
//      invalidateFilter();
  }

public:
  ProxyModel(QObject *parent = nullptr);
  void queryProcessing();
  bool filterAcceptsRow(int source_row,
                        const QModelIndex &source_parent) const override;
  Q_INVOKABLE void setQuery(QString string);
  Q_INVOKABLE void isChanged(bool condition);

private:
  bool queryChanged = true;
  QString query;
  QMap<QUuid, TreeItem *> itemContainer;
  TreeModel *sourceModel;
};
extern TreeModel myClass1;
#endif // FILTER_H
