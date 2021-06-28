#include "include/ProxyModel.h"
#include "include/TreeModel.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QtPlugin>

// Q_IMPORT_PLUGIN(QtQuickControls1Plugin);
// Q_IMPORT_PLUGIN(QtQuickControls2Plugin);

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QApplication app(argc, argv);
  //  a = &app;
  app.setQuitOnLastWindowClosed(false);
  app.setOrganizationName("Node Filter");
  app.setOrganizationDomain("NodeFilter.com");
  app.setApplicationName("Node Filter");
  qmlRegisterType<ProxyModel>("TreeModel.com", 1, 0, "Filtering");
  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("myClass", &myClass1);
  const QUrl url(QStringLiteral("qrc:/main.qml"));
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  QObject::connect(&engine, &QQmlApplicationEngine::quit, &QApplication::quit);
  engine.load(url);

  return app.exec();
}
