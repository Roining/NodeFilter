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
  void updateFilter() { invalidateFilter(); }

public:
  ProxyModel(QObject *parent = nullptr);
  void queryProcessing();
  bool filterAcceptsRow(int source_row,
                        const QModelIndex &source_parent) const override;
  Q_INVOKABLE void setQuery(QString string);

private:
  QString query;
  QMap<QUuid, TreeItem *> itemContainer;
  TreeModel *sourceModel;
};
extern TreeModel myClass1;
#endif // FILTER_H
