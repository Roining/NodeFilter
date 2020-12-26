#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "TreeModel.h"
#include "filter.h"
#include <QQmlContext>
#include <QAbstractItemModelTester>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    TreeModel myClass(nullptr);
    Filtering my(0,&myClass);
//    auto m =new QAbstractItemModelTester(&myClass, QAbstractItemModelTester::FailureReportingMode::Fatal);
//    qmlRegisterType<TreeModel>("TreeModel.com",1,0,"TreeModel");
//    qmlRegisterType<Filtering>("TreeModel.com",1,0,"Filtering");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("myClass",&myClass);
    engine.rootContext()->setContextProperty("myProxy",&my);
    const QUrl url(QStringLiteral("qrc:/main.qml"));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
//    QObject * item = engine.rootObjects().value(0);
//        QObject * search= item->findChild<QObject*>("search");
//    QObject::connect(search, SIGNAL(info(QString)), &my, SLOT(readText(QString)));
    engine.load(url);


    return app.exec();
}





