<style>

.plus-icon {
    background-image: url("<g:resource dir="images" file="plus.png"></g:resource>") !important;
    background-size: 100%;
    margin-right: 5px;
}

.minus-icon {
    background-image: url("<g:resource dir="images" file="minus.png"></g:resource>") !important;
    background-size: 100%;
    margin-right: 5px;
}
</style>





<script>

    $("#loading-indicator").show();

    $(document).ready(function () {


        // $('#addDependencyDialog').dialog({
        //     autoOpen: false
        // });

        var url = "<g:createLink controller="books" action="getDataForFirstTable"/>";

        var firstTable = $('#firstTable').DataTable({
            height: "300px",
            scrollY: "100",
            "ajax": {
                "url": url,
                "dataSrc": "",
                "complete": function () {
                    $('#count').text(firstTable.data().count());
                },
                "error": function () {
                    alert("error happened");
                }
            },
            "columns": [
                {
                    "data": "id",
                    //render is used for manipulating with data
                    "render": function (data, type, row, meta) {
                        var url = '${createLink(controller: 'books', base: 'serverUrl')}' + '/' + row.id;
                        return '<a href="' + url + '" target="_blank">' + 'my link</a>'
                    }
                },
                {"data": "author"},
                {"data": "name"}
            ],
            "initComplete": function (settings, json) {
                $("#loading-indicator").hide();
            }
        });

        $("#accordion").accordion({
            header: $(".accordionSection"),
            heightStyle: "content",
            icons: {"header": "plus-icon", "activeHeader": "minus-icon"}

        }).ready(function () {
            0 > 0 ? $("#accordion").accordion("option", "active", 0) : $("#accordion").accordion("option", "active", 1)
        });

        $('#tablesDialog').dialog('open');
    });

</script>

<div id="tablesWrapper" style="height: 400px">

    <div id="accordion">
        <h2 id="firstLabel" class="raz accordionSection">first table <span id="count"></span></h2>

        <div id="firstTableWrapper">
            <table id="firstTable">
                <thead>
                <tr>
                    <th>id</th>
                    <th>Name</th>
                    <th>Author</th>
                </tr>
                </thead>
            </table>
        </div>

        <h2 class="accordionSection">second table</h2>

        <div id="secondTableWrapper">
            <g:render template="secondTable"></g:render>
        </div>
    </div>
</div>

<div id="addDependencyDialog">
    %{-- template can be rendered immediately as following way--}%

    %{--<g:render template="addDependencyDialog"></g:render>--}%
</div>




