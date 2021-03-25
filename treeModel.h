/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef TREEMODEL_H
#define TREEMODEL_H
#include <ProxyModel.h>
#include <QAbstractItemModel>
#include <QFile>
#include <QIODevice>
#include <QMap>
#include <QModelIndex>
#include <QMultiMap>
#include <QPersistentModelIndex>
#include <QUuid>
#include <QVariant>

class TreeItem;

class TreeModel : public QAbstractItemModel {
  Q_OBJECT

signals:
  void updateProxyFilter(bool cond);

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

  bool isDescendant(TreeItem *parent, TreeItem *child,
                    bool searchClones = false);

  Q_INVOKABLE TreeItem *getItem(const QModelIndex &index) const;
  Q_INVOKABLE void serialize(TreeItem &node, QDataStream &stream);
  void serializeCleanUp(TreeItem &node);
  void serializeClear(TreeItem &node);
  Q_INVOKABLE void deserialize(TreeItem &node, QDataStream &stream,
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
  void setupModelData(const QStringList &lines, TreeItem *parent);
  Q_INVOKABLE bool acceptsCopies(const QModelIndex &index);

private:
  QPersistentModelIndex
      last; // TODO should it remain static? Related to copyRows
  QMultiMap<QUuid, QUuid> container;
  QMap<QUuid, TreeItem *> map;
  TreeItem *rootItem;
};
//! [2]

#endif
