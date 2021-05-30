#ifndef TREEMODEL_H
#define TREEMODEL_H
#include <QAbstractItemModel>
#include <QFile>
#include <QIODevice>
#include <QMap>
#include <QModelIndex>
#include <QMultiMap>
#include <QPersistentModelIndex>
#include <QUuid>
#include <QVariant>
#include <include/ProxyModel.h>

class TreeNode;

class TreeModel : public QAbstractItemModel {
  Q_OBJECT

signals:
  void updateProxyFilter(bool cond);
  void recursionSignal();

public:
  TreeModel(QObject *parent = nullptr);

  TreeModel(const QStringList &headers, const QString &data,
            QObject *parent = nullptr);
  ~TreeModel();

  Q_INVOKABLE QVariant data(const QModelIndex &index, int role) const override;
  QVariant headerData(int section, Qt::Orientation orientation,
                      int role = Qt::DisplayRole) const override;

  QModelIndex index(int row, int column,
                    const QModelIndex &parent = QModelIndex()) const override;
  Q_INVOKABLE QModelIndex parent(const QModelIndex &index) const override;

  int rowCount(const QModelIndex &parent = QModelIndex()) const override;
  int columnCount(const QModelIndex &parent = QModelIndex()) const override;
  Qt::ItemFlags flags(const QModelIndex &index) const override;
  bool setData(const QModelIndex &index, const QVariant &value,
               int role = Qt::EditRole) override;
  bool setHeaderData(int section, Qt::Orientation orientation,
                     const QVariant &value, int role = Qt::EditRole) override;

  bool insertColumns(int position, int columns,
                     const QModelIndex &parent = QModelIndex()) override;
  bool removeColumns(int position, int columns,
                     const QModelIndex &parent = QModelIndex()) override;

  Q_INVOKABLE bool
  insertRows(int position, int rows,
             const QModelIndex &parent = QModelIndex()) override;

  Q_INVOKABLE void insertRowsRecursive(int position, QUuid callingId,
                                       QUuid calledId,
                                       const QModelIndex &child);

  Q_INVOKABLE bool
  removeRows(int position, int rows,
             const QModelIndex &parent = QModelIndex()) override;

  void removeRowsRecursive(int position, QUuid callingId, QUuid calledId,
                           const QModelIndex &child);

  QHash<int, QByteArray> roleNames() const override;
  Q_INVOKABLE void saveIndex(const QModelIndex &index);
  Q_INVOKABLE void save();
  Q_INVOKABLE QPersistentModelIndex getLastIndex();

  bool isDescendant(TreeNode *parent, TreeNode *child, int depth,
                    bool searchClones = false);
  TreeNode *isDescendantNode(TreeNode *parent, TreeNode *child);
  bool isDirectDescendant(TreeNode *parent, TreeNode *child, int depth);
  bool isDirectDescendant1(TreeNode *parent, TreeNode *child, int depth);
  bool isDirectDescendant2(TreeNode *parent, TreeNode *child, int depth);

  Q_INVOKABLE TreeNode *getItem(const QModelIndex &index) const;
  Q_INVOKABLE void serialize(TreeNode &node, QDataStream &stream);
  void serializeCleanUp(TreeNode &node);
  void serializeClear(TreeNode &node);
  Q_INVOKABLE void deserialize(TreeNode &node, QDataStream &stream,
                               bool check = false);
  Q_INVOKABLE bool
  copyRows(int position, int rows, const QModelIndex &parent = QModelIndex(),
           const QPersistentModelIndex &source = QModelIndex());
  Q_INVOKABLE bool
  copyRowsAndChildren(int position, int rows,
                      const QModelIndex &parent = QModelIndex(),
                      const QPersistentModelIndex &source = QModelIndex());
  void copyRowsRecursive(int position, QUuid callingId, QUuid calledId,
                         const QModelIndex &source);
  Q_INVOKABLE QString getId(const QModelIndex &id);
  Q_INVOKABLE int position(const QModelIndex &index);
  Q_INVOKABLE void getIdToClipboard(const QModelIndex &index);
  Q_INVOKABLE void acceptsCopies(const QModelIndex &index, bool acceptsCopies);
  Q_INVOKABLE bool hasMultipleSiblings(const QModelIndex &index);
  void setupModelData(const QStringList &lines, TreeNode *parent);
  Q_INVOKABLE bool acceptsCopies(const QModelIndex &index);

private:
  QPersistentModelIndex
      last; // TODO should it remain static? Related to copyRows
  QMultiMap<QUuid, QUuid> container;
  QMap<QUuid, TreeNode *> map;
  TreeNode *rootItem;
};
//! [2]

#endif
