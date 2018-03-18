QT += core gui widgets
TARGET = LAzyExplorer
TEMPLATE = app
DEFINES += QT_DEPRECATED_WARNINGS

#macx
    DEPLOY_COMMAND = macdeployqt
    TARGET_CUSTOM_EXT = .app
    DEPLOY_TARGET = $$shell_quote($$shell_path($${OUT_PWD}/$${DESTDIR}/$${TARGET}$${TARGET_CUSTOM_EXT}))
    DEPLOY_OPTIONS = -verbose=0
    QMAKE_POST_LINK += $${DEPLOY_COMMAND} $${DEPLOY_TARGET} $${DEPLOY_OPTIONS} $$escape_expand(\n\t)

    TARGET_BINARY = $${DEPLOY_TARGET}/Contents/MacOS/$${TARGET}
    QMAKE_LFLAGS += -F$${PWD}/Frameworks
    INCLUDEPATH += -F$${PWD}/Frameworks
    TARGET_FRAMEWORKS = $${DEPLOY_TARGET}/Contents/Frameworks/
    LIBS += -framework GDAL #LIBS += -lGEOS -framework PROJ
    QMAKE_POST_LINK += cp -af $${PWD}/Frameworks/*.framework $${TARGET_FRAMEWORKS} || true $$escape_expand(\n\t)
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/GDAL.framework/Versions/2.2/GDAL" "@executable_path/../Frameworks/GDAL.framework/GDAL" "$${TARGET_BINARY}" $$escape_expand(\n\t)

    # See Frameworks/README.txt before runnimg qmake.
    # TODO: move the following to some import script, i.e. parse downloaded .dmg + do this:
    # GDAL
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/GDAL.framework/Versions/2.2/GDAL" "@executable_path/../Frameworks/GDAL.framework/GDAL" "$${TARGET_FRAMEWORKS}/GDAL.framework/GDAL" $$escape_expand(\n\t)
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/PROJ.framework/Versions/4B/PROJ" "@executable_path/../Frameworks/PROJ.framework/PROJ" "$${TARGET_FRAMEWORKS}/GDAL.framework/GDAL" $$escape_expand(\n\t)
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/GEOS.framework/Versions/3B/GEOS" "@executable_path/../Frameworks/GEOS.framework/Versions/3B/GEOS" "$${TARGET_FRAMEWORKS}/GDAL.framework/GDAL" $$escape_expand(\n\t)
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/UnixImageIO.framework/Versions/F/UnixImageIO" "@executable_path/../Frameworks/UnixImageIO.framework/UnixImageIO" "$${TARGET_FRAMEWORKS}/GDAL.framework/GDAL" $$escape_expand(\n\t)
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/SQLite3.framework/Versions/D/SQLite3" "@executable_path/../Frameworks/SQLite3.framework/SQLite3" "$${TARGET_FRAMEWORKS}/GDAL.framework/GDAL" $$escape_expand(\n\t)
    # GDAL: libogdi.dylib
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/PROJ.framework/Versions/4B/PROJ" "@executable_path/../Frameworks/PROJ.framework/PROJ" "$${TARGET_FRAMEWORKS}/GDAL.framework/Versions/Current/Libraries/libogdi.dylib" $$escape_expand(\n\t)
    # UnixImageIO
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/PROJ.framework/Versions/4B/PROJ" "@executable_path/../Frameworks/PROJ.framework/PROJ" "$${TARGET_FRAMEWORKS}/UnixImageIO.framework/UnixImageIO" $$escape_expand(\n\t)
    # SQLite3
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/GEOS.framework/Versions/3B/GEOS" "@executable_path/../Frameworks/GEOS.framework/Versions/3B/GEOS" "$${TARGET_FRAMEWORKS}/SQLite3.framework/SQLite3" $$escape_expand(\n\t)
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/PROJ.framework/Versions/4B/PROJ" "@executable_path/../Frameworks/PROJ.framework/PROJ" "$${TARGET_FRAMEWORKS}/SQLite3.framework/SQLite3" $$escape_expand(\n\t)
    QMAKE_POST_LINK += install_name_tool -change "/Library/Frameworks/UnixImageIO.framework/Versions/F/UnixImageIO" "@executable_path/../Frameworks/UnixImageIO.framework/UnixImageIO" "$${TARGET_FRAMEWORKS}/SQLite3.framework/SQLite3" $$escape_expand(\n\t)

SOURCES += \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    mainwindow.h

HEADERS += \
    Frameworks/GDAL.framework/Headers/*

FORMS += \
    mainwindow.ui
