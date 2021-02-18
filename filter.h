#ifndef FILTER_H
#define FILTER_H


#include <QSortFilterProxyModel>
#include <QElapsedTimer>
#include <QDebug>


//#include "treeModel.h"
class TreeModel;
class TreeItem;
class Filtering : public QSortFilterProxyModel{
    Q_OBJECT
public slots:
    void updateFilter(){
        invalidateFilter();
    }
public:
    Q_INVOKABLE bool log();
Q_INVOKABLE void acceptsCopies(const QModelIndex &index, bool acceptsCopies);
bool lessThan(const QModelIndex& left, const QModelIndex &right ) const override;
    Filtering(QObject *parent = nullptr);
  //  Filtering(QObject *parent = nullptr, TreeModel* my = nullptr);
    Q_INVOKABLE bool removeRows(int position, int rows, const QModelIndex &parent);
    Q_INVOKABLE bool copyRows(int position, int rows,
                              const QModelIndex &parent = QModelIndex(),const QPersistentModelIndex &source = QModelIndex());
    Q_INVOKABLE bool insertRows(int position, int rows, const QModelIndex &parent, bool transclusion = true);
    Q_INVOKABLE bool getBool() const;
    Q_INVOKABLE  void setBool(bool var) ;
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;
     Q_INVOKABLE void saveIndex(const QModelIndex &index);
     Q_INVOKABLE void saveIndex1(const QModelIndex &index);
    Q_INVOKABLE void setQuery(QString string);
    Q_INVOKABLE void enableFilter(bool enabled);
    Q_INVOKABLE QString getId(const QModelIndex &index);
    Q_INVOKABLE void getIdToClipboard(const QModelIndex &index);


    QString query;
    bool cond = true;
    bool queryChanged;

private:
       bool m_enabled = true;
 TreeModel* sourceModel; //TODO: swap for sourceModel() member function if it's viable
};
extern TreeModel myClass1;
#endif // FILTER_H
