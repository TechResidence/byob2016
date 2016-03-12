var Bleacon = require('bleacon');
var uuid = 'B9407F30-F5F8-466E-AFF9-25556B57FE6D';
var major = 0;
var minor = 1;
var measuredPower = -59;
Bleacon.startAdvertising(uuid, major, minor, measuredPower);
