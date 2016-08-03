#!/usr/bin/env node
var info = require('./info.js');
var common = require('./common.js');
var shell = require('shelljs');
var path = require('path');
var sprintf = require('sprintf').sprintf;

var servers = info.servers;
var mysqldumpPath = info.mysqldumpPath;

info.verifyAndInitialize();

function dumpDatabases() {
	info.verifyAndInitialize();
	
	dumpDatabasesTo(info.dumpRootDir);
}


function dumpDatabasesTo(dumpRootDir) {
	
	for(var i in servers) {
		var server = servers[i];
	
		dumpDatabase(server, dumpRootDir);
	}
}


function dumpDatabase(server, dumpRootDir, callback) {
	var cmd = sprintf(
		"%s -h %s --port=%s -u %s --password=\"%s\" \"%s\" --add-locks --comments --skip-compact --default-character-set=utf8 --hex-blob --disable-keys --skip-dump-date --skip-extended-insert --lock-tables --quick --quote-names --set-charset --tz-utc",
		mysqldumpPath,
		server["hostname"],
		server["port"],
		server["username"],
		server["password"],
		server["database"]
	);
	
	
	cmd += getIgnoreTableSwitches(server);
	
	if(dumpRootDir && !shell.test('-e', dumpRootDir)) {
		shell.mkdir('-p', dumpRootDir);
	}

	dumpSchemas(cmd, dumpRootDir, server);

	cmd += getCleanTableSwitches(server);

	dumpRecordsRequired(cmd, dumpRootDir, server);

	dumpRecordsOptional(cmd, dumpRootDir, server);

	dumpTriggers(cmd, dumpRootDir, server);
}

function dumpSchemas(cmd, dumpRootDir, server) {
	var outputFilePath = path.join(dumpRootDir, info.getSchemasFileName(server));

	var cmd = sprintf("%s --no-data --result-file=\"%s\" ", cmd, outputFilePath);

	cmd += getSchemasSwitches(server);

	common.executeCmdSync(cmd);
}

function getSchemasSwitches(server) {
	return "--add-drop-database --create-options --events --routines --skip-triggers";
}

function dumpTriggers(cmd, dumpRootDir, server) {
	var outputFilePath = path.join(dumpRootDir, info.getTriggersFileName(server));

	var cmd = sprintf("%s --no-data --result-file=\"%s\" ", cmd, outputFilePath);

	cmd += getTriggersSwitches(server);

	common.executeCmdSync(cmd);
}

function getTriggersSwitches(server) {
	return "--no-create-info --no-data --no-create-db --skip-opt --triggers";
}

function dumpRecordsRequired(cmd, dumpRootDir, server) {
	var outputFilePath = path.join(dumpRootDir, info.getRecordsRequiredFileName(server));

	if(hasTablesRequired(server) == false) {
		shell.rm('-f', outputFilePath);
		common.executeCmdSync('touch \"' + outputFilePath + "\"");
		return;
	}

	var cmd = sprintf("%s --no-create-info --skip-triggers --result-file=\"%s\" ", cmd, outputFilePath);

	cmd += getTablesRequiredSwitches(server);

	common.executeCmdSync(cmd);
}

function hasTablesRequired(server) {
	if( !server || !server.tables || !server.tables.require ) {
		return false;
	}

	var tables = server["tables"]["require"];
	if(tables.length == 0) {
		return false;
	}

	return true;
}

function getTablesRequiredSwitches(server) {
	if( hasTablesRequired(server) == false) {
		return "";
	}

	var tables = server["tables"]["require"];

	var switches = "--tables";
	for(var i in tables) {
		var table = tables[i];

		switches = sprintf("%s \"%s\" ", switches, table);
	}
	return switches;
}


function dumpRecordsOptional(cmd, dumpRootDir, server) {
	var outputFilePath = path.join(dumpRootDir, info.getRecordsOptionalFileName(server));

	var cmd = sprintf("%s --no-create-info --skip-triggers --result-file=\"%s\" ", cmd, outputFilePath);

	if( server && server.tables && server.tables.require) {
		cmd += getIgnoreTableSwitchesInternal(server["database"], server["tables"]["require"]);
	}

	common.executeCmdSync(cmd);
}


function getTablesOptionalSwitches(server) {
	if( !server || !server.tables || !server.tables.require) {
		return "";
	}

	var tables = server["tables"]["require"];
	if(tables.length == 0) {
		return "";
	}

	return getIgnoreTableSwitches(server);
}

function getIgnoreTableSwitches(server) {
	if( !server || !server.tables || !server.tables.ignore) {
		return "";
	}

	return getIgnoreTableSwitchesInternal(server["database"], server["tables"]["ignore"]);
}

function getIgnoreTableSwitchesInternal(database, tablesToIgnore) {
	var switches = "";
	for(var i in tablesToIgnore) {
		switches = sprintf("%s --ignore-table=\"%s.%s\"", switches, database, tablesToIgnore[i]);
	}
	return switches;
}

function getCleanTableSwitches(server) {
	if( !server || !server.tables || !server.tables.clear) {
		return "";
	}

	return getIgnoreTableSwitchesInternal(server["database"], server["tables"]["clear"]);
}

exports.dumpDatabase = dumpDatabase;
exports.dumpDatabases = dumpDatabases;
exports.dumpDatabasesTo = dumpDatabasesTo;
