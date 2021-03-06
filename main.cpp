#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "TreeModel.h"
#include "filter.h"
#include <QQmlContext>
#include <QAbstractItemModelTester>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    qmlRegisterType<Filtering>("TreeModel.com",1,0,"Filtering");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("myClass",&myClass1);

    const QUrl url(QStringLiteral("qrc:/main.qml"));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);


    return app.exec();
}





