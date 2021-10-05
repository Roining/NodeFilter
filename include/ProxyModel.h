#ifndef PROXYMODEL_H
#define PROXYMODEL_H

#include <QMap>
#include <QSortFilterProxyModel>
#include <QUuid>

class TreeModel;
class TreeNode;
class ProxyModel : public QSortFilterProxyModel {
  Q_OBJECT
signals:
  void recursionSignalProxy();

public slots:
  void updateFilter(bool cond) { queryIsChanged(cond); }

public:
  ProxyModel(QObject *parent = nullptr);
  void queryProcessing();
 
  bool filterAcceptsRow(int source_row,
                        const QModelIndex &source_parent) const override;
  Q_INVOKABLE void setQuery(QString string);
  Q_INVOKABLE void queryIsChanged(bool condition);
  bool lessThan(const QModelIndex &left,
                const QModelIndex &right) const override;

private:
  bool queryChanged = true;
  QString query;
  QMap<QUuid, TreeNode *> itemContainer;
  TreeModel *sourceModel;
};
extern TreeModel SharedModel;
#endif // PROXYMODEL_H
