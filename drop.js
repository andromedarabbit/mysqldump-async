#!/usr/bin/env node
var info = require('./info.js');
var dump = require('./dump.js');
var common = require('./common.js');
var shell = require('shelljs');
var path = require('path');
var sprintf = require('sprintf').sprintf;

var servers = info.servers;
// var dumpRootDir = info.dumpRootDir;
var mysqlPath = info.mysqlPath;
var mysqldumpPath = info.mysqldumpPath;


function dropDatabasesAsync() {
	info.verifyAndInitialize();

	var servers = info.servers;
	var backupDir = info.getBackupDir();
	for(var i in servers) {
		var server = servers[i];

		dropDatabaseAsync(server, backupDir);
	}
}

function dropDatabaseAsync(server, dumpRootDir, callback) {
	if(info.backupBeforeDrop) {
		dump.dumpDatabase(server, dumpRootDir);
	}

	var query = sprintf(
		"drop database IF EXISTS %s;",
		server["database"]
	);

	common.executeQueryAsync(query, server, "mysql", callback);
}


exports.dropDatabasesAsync = dropDatabasesAsync;
exports.dropDatabaseAsync = dropDatabaseAsync;
