
#include "include/ProxyModel.h"
#include "include/TreeModel.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtPlugin>
#include <emscripten.h>

int main(int argc, char *argv[]) {
  qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QApplication app(argc, argv);

  // clang-format off

  EM_ASM(
              document.addEventListener("visibilitychange", function() {
                if (document.visibilityState === 'visible') {
//
                } else {
//
                                                 console.log("hide");
                                                Module._saveIDBFS();

                }
              });
//              document.onpagehide = function (e) {
//                   e = e || window.event;
//          Module._saveIDBFS();

//                 return console.log("freeze");
//               };
//          window.onpagehide = function (e) {
//               e = e || window.event;
//          Module._saveIDBFS();
//          return console.log("dddd");

//           };




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

  //  emscripten_exit_with_live_runtime();
  return app.exec();

  //  emscripten_exit_with_live_runtime();
}
