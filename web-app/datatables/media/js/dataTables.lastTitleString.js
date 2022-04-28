jQuery.extend( jQuery.fn.dataTableExt.oSort, {
    "last-title-string-pre": function ( a ) {
        console.log(a);

        if (a.match(/.*(title="(.*?)")/) == null) {
            return a.match(/.*(title='(.*?)')/)[1].toLowerCase();
        } else {
            return a.match(/.*(title="(.*?)")/)[1].toLowerCase();
        }
    },
 
    "last-title-string-asc": function ( a, b ) {
        return ((a < b) ? -1 : ((a > b) ? 1 : 0));
    },
 
    "last-title-string-desc": function ( a, b ) {
        return ((a < b) ? 1 : ((a > b) ? -1 : 0));
    }
} );