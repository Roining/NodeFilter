#ifndef FILTER_H
#define FILTER_H

//#include <QDebug>
//#include <QElapsedTimer>

#include <QUuid>

#include <QMap>
#include <QSortFilterProxyModel>

class TreeModel;
class TreeItem;
class Filtering : public QSortFilterProxyModel {
  Q_OBJECT
public slots:
  void updateFilter() { invalidateFilter(); }

public:
  Q_INVOKABLE QModelIndex mapToSourceProxy(const QModelIndex &proxyIndex) const;

  //  Q_INVOKABLE void acceptsCopies(const QModelIndex &index, bool
  //  acceptsCopies);
  // bool lessThan(const QModelIndex& left, const QModelIndex &right ) const
  // override;
  Filtering(QObject *parent = nullptr);
  //  Q_INVOKABLE bool removeRows(int position, int rows,
  //                              const QModelIndex &parent) override;
  //  Q_INVOKABLE bool
  //  copyRows(int position, int rows, const QModelIndex &parent =
  //  QModelIndex(),
  //           const QPersistentModelIndex &source = QModelIndex());
  //  Q_INVOKABLE bool insertRows(int position, int rows, const QModelIndex
  //  &parent,
  //                              bool transclusion = true);

  bool filterAcceptsRow(int source_row,
                        const QModelIndex &source_parent) const override;
  bool filterAcceptsRow1(int source_row,
                         const QModelIndex &source_parent) const;
  //  Q_INVOKABLE void saveIndex(const QModelIndex &index);
  Q_INVOKABLE void setQuery(QString string);

  QString query;
  bool cond = true;
  bool queryChanged;
  QMap<QUuid, TreeItem *> itemContainer;

private:
  TreeModel *sourceModel;
  bool m_enabled = true;
  //  TreeModel *sourceModel; // TODO: swap for sourceModel() member function if
  // it's viable
};
extern TreeModel myClass1;
#endif // FILTER_H
