#!/bin/bash
THIS_DIR=$(cd "$(dirname "$0")"; pwd)

docker run -v "${THIS_DIR}/info.js:/usr/src/app/info.js" -v "${THIS_DIR}/dumps/:/usr/src/app/dumps/" --net=host -it andromedarabbit/mysqldump-async:1.0.1 restore.js.command
