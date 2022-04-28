jQuery.extend( jQuery.fn.dataTableExt.oSort, {
    "title-string-pre": function ( a ) {
        if (a.match(/title="(.*?)"/) == null) {
            return a.match(/title='(.*?)'/)[1].toLowerCase();
        } else {
            return a.match(/title="(.*?)"/)[1].toLowerCase();
        }
    },
 
    "title-string-asc": function ( a, b ) {
        return ((a < b) ? -1 : ((a > b) ? 1 : 0));
    },
 
    "title-string-desc": function ( a, b ) {
        return ((a < b) ? 1 : ((a > b) ? -1 : 0));
    }
} );