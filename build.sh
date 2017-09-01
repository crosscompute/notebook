SCRIPT_PATHS="\
auth/js/main.min.js
edit/js/main.min.js
notebook/js/main.min.js
terminal/js/main.min.js
tree/js/main.min.js"
STYLE_PATHS="\
style/style.min.css"
TARGET_URL=gs://crosscompute-website-20170828
TEMPORARY_FOLDER=/tmp/notebook

mkdir -p $TEMPORARY_FOLDER
python setup.py css js
cd notebook/static

for SCRIPT_PATH in $SCRIPT_PATHS; do
    SCRIPT_NAME=$(dirname $(dirname $SCRIPT_PATH)).min.js
    cp $SCRIPT_PATH $TEMPORARY_FOLDER/$SCRIPT_NAME
    gsutil cp -z js -a public-read $TEMPORARY_FOLDER/$SCRIPT_NAME $TARGET_URL
done

for STYLE_PATH in $STYLE_PATHS; do
    STYLE_NAME=$(basename $STYLE_PATH)
    cp $STYLE_PATH $TEMPORARY_FOLDER/$STYLE_NAME
    gsutil cp -z js -a public-read $TEMPORARY_FOLDER/$STYLE_NAME $TARGET_URL
done
