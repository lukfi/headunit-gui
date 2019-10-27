TEMPLATE = lib
CONFIG += c++11 plugin link_pkgconfig
QT += qml quick
TARGET = $$qtLibraryTarget(default-theme)

INCLUDEPATH += $${PWD}/quickcross
include("../../config.pri")

target.path = $${PREFIX}/themes/default-theme

SOURCES += \
    quickcross/qcstandardpaths.cpp \
    quickcross/qcdevice.cpp \
    defaulttheme.cpp

HEADERS += \
    quickcross/qcstandardpaths.h \
    quickcross/qcdevice.h \
    defaulttheme.h

RESOURCES += default-theme.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

THEMEFILES += \
    $${PWD}/theme.json \
    $${PWD}/qml/theme/qmldir \
    $${PWD}/qml/theme/designer/hudtheme.metainfo \
    $${PWD}/qml/theme/backgrounds/*

#copy needed files to build dir

##recursively copy the theme folder
unix {
    theme_files_copy.commands = $(COPY_DIR) $$PWD/qml/theme $$PWD/HUDTheme
}

win32 {
    theme_files_copy.commands = $(COPY_DIR) .\qml\theme .\HUDTheme
}
message($${theme_files_copy.commands});
##attach the copy command to make target
first.depends = $(first) theme_files_copy
##export variables to global scope
export(first.depends)
export(theme_files_copy.commands)
QMAKE_EXTRA_TARGETS += first theme_files_copy

DISTFILES += THEMEFILES

theme.files = $${PWD}/qml/theme/*
theme.path = $$PREFIX/themes/default-theme/HUDTheme

INSTALLS += target theme

DESTDIR += $${PWD}



