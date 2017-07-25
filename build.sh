SOURCE_PATHS="\
auth/js/main.min.js
edit/js/main.min.js
notebook/js/main.min.js
terminal/js/main.min.js
tree/js/main.min.js"
TEMPORARY_FOLDER=/tmp/notebook
TARGET_URL=gs://crosscompute-20170501

mkdir -p $TEMPORARY_FOLDER
python setup.py css js
cd notebook/static

for SOURCE_PATH in $SOURCE_PATHS; do
    SCRIPT_NAME=$(dirname $(dirname $SOURCE_PATH))
    mv $SOURCE_PATH $TEMPORARY_FOLDER/${SCRIPT_NAME}.min.js
    gsutil cp -z js -a public-read $TEMPORARY_FOLDER/$SCRIPT_NAME.min.js $TARGET_URL
done

