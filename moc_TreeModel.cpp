/****************************************************************************
** Meta object code from reading C++ file 'TreeModel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../NodeFilter/include/TreeModel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'TreeModel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_TreeModel_t {
    QByteArrayData data[39];
    char stringdata0[393];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_TreeModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_TreeModel_t qt_meta_stringdata_TreeModel = {
    {
QT_MOC_LITERAL(0, 0, 9), // "TreeModel"
QT_MOC_LITERAL(1, 10, 17), // "updateProxyFilter"
QT_MOC_LITERAL(2, 28, 0), // ""
QT_MOC_LITERAL(3, 29, 4), // "cond"
QT_MOC_LITERAL(4, 34, 15), // "recursionSignal"
QT_MOC_LITERAL(5, 50, 4), // "data"
QT_MOC_LITERAL(6, 55, 11), // "QModelIndex"
QT_MOC_LITERAL(7, 67, 5), // "index"
QT_MOC_LITERAL(8, 73, 4), // "role"
QT_MOC_LITERAL(9, 78, 6), // "parent"
QT_MOC_LITERAL(10, 85, 10), // "insertRows"
QT_MOC_LITERAL(11, 96, 8), // "position"
QT_MOC_LITERAL(12, 105, 4), // "rows"
QT_MOC_LITERAL(13, 110, 19), // "insertRowsRecursive"
QT_MOC_LITERAL(14, 130, 9), // "callingId"
QT_MOC_LITERAL(15, 140, 8), // "calledId"
QT_MOC_LITERAL(16, 149, 5), // "child"
QT_MOC_LITERAL(17, 155, 10), // "removeRows"
QT_MOC_LITERAL(18, 166, 9), // "saveIndex"
QT_MOC_LITERAL(19, 176, 4), // "save"
QT_MOC_LITERAL(20, 181, 12), // "getLastIndex"
QT_MOC_LITERAL(21, 194, 21), // "QPersistentModelIndex"
QT_MOC_LITERAL(22, 216, 7), // "getItem"
QT_MOC_LITERAL(23, 224, 9), // "TreeNode*"
QT_MOC_LITERAL(24, 234, 9), // "serialize"
QT_MOC_LITERAL(25, 244, 9), // "TreeNode&"
QT_MOC_LITERAL(26, 254, 4), // "node"
QT_MOC_LITERAL(27, 259, 12), // "QDataStream&"
QT_MOC_LITERAL(28, 272, 6), // "stream"
QT_MOC_LITERAL(29, 279, 11), // "deserialize"
QT_MOC_LITERAL(30, 291, 5), // "check"
QT_MOC_LITERAL(31, 297, 8), // "copyRows"
QT_MOC_LITERAL(32, 306, 6), // "source"
QT_MOC_LITERAL(33, 313, 19), // "copyRowsAndChildren"
QT_MOC_LITERAL(34, 333, 5), // "getId"
QT_MOC_LITERAL(35, 339, 2), // "id"
QT_MOC_LITERAL(36, 342, 16), // "getIdToClipboard"
QT_MOC_LITERAL(37, 359, 13), // "acceptsCopies"
QT_MOC_LITERAL(38, 373, 19) // "hasMultipleSiblings"

    },
    "TreeModel\0updateProxyFilter\0\0cond\0"
    "recursionSignal\0data\0QModelIndex\0index\0"
    "role\0parent\0insertRows\0position\0rows\0"
    "insertRowsRecursive\0callingId\0calledId\0"
    "child\0removeRows\0saveIndex\0save\0"
    "getLastIndex\0QPersistentModelIndex\0"
    "getItem\0TreeNode*\0serialize\0TreeNode&\0"
    "node\0QDataStream&\0stream\0deserialize\0"
    "check\0copyRows\0source\0copyRowsAndChildren\0"
    "getId\0id\0getIdToClipboard\0acceptsCopies\0"
    "hasMultipleSiblings"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_TreeModel[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      28,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,  154,    2, 0x06 /* Public */,
       4,    0,  157,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       5,    2,  158,    2, 0x02 /* Public */,
       9,    1,  163,    2, 0x02 /* Public */,
      10,    3,  166,    2, 0x02 /* Public */,
      10,    2,  173,    2, 0x22 /* Public | MethodCloned */,
      13,    4,  178,    2, 0x02 /* Public */,
      17,    3,  187,    2, 0x02 /* Public */,
      17,    2,  194,    2, 0x22 /* Public | MethodCloned */,
      18,    1,  199,    2, 0x02 /* Public */,
      19,    0,  202,    2, 0x02 /* Public */,
      20,    0,  203,    2, 0x02 /* Public */,
      22,    1,  204,    2, 0x02 /* Public */,
      24,    2,  207,    2, 0x02 /* Public */,
      29,    3,  212,    2, 0x02 /* Public */,
      29,    2,  219,    2, 0x22 /* Public | MethodCloned */,
      31,    4,  224,    2, 0x02 /* Public */,
      31,    3,  233,    2, 0x22 /* Public | MethodCloned */,
      31,    2,  240,    2, 0x22 /* Public | MethodCloned */,
      33,    4,  245,    2, 0x02 /* Public */,
      33,    3,  254,    2, 0x22 /* Public | MethodCloned */,
      33,    2,  261,    2, 0x22 /* Public | MethodCloned */,
      34,    1,  266,    2, 0x02 /* Public */,
      11,    1,  269,    2, 0x02 /* Public */,
      36,    1,  272,    2, 0x02 /* Public */,
      37,    2,  275,    2, 0x02 /* Public */,
      38,    1,  280,    2, 0x02 /* Public */,
      37,    1,  283,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Bool,    3,
    QMetaType::Void,

 // methods: parameters
    QMetaType::QVariant, 0x80000000 | 6, QMetaType::Int,    7,    8,
    0x80000000 | 6, 0x80000000 | 6,    7,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, 0x80000000 | 6,   11,   12,    9,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,   11,   12,
    QMetaType::Void, QMetaType::Int, QMetaType::QUuid, QMetaType::QUuid, 0x80000000 | 6,   11,   14,   15,   16,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, 0x80000000 | 6,   11,   12,    9,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,   11,   12,
    QMetaType::Void, 0x80000000 | 6,    7,
    QMetaType::Void,
    0x80000000 | 21,
    0x80000000 | 23, 0x80000000 | 6,    7,
    QMetaType::Void, 0x80000000 | 25, 0x80000000 | 27,   26,   28,
    QMetaType::Void, 0x80000000 | 25, 0x80000000 | 27, QMetaType::Bool,   26,   28,   30,
    QMetaType::Void, 0x80000000 | 25, 0x80000000 | 27,   26,   28,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, 0x80000000 | 6, 0x80000000 | 21,   11,   12,    9,   32,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, 0x80000000 | 6,   11,   12,    9,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,   11,   12,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, 0x80000000 | 6, 0x80000000 | 21,   11,   12,    9,   32,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, 0x80000000 | 6,   11,   12,    9,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,   11,   12,
    QMetaType::QString, 0x80000000 | 6,   35,
    QMetaType::Int, 0x80000000 | 6,    7,
    QMetaType::Void, 0x80000000 | 6,    7,
    QMetaType::Void, 0x80000000 | 6, QMetaType::Bool,    7,   37,
    QMetaType::Bool, 0x80000000 | 6,    7,
    QMetaType::Bool, 0x80000000 | 6,    7,

       0        // eod
};

void TreeModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<TreeModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->updateProxyFilter((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 1: _t->recursionSignal(); break;
        case 2: { QVariant _r = _t->data((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = std::move(_r); }  break;
        case 3: { QModelIndex _r = _t->parent((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QModelIndex*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->insertRows((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const QModelIndex(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { bool _r = _t->insertRows((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 6: _t->insertRowsRecursive((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QUuid(*)>(_a[2])),(*reinterpret_cast< QUuid(*)>(_a[3])),(*reinterpret_cast< const QModelIndex(*)>(_a[4]))); break;
        case 7: { bool _r = _t->removeRows((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const QModelIndex(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 8: { bool _r = _t->removeRows((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 9: _t->saveIndex((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 10: _t->save(); break;
        case 11: { QPersistentModelIndex _r = _t->getLastIndex();
            if (_a[0]) *reinterpret_cast< QPersistentModelIndex*>(_a[0]) = std::move(_r); }  break;
        case 12: { TreeNode* _r = _t->getItem((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< TreeNode**>(_a[0]) = std::move(_r); }  break;
        case 13: _t->serialize((*reinterpret_cast< TreeNode(*)>(_a[1])),(*reinterpret_cast< QDataStream(*)>(_a[2]))); break;
        case 14: _t->deserialize((*reinterpret_cast< TreeNode(*)>(_a[1])),(*reinterpret_cast< QDataStream(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3]))); break;
        case 15: _t->deserialize((*reinterpret_cast< TreeNode(*)>(_a[1])),(*reinterpret_cast< QDataStream(*)>(_a[2]))); break;
        case 16: { bool _r = _t->copyRows((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const QModelIndex(*)>(_a[3])),(*reinterpret_cast< const QPersistentModelIndex(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 17: { bool _r = _t->copyRows((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const QModelIndex(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 18: { bool _r = _t->copyRows((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 19: { bool _r = _t->copyRowsAndChildren((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const QModelIndex(*)>(_a[3])),(*reinterpret_cast< const QPersistentModelIndex(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 20: { bool _r = _t->copyRowsAndChildren((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const QModelIndex(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 21: { bool _r = _t->copyRowsAndChildren((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 22: { QString _r = _t->getId((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 23: { int _r = _t->position((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 24: _t->getIdToClipboard((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 25: _t->acceptsCopies((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 26: { bool _r = _t->hasMultipleSiblings((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 27: { bool _r = _t->acceptsCopies((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (TreeModel::*)(bool );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TreeModel::updateProxyFilter)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (TreeModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TreeModel::recursionSignal)) {
                *result = 1;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject TreeModel::staticMetaObject = { {
    QMetaObject::SuperData::link<QAbstractItemModel::staticMetaObject>(),
    qt_meta_stringdata_TreeModel.data,
    qt_meta_data_TreeModel,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *TreeModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TreeModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_TreeModel.stringdata0))
        return static_cast<void*>(this);
    return QAbstractItemModel::qt_metacast(_clname);
}

int TreeModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractItemModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 28)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 28;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 28)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 28;
    }
    return _id;
}

// SIGNAL 0
void TreeModel::updateProxyFilter(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void TreeModel::recursionSignal()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
