"use strict";

var electron = require('electron');
var path = require('path');
var url = require('url');

exports.foreign_app = function () {
  return electron.app;
};

exports.foreign_createWindow = function (file, width, height) {
  return function() {
    var win = new electron.BrowserWindow({ 
      width: width, 
      height: height
    });

    win.loadURL(url.format({
      pathname: path.join(__dirname, '../..', file),
      protocol: 'file:',
      slashes: true
    }));
  };
};

exports.foreign_listen = function (ob, name, fn) {
  return function() {
    ob.on(name, fn());
  };
};

