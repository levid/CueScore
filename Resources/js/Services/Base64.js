// Generated by CoffeeScript 1.3.1
(function() {
  var Base64;

  Base64 = {
    encode: function(data) {
      var b64_map, byte1, byte2, byte3, ch1, ch2, ch3, ch4, i, j, result;
      if (typeof btoa === "function") {
        return btoa(data);
      }
      b64_map = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
      byte1 = void 0;
      byte2 = void 0;
      byte3 = void 0;
      ch1 = void 0;
      ch2 = void 0;
      ch3 = void 0;
      ch4 = void 0;
      result = new Array();
      j = 0;
      i = 0;
      while (i < data.length) {
        byte1 = data.charCodeAt(i);
        byte2 = data.charCodeAt(i + 1);
        byte3 = data.charCodeAt(i + 2);
        ch1 = byte1 >> 2;
        ch2 = ((byte1 & 3) << 4) | (byte2 >> 4);
        ch3 = ((byte2 & 15) << 2) | (byte3 >> 6);
        ch4 = byte3 & 63;
        if (isNaN(byte2)) {
          ch3 = ch4 = 64;
        } else {
          if (isNaN(byte3)) {
            ch4 = 64;
          }
        }
        result[j++] = b64_map.charAt(ch1) + b64_map.charAt(ch2) + b64_map.charAt(ch3) + b64_map.charAt(ch4);
        i += 3;
      }
      return result.join("");
    },
    decode: function(data) {
      var b64_map, byte1, byte2, byte3, ch1, ch2, ch3, ch4, i, j, result;
      data = data.replace(/[^a-z0-9\+\/=]/g, "");
      if (typeof atob === "function") {
        return atob(data);
      }
      b64_map = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
      byte1 = void 0;
      byte2 = void 0;
      byte3 = void 0;
      ch1 = void 0;
      ch2 = void 0;
      ch3 = void 0;
      ch4 = void 0;
      result = new Array();
      j = 0;
      while ((data.length % 4) !== 0) {
        data += "=";
      }
      i = 0;
      while (i < data.length) {
        ch1 = b64_map.indexOf(data.charAt(i));
        ch2 = b64_map.indexOf(data.charAt(i + 1));
        ch3 = b64_map.indexOf(data.charAt(i + 2));
        ch4 = b64_map.indexOf(data.charAt(i + 3));
        byte1 = (ch1 << 2) | (ch2 >> 4);
        byte2 = ((ch2 & 15) << 4) | (ch3 >> 2);
        byte3 = ((ch3 & 3) << 6) | ch4;
        result[j++] = String.fromCharCode(byte1);
        if (ch3 !== 64) {
          result[j++] = String.fromCharCode(byte2);
        }
        if (ch4 !== 64) {
          result[j++] = String.fromCharCode(byte3);
        }
        i += 4;
      }
      return result.join("");
    }
  };

}).call(this);
