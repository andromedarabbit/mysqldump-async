# mysqldump-async
A simple wrapper to execute mysqldump asynchronously.

## Prerequites
`mysqldump` should be installed first. Recommend to use [Homebrew](http://brew.sh/) to install it if you are a Mac user:

```bash
brew install mysql
```

`mysqldump` binary is expected to be placed in `/usr/local/bin` and you should rewrite your `info.js` if it is located somewhere else.

```javascript
var mysqlPath = "/usr/local/bin/mysql";
var mysqldumpPath = "/usr/local/bin/mysqldump"
```

## Configurations
You can find all the configurations you need from `info.js`:

```javascript
var dropAndCreate = true;
var backupBeforeDrop = false;

var dumpRootDir = path.join(__dirname, "dumps");

var mysqlPath = "/usr/local/bin/mysql";
var mysqldumpPath = "/usr/local/bin/mysqldump";

var backupRootDir = path.join(toolbox_js.getHomeDir(), '.backup');

var serverAddress = 'localhost';

var servers = [];
```

`servers` is the most important configurations and should be filled before using this tool. See the following examples:

```javascript
var servers = [
    {"name": "primary-database", "hostname": serverAddress, "port": "3306", "username": "root", "password": "PASSWORD", "database": "db_service", "tables" : {
         "require": [
                 "users",
                 ],
         "clear": [
                "audits",
                ]
        },
        "before" : path.join(dumpRootDir, "primary-database.db_service.prerequites.sql") ,

    },
    {"name": "schedule-database", "hostname": serverAddress, "port": "3306", "username": "root", "password": "PASSWORD", "database": "db_schedule", "tables" : {
        "require": [
                 "SCHEDULE_BLOB_TRIGGERS" ,
                 "SCHEDULE_CALENDARS" ,
                 "SCHEDULE_CRON_TRIGGERS" ,
                 "SCHEDULE_FIRED_TRIGGERS" ,
                 "SCHEDULE_JOB_DETAILS" ,
                 "SCHEDULE_JOB_LISTENERS" ,
                 "SCHEDULE_LOCKS" ,
                 "SCHEDULE_PAUSED_TRIGGER_GRPS" ,
                 "SCHEDULE_SIMPLE_TRIGGERS" ,
                 "SCHEDULE_TRIGGERS" ,
                 "SCHEDULE_TRIGGER_LISTENERS" ,
                 "BATCH_JOB_EXECUTION_SEQ" ,
                 "BATCH_JOB_SEQ" ,
                 "BATCH_STEP_EXECUTION_SEQ" ,
                ],
        "clear": [
               "SCHEDULE_SCHEDULER_STATE",
               "BATCH_JOB_EXECUTION",
               "BATCH_JOB_EXECUTION_CONTEXT",
               "BATCH_JOB_EXECUTION_PARAMS",
               "BATCH_JOB_INSTANCE",
               "BATCH_STEP_EXECUTION",
               "BATCH_STEP_EXECUTION_CONTEXT"
               ]

        },
        "before" : path.join(dumpRootDir, "schedule-database.db_schedule.prerequites.sql") ,
    },

];
```

## How to dump and restore the dump databases
Run `dump.js.command` to dump your databases and then you can find your dump files from `dumpRootDir` directory:

```javascript
var dumpRootDir = path.join(__dirname, "dumps");
```

Run `restore.js.command` to restore the databases using your dump files. Any changes made on your database will be discarded if you do not dump the database before restoring it. Set `backupBeforeDrop` to `true` if you want to dump the database first before restoring it.

```javascript
var backupBeforeDrop = false;
```
