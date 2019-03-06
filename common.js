#!/usr/bin/env node
var shell = require('shelljs');
var info = require('./info.js')

function executeCmdAsync(cmd, callback) {
	console.log(cmd);

	var executable = shell.exec( cmd, {async:true, silent:true}, function(code, output) {

		if(code != 0) {
			console.error('error occurs with an exit code ' + code);
			console.log();

			console.error('Program output:');
			console.error(output);

			shell.exit(code);
		}

		if(callback) {
			callback();
		}
	});
}



function executeCmdSync(cmd) {
	console.log(cmd);

	var executable = shell.exec( cmd, {async:false, silent:true} );
	var code = executable.code;

	if(code != 0) {
		console.error('\terror occurs: exit code ' + code);
		console.error('\terror message: ' + executable.stderr);
		shell.exit(code);
	}else {
		console.log('\tExit code:', code + '\n');
	}
}

function executeQueryAsync(query, server, database, callback) {
	if( !database ) {
		database = "mysql";
	}

	var sprintf = require('sprintf').sprintf;

	var cmd = sprintf(
		"%s -h %s --port=%s -u %s --password=\"%s\" -e \"%s\" \"%s\" ",
		info.mysqlPath,
		server["hostname"],
		server["port"],
		server["username"],
		server["password"],
		query,
		database
	);

	executeCmdAsync(cmd, callback);
}

function executeQuerySync(query, server, database) {
	if( !database ) {
		database = "mysql";
	}

	var sprintf = require('sprintf').sprintf;

	var cmd = sprintf(
		"%s -h %s --port=%s -u %s --password=\"%s\" -e \"%s\" \"%s\" ",
		info.mysqlPath,
		server["hostname"],
		server["port"],
		server["username"],
		server["password"],
		query,
		database
	);

	executeCmdSync(cmd);
}


function executeSqlFileAsync(filePath, server, database, callback) {
	if( !shell.test('-e', filePath) ) {
		console.error('File Not Found: ' + filePath);
		shell.exit(1);
	}

	if( !database ) {
		database = server["database"];
	}

	var sprintf = require('sprintf').sprintf;

	var cmd = sprintf(
		"%s -h %s --port=%s -u %s --password=\"%s\" \"%s\" < \"%s\"",
		info.mysqlPath,
		server["hostname"],
		server["port"],
		server["username"],
		server["password"],
		database,
		filePath
	);

	executeCmdAsync(cmd, callback);
}

function executeSqlFileSync(filePath, server, database) {
	if( !shell.test('-e', filePath) ) {
		console.error('File Not Found: ' + filePath);
		shell.exit(1);
	}

	if( !database ) {
		database = server["database"];
	}

	var sprintf = require('sprintf').sprintf;

	var cmd = sprintf(
		"%s -h %s --port=%s -u %s --password=\"%s\" \"%s\" < \"%s\"",
		info.mysqlPath,
		server["hostname"],
		server["port"],
		server["username"],
		server["password"],
		database,
		filePath
	);

	executeCmdSync(cmd);
}



exports.executeCmdAsync = executeCmdAsync;
exports.executeCmdSync = executeCmdSync;
exports.executeQueryAsync = executeQueryAsync;
exports.executeQuerySync = executeQuerySync;
exports.executeSqlFileAsync = executeSqlFileAsync;
exports.executeSqlFileSync = executeSqlFileSync;
