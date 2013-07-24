PackNaturals = {
    ABC: 'hdOBCH8Rz~926xKW_vLAwl0Ey3aYpUPkqZ7Q4fVjFgJcXDbTum1SteInGriMs5oN',
    pack: function(sorted_numbers) {
        var output = "";
        var n = 0,
            last = 0;
        for(var i in sorted_numbers) {
            n = sorted_numbers[i] - last; // Asserting n >= 0
            last = sorted_numbers[i];
            if(n == 0) {
                output += this.ABC.charAt(32);
                continue;
            }
            while(n) {
                var j = n % 32;
                n = ~~(n / 32);
                if(n) output += this.ABC.charAt(j);
                else  output += this.ABC.charAt(j + 32);
            }
        }
        return output;
    },
    unpack: function(string) {
        var rel = new Array(),
            out = new Array();
        var shift = 0,
            carry = 0;
        for(var i in string) {
            var s = string[i];
            var n = this.ABC.indexOf(s);
            if(n < 32) {
                carry += (n << shift);
                shift += 5;
            } else {
                n -= 32;
                rel.push(carry + (n << shift));
                shift = 0;
                carry = 0;
            }
        }
        for(var j in rel)
            out.push((out[j-1] || 0) + rel[j]);
        return out;
    }
};
