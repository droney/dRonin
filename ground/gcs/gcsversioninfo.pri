#
# This qmake file generates a header with the GCS version info string.
#
# This is a bit hacky but QMake seems to have some kind of bug that prevents this working
# with a target instead (the deps always end up with a relative path and the rule an absolute path or vice-versa, they don't match up)
#

ROOT_DIR              = $$GCS_SOURCE_TREE/../..
VERSION_INFO_PATH     = $$system_path($$GCS_BUILD_TREE)
VERSION_INFO_HEADER   = $$system_path($$VERSION_INFO_PATH/gcsversioninfo.h)
VERSION_INFO_SCRIPT   = $$ROOT_DIR/make/scripts/version-info.py
VERSION_INFO_TEMPLATE = $$ROOT_DIR/make/templates/gcsversioninfotemplate.h
VERSION_INFO_COMMAND  = $$PYTHON_LOCAL \"$$VERSION_INFO_SCRIPT\"
UAVO_DEF_PATH         = $$ROOT_DIR/shared/uavobjectdefinition

# this runs once while Qmake is reading pro files rather than later during the actual build
!build_pass:system($$VERSION_INFO_COMMAND \
                                --path=\"$$GCS_SOURCE_TREE\" \
                                --template=\"$$VERSION_INFO_TEMPLATE\" \
                                --uavodir=\"$$UAVO_DEF_PATH\" \
                                --outfile=\"$$VERSION_INFO_HEADER\")

DEPENDPATH *= $$VERSION_INFO_PATH
HEADERS *= $$VERSION_INFO_HEADER
DEFINES += 'GCS_VERSION_INFO_FILE=\\\"$$VERSION_INFO_HEADER\\\"'
