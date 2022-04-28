$.fn.dataTableExt.oApi.fnStandingRedraw = function(oSettings) {
    if(oSettings) {
        if (oSettings.oFeatures.bServerSide === false) {
            var before = oSettings._iDisplayStart;

            oSettings.oApi._fnReDraw(oSettings);

            // iDisplayStart has been reset to zero - so lets change it back
            oSettings._iDisplayStart = before;
            oSettings.oApi._fnCalculateEnd(oSettings);
        }

        // draw the 'current' page
        oSettings.oApi._fnDraw(oSettings);
        // TODO: Don't think this should go in here, gotta be a way to tap into it somewhere not in a data tables js file. Not a fan of custom js in their files as it will get lost during upgrade.
        window.setTimeout(function () {
            var selectedolditem = localStorage.getItem('selectedolditem');
            if (selectedolditem != null) {
                var parentTr = $('#' + selectedolditem).parent().parent();
                var trClass = parentTr.attr('class');
                var trIndex = parentTr.index('tr.' + trClass);
                $("table.dataTable").each(function (index) {
                    $(this).find("tr." + trClass + ":eq(" + trIndex + ")").each(function (index) {
                        $(this).addClass("highlight");
                    });
                });
            }
        }, 1000);
    }
};
