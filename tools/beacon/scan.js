Bleacon = require('bleacon');
Bleacon.startScanning('B9407F30-F5F8-466E-AFF9-25556B57FE6D');

Bleacon.on('discover', function(bleacon) {
   console.dir(bleacon);
})


