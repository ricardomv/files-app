/*
 * Files app - File manager for Papyros
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QLibrary>
#include <QDir>
#include <QStandardPaths>

#include <QDebug>

#include <KDeclarative/KDeclarative>
#include <KI18n/KLocalizedString>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QString qmlfile;

    QStringList paths = QStandardPaths::standardLocations(QStandardPaths::DataLocation);
    paths.prepend(QDir::currentPath());
    paths.prepend(QCoreApplication::applicationDirPath());

    foreach (const QString &path, paths) {
        QFileInfo fi(path + "/qml/main.qml");
        qDebug() << "Trying to load QML from:" << path + "/qml/main.qml";
        if (fi.exists()) {
            qmlfile = path +  "/qml/main.qml";
            break;
        }
    }

    QQmlApplicationEngine engine;

    KLocalizedString::setApplicationDomain("io.papyros.files");

    KDeclarative::KDeclarative kdeclarative;
    //view refers to the QDeclarativeView
    kdeclarative.setDeclarativeEngine(&engine);
    kdeclarative.initialize();
    //binds things like kconfig and icons
    kdeclarative.setupBindings();

    engine.load(qmlfile);

    return app.exec();
}
