#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "vigenere_crypt.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);

    qmlRegisterType<VigenereCrypt>("VigenereCrypt", 1, 0, "VigenereCrypt");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("crypto", "Main");

    return app.exec();
}
