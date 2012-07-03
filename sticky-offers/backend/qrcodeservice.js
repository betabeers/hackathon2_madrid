var qrcode = require('qrcode');

exports.getqrcodeimage = function(value, callback) {
  qrcode.toDataURL(value, function(err, qr) {
    callback(qr);
  });
}