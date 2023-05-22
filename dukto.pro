# Add more folders to ship with the application, here
#qml_folder.source = qml/dukto
#qml_folder.target = qml
#DEPLOYMENTFOLDERS = qml_folder

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += core network qml quick widgets

win32:RC_FILE = data/dukto.rc
win32:LIBS += libWs2_32 libole32 libNetapi32

mac:ICON = data/dukto.icns

VERSION = 6.0.0

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices


unix {
        isEmpty(PREFIX) {
            PREFIX=/usr
        }
        DATADIR = $$PREFIX/share

	TARGET = dukto
        target.path = $$PREFIX/bin
	INSTALLS += target
	
        icon.path = $$DATADIR/pixmaps
        icon.files = data/dukto.png
	INSTALLS += icon
	
        desktop.path = $$DATADIR/applications/
        desktop.files = data/dukto.desktop
	INSTALLS += desktop
}

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

INCLUDEPATH += $$PWD/src

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += src/main.cpp \
    src/guibehind.cpp \
    src/platform.cpp \
    src/model/buddylistitemmodel.cpp \
    src/duktoprotocol.cpp \
    src/miniwebserver.cpp \
    src/model/ipaddressitemmodel.cpp \
    src/model/recentlistitemmodel.cpp \
    src/settings.cpp \
    src/destinationbuddy.cpp \
    src/duktowindow.cpp \
    src/ecwin7.cpp \
    src/theme.cpp \
    src/updateschecker.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    src/guibehind.h \
    src/platform.h \
    src/model/buddylistitemmodel.h \
    src/duktoprotocol.h \
    src/peer.h \
    src/miniwebserver.h \
    src/model/ipaddressitemmodel.h \
    src/model/recentlistitemmodel.h \
    src/settings.h \
    src/destinationbuddy.h \
    src/duktowindow.h \
    src/ecwin7.h \
    src/theme.h \
    src/updateschecker.h

RESOURCES += \
    qml.qrc

# include(qtsingleapplication/qtsingleapplication.pri)
include(third-party/singleapplication/singleapplication.pri)
DEFINES += QAPPLICATION_CLASS=QApplication

OTHER_FILES +=
