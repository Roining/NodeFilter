#ifndef PROXYMODEL_H
#define PROXYMODEL_H

#include <QMap>
#include <QSortFilterProxyModel>
#include <QUuid>

class TreeModel;
class TreeNode;
class ProxyModel : public QSortFilterProxyModel {
  Q_OBJECT
public slots:
  void updateFilter(bool cond) { queryIsChanged(cond); }

public:
  ProxyModel(QObject *parent = nullptr);
  void queryProcessing();
  bool filterAcceptsRow(int source_row,
                        const QModelIndex &source_parent) const override;
  Q_INVOKABLE void setQuery(QString string);
  Q_INVOKABLE void queryIsChanged(bool condition);

private:
  bool queryChanged = true;
  QString query;
  QMap<QUuid, TreeNode *> itemContainer;
  TreeModel *sourceModel;
};
extern TreeModel myClass1;
#endif // PROXYMODEL_H
