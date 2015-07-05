#!/usr/bin/env node
var shell = require('shelljs');
var path = require('path');
var sprintf = require('sprintf').sprintf;
var toolbox_js = require('toolbox-js');
var dateUtils = require('date-utils');
var argv = require('optimist').argv;

var dropAndCreate = true;
var backupBeforeDrop = false;
if(process.env.USER == 'decanter') {
    backupBeforeDrop = false;
}

var dumpRootDir = path.join(__dirname, "dumps");

var mysqlPath = "/usr/local/bin/mysql";
var mysqldumpPath = "/usr/local/bin/mysqldump";

var backupRootDir = path.join(toolbox_js.getHomeDir(), '.backup');

var serverAddress = 'localhost';

if(argv.host) {
    serverAddress = argv.host;
}

var target = "";
if(argv.target) {
    shell.mkdir('-p', path.join(dumpRootDir, argv.target));
    target = argv.target + "/";
}

if(argv.version) {
    target += argv.version + ".";
}

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


function verifyAndInitialize() {
    if(!shell.test('-e', dumpRootDir)) {
        shell.mkdir('-p', dumpRootDir);
    }

    if(!shell.test('-e', mysqlPath)) {
        console.error('mysql not found!');
        shell.exit(1);
    }

    if(!shell.test('-e', mysqldumpPath)) {
        console.error('mysqldump not found!');
        shell.exit(1);
    }
}

function getAfterFile(server) {
    if(!server || !server.after) {
        return [];
    }

    return server["after"];
}

function getBeforeFile(server) {
    if(!server || !server.before) {
        return [];
    }

    return server["before"];
}

function getSchemasFileName(server) {
    return sprintf("%s%s.%s.schemas.sql", target, server["name"], server["database"]);
}

function getSchemasFilePath(server) {
    return path.join(dumpRootDir, getSchemasFileName(server));
}

function getRecordsRequiredFileName(server) {
    return sprintf("%s%s.%s.records.required.sql", target, server["name"], server["database"]);
}

function getRecordsRequiredFilePath(server) {
    return path.join(dumpRootDir, getRecordsRequiredFileName(server));
}

function getRecordsOptionalFileName(server) {
    return sprintf("%s%s.%s.records.optional.sql", target, server["name"], server["database"]);
}

function getRecordsOptionalFilePath(server) {
    return path.join(dumpRootDir, getRecordsOptionalFileName(server));
}



function getBackupDir() {
    var date = new Date();

    var dateStr = date.toFormat('YYYY-MM-DD HH24:MI:SS');
    return path.join(backupRootDir, dateStr);
}

exports.dropAndCreate = dropAndCreate;
exports.backupBeforeDrop = backupBeforeDrop;
exports.servers = servers;
exports.dumpRootDir = dumpRootDir;
exports.mysqlPath = mysqlPath;
exports.mysqldumpPath = mysqldumpPath;

exports.backupRootDir = backupRootDir;

exports.verifyAndInitialize = verifyAndInitialize;

exports.getAfterFile = getAfterFile;
exports.getBeforeFile = getBeforeFile;
exports.getSchemasFilePath = getSchemasFilePath;
exports.getRecordsRequiredFilePath = getRecordsRequiredFilePath;
exports.getRecordsOptionalFilePath = getRecordsOptionalFilePath;
exports.getSchemasFileName = getSchemasFileName;
exports.getRecordsRequiredFileName = getRecordsRequiredFileName;
exports.getRecordsOptionalFileName = getRecordsOptionalFileName;

exports.getBackupDir = getBackupDir;
