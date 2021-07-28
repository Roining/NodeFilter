
#include "include/ProxyModel.h"
#include "include/TreeModel.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtPlugin>
#include <emscripten.h>

// Q_IMPORT_PLUGIN(QtQuickControls1Plugin);
// Q_IMPORT_PLUGIN(QtQuickControls2Plugin);

int main(int argc, char *argv[]) {
  qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QApplication app(argc, argv);
  //  ShortcutListener *app1 = new ShortcutListener();
  //  app.installEventFilter(app1);
  //  QInputMethod *input;
  //  input = QGuiApplication::inputMethod();

  ////  input->setVisible(false);

  // clang-format off
  EM_ASM(
              if('serviceWorker' in navigator){
                navigator.serviceWorker.register('/sw.js')
                  .then(reg => console.log('service worker registered'))
                  .catch(err => console.log('service worker not registered', err));
              }
             window.onbeforeunload = function (e) {
                  e = e || window.event;
                  return 'Sure';
              };
      );
  // clang-format on
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
  qDebug() << "file.readAll()";

  //  emscripten_exit_with_live_runtime();
  return app.exec();

  //  emscripten_exit_with_live_runtime();
}
