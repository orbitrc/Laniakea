#include <QApplication>
#include <QQmlEngine>
#include <QQmlApplicationEngine>
#include <QScreen>

#include <blusher.h>

#include <curl/curl.h>

#include <stdint.h>
#include <stdio.h>

#include "global.h"
#include "Shell.h"
#include "BlusherWidget.h"
#include "RebusListener.h"
#include "PopUpMenu.h"
#include "PopUpMenuDelegate.h"

namespace la {
    Shell *shell = nullptr;
    QVariantMap *process = nullptr;
    QQmlEngine *engine = nullptr;
}

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_DisableHighDpiScaling);

    bl::Application app(argc, argv);

    app.engine()->addImportPath(BLUSHER_PATH);
    app.engine()->addImportPath("qrc:/components");
    app.engine()->addImportPath("qrc:/modules");
    app.engine()->addPluginPath("/usr/lib");
    la::engine = app.engine();

    qmlRegisterUncreatableType<la::AccessPoint>("Laniakea", 0, 1, "AccessPoint", "");
    // Connect to ReBus server and post new host.
    RebusListener rebus;
    if (rebus.post_host() != 201) {
        return 1;
    }
    QObject::connect(&app, &QApplication::aboutToQuit,
                     &rebus, &RebusListener::delete_host, Qt::AutoConnection);

    la::Shell shell;
    la::shell = &shell;

    shell.show();

    la::engine->rootContext()->setContextProperty("Shell", QVariant::fromValue(&shell));

    qmlRegisterType<la::PopUpMenuDelegate>("LaniakeaShell", 0, 1, "PopUpMenuDelegate");


    QList<QScreen*> screens = QGuiApplication::screens();

    /*
    QObject::connect(&app, &QGuiApplication::screenAdded,
                     &app, [](QScreen *screen) {
        fprintf(stderr, "screen added!\n");
    });
    QObject::connect(&app, &QGuiApplication::screenRemoved,
                     &app, [](QScreen *screen) {
        fprintf(stderr, "screen removed!\n");
    });
    */

//    QObject::connect(
//        &app, &QObject::objectNameChanged,
//        &app, [app](const QString& objectName) { app.onObjectNameChanged(objectName); },
//        Qt::QueuedConnection
//    );

//    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
