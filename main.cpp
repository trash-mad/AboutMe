#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlEngine>
#include <QtQml/QQmlContext>

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    app.setOrganizationName("SimpleSoft");
    app.setOrganizationDomain("tripolskypetr.github.io");
    app.setApplicationName("AboutMe");
    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);


    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);
    viewer.setSource(QUrl("qrc:/qml/main.qml"));
    viewer.show();

    return app.exec();
}
