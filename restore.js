#!/usr/bin/env node
var info = require('./info.js');
var common = require('./common.js');
var dropJs = require('./drop.js');
var shell = require('shelljs');

var servers = info.servers;

function restoreDatabasesAsync() {
	info.verifyAndInitialize();
	
	var backupDir = info.getBackupDir();
	
	for(var i in servers) {
		var server = servers[i];
			
		restoreDatabaseAsync(server, backupDir);
	}
}


function restoreDatabaseAsync(server, backupDir) {
	if(!info.dropAndCreate) {
		restoreDatabaseAsyncInternal(server);
		return;
	}

	dropJs.dropDatabaseAsync(server, backupDir, function() {
		restoreDatabaseAsyncInternal(server);
	});
	
}


function restoreDatabaseAsyncInternal(server) {
	var beforeFile = info.getBeforeFile(server);

	if( shell.test('-e', beforeFile) ) { 
		common.executeSqlFileAsync(beforeFile, server, "mysql", function() {
			restoreSchemasAndRecordsAsync(server);
		});
		return;
	}
	
	restoreSchemasAndRecordsAsync(server);
}


function restoreSchemasAndRecordsAsync(server) {
	var schemasFilePath = info.getSchemasFilePath(server);
	common.executeSqlFileAsync(schemasFilePath, server, server["database"], function() {
		var recordsRequiredFilePath = info.getRecordsRequiredFilePath(server);
		common.executeSqlFileAsync(recordsRequiredFilePath, server, server["database"], function() {
			var recordsOptionalFilePath = info.getRecordsOptionalFilePath(server);
			common.executeSqlFileAsync(recordsOptionalFilePath, server, server["database"], function() {
				var afterFile = info.getAfterFile(server);
				if(!afterFile) {
					common.executeSqlFileAsync(afterFile, server, server["database"]);
				}
			});
		});
	});
}

exports.restoreDatabaseAsync = restoreDatabaseAsync;
exports.restoreDatabasesAsync = restoreDatabasesAsync;
