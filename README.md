[![PayPal](https://img.shields.io/badge/%24-paypal-f39c12.svg)][paypal-donations]

# mysqldump-async

[mysqldump-async](https://github.com/andromedarabbit/mysqldump-async) is the simple wrapper to execute `mysqldump` asynchronously and dump multiple tables *in parallel*.

* Not as fast as a binary dump but **super-fast** comparing to running `mysqldump` in a single command.
* Designed to be a good tool when you want to **version control** you database schemes and records.

## Using Docker

All the files you needs are in the directory `examples`:

* `dump.sh`
* `restore.sh`

Edit the configuration file `info.js` before you run the scripts to dump or restore the database.

## On Your Mac

### Prerequites
#### `mysqldump`
`mysqldump` should be installed first. Recommend to use [Homebrew](http://brew.sh/) to install it if you are a Mac user:

```bash
brew install mysql
```

`mysqldump` binary is expected to in `${PATH}`.

#### `node` packages
Run `npm install` on your `mysqldump-async` folder. All the node.js packages will be installed. Of course, `node` and `npm` is required. Use Homebrew to install both of `node` and `npm` if you are a Mac user:

```bash
brew install node
```

### Configurations
You can find all the configurations you need from `info.js`:

```javascript
var dropAndCreate = true;
var backupBeforeDrop = false;

var dumpRootDir = path.join(__dirname, "dumps");

var mysqlPath = which('mysql').stdout;
var mysqldumpPath = which('mysqldump').stdout;

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

### How to dump and restore the dump databases
Run `dump.js.command` to dump your databases and then you can find your dump files from `dumpRootDir` directory:

```javascript
var dumpRootDir = path.join(__dirname, "dumps");
```

Run `restore.js.command` to restore the databases using your dump files. Any changes made on your database will be discarded if you do not dump the database before restoring it. Set `backupBeforeDrop` to `true` if you want to dump the database first before restoring it.

```javascript
var backupBeforeDrop = false;
```


[paypal-donations]: https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=VG4JMPL7SDBGG&lc=KR&item_name=andromedarabbit%2fmybatis%2dpagination&item_number=mybatis%2dpagination&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted
