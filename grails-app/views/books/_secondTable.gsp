<script>
    $(document).ready(function () {


        var secondtable = $('#secondTable').DataTable({
            // scrollResize: true,
            // // height: "300px",
            // scrollY: "100",
            // "order": [[2 , 'desc']],
            "order": [[2, 'asc']],
            "ajax": {
                "url": "<g:createLink controller="books" action="getDataForSecondTable"/>",
                "dataSrc": ""
            },
            "columns": [
                {
                    "data": "id",
                    "orderable": false,
                    "width": "10%",
                    // "defaultContent": "<button>Delete!</button><button>Edit!</button>"
                    "render": function (id, type, row, meta) {
                        console.log(id);
                        console.log(type);
                        console.log(row);
                        console.log(meta);

                        var url = '${createLink(controller: 'books', base: 'serverUrl')}' + '/' + row.id;
                        var dataIdAttr = 'data-id="' + id + '" ';
                        var dataRowAttr = 'data-dt-row="' + meta.row + '" ';
                        console.log(dataIdAttr);
                        console.log(dataRowAttr);
                        var buttonDelete = '<button class="delete-btn" ' + dataIdAttr + dataRowAttr + '>Delete!</button>';
                        console.log(buttonDelete);
                        return buttonDelete
                    }
                },
                {
                    "data": "secondName",
                    "width": "10%"
                },
                {
                    "data": "description"
                    // "order": [[2 , 'asc']]
                }
            ],
            "initComplete": function (settings, json) {
                $('.delete-btn').click(function (event) {
                    var target = event.target;
                    debugger;
                    console.log(secondtable.row(target).data());
                    var description = secondtable.row(target).data().description;
                    console.log('description= ' + description);
                    var relationshipId = target.dataset.id;
                    var data = {
                        "id": relationshipId,
                        "description": description
                    };

                    console.log({"id": relationshipId});
                    $.ajax({
                        url: '<g:createLink action="openDeleteDialog"></g:createLink>',
                        data: data,
                        success: function (data) {
                            jQuery('#addDependencyDialog').html(data);
                        },
                        error: function (response, textStatus, errorThrown) {
                            alert('something went wrong on server side')
                        }

                    });
                });
            }
        });
    });
</script>

<table id="secondTable" class="display nowrap" style="width:100%">
    <thead>
    <tr>
        <th>id</th>
        <th>Second Name</th>
        <th>Description</th>
    </tr>
    </thead>
</table>