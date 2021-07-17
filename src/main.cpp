
#include "include/ProxyModel.h"
#include "include/TreeModel.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtPlugin>
#include <emscripten.h>

class ShortcutListener : public QObject {
  Q_OBJECT

public:
  ShortcutListener(QObject *parent = nullptr) : QObject(parent) {}

  Q_INVOKABLE void listenTo(QObject *object) {
    if (!object)
      return;

    object->installEventFilter(this);
  }

  bool eventFilter(QObject *object, QEvent *event) override {

    if (event->type() == QEvent::RequestSoftwareInputPanel) {
      qDebug() << "RequestSoftwareInputPanel  ";

      return true;
    } else if (event->type() == QEvent::FocusIn) {
      qDebug() << "FocusIn  ";
      return true;

    } else {
      // standard event processing
      return QObject::eventFilter(object, event);
    }
  }
};

static QObject *shortcutListenerInstance(QQmlEngine *, QJSEngine *engine) {
  return new ShortcutListener(engine);
}
// Q_IMPORT_PLUGIN(QtQuickControls1Plugin);
// Q_IMPORT_PLUGIN(QtQuickControls2Plugin);
#include "main.moc"

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
  qmlRegisterSingletonType<ShortcutListener>("App", 1, 0, "ShortcutListener",
                                             shortcutListenerInstance);
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
