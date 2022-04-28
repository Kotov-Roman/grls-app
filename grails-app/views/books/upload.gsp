<%--
  Created by IntelliJ IDEA.
  User: Kotov
  Date: 12.10.2020
  Time: 15:05
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>


    #loading-indicator {
        width: 3%;
        position: absolute;
        top: 50%;
        left: 90%;
        z-index: 100;
        display: none;
    }
    </style>

    <title>BOOKS MAIN PAGE</title>


    <r:require modules="jquery"/>

    %{--<asset:javascript src="uploadr.manifest.js"/>--}%
    %{--<asset:stylesheet href="uploadr.manifest.css"/>--}%

    %{--<asset:javascript src="uploadr.demo.manifest.js"/>--}%
    %{--<asset:stylesheet href="uploadr.demo.manifest.css"/>--}%

    %{--<asset:stylesheet src="grails-datatables.css"/>--}%
    %{--<asset:stylesheet src="grails-datatables-plain.css"/>--}%
    %{--<asset:javascript src="grails-datatables.js"/>--}%


    %{-- <r:layoutResources/> is used for creating links to resources like <r:require modules="jquery, jquery-ui,core"/>--}%
    %{--those resources can be set up in Config or in ApplicationResources, plugins are assigned in BuildConfig--}%
    %{--tag needs to be written is head and body as well in order to correctly process <r:require> everywhere--}%
    <r:layoutResources/>

    <link rel="stylesheet" type="text/css"
          href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>

    %{--script are used here because i haven't enough time to include and configure them properly--}%
    %{--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--}%
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/dataTables.jqueryui.min.js"></script>
    <script src="https://cdn.datatables.net/scroller/2.0.3/js/dataTables.scroller.min.js"></script>

</head>


<body>

<script>


    $(document).ready(function () {
        $('.add_more').click(function (e) {
            e.preventDefault();
            $(this).before("<input name='file' type='file'/>");
        });


        $('#upload').click(function () {
            var filedata = document.getElementsByName("file"),
                formdata = false;
            if (window.FormData) {
                formdata = new FormData();
            }
            var files = filedata[0].files;
            debugger;

            // formdata.append('files', files);


            // for (; i < len; i++) {
            //     file = filedata.files[i];
            //
            //     if (window.FileReader) {
            //         reader = new FileReader();
            //         reader.onloadend = function (e) {
            //             showUploadedItem(e.target.result, file.fileName);
            //         };
            //         reader.readAsDataURL(file);
            //     }
            //     if (formdata) {
            //         formdata.append("file", file);
            //     }
            // }
            // $.each(files, function (j, file) {
            //     formdata.append('file[' + j + ']', file);
            // });

            formdata.append('file[0]', files[0]);
            formdata.append('file[1]', files[1]);
            formdata.append('notificationId', '12345');

            debugger;

        //     files.forEach(file, j = > formdata.append('file[' + j + ']', file))
        // )
        //     ;


            if (formdata) {
                $.ajax({
                    url: "${createLink(controller: 'books', action: 'upload')}",
                    type: "POST",
                    data: formdata,
                    processData: false,
                    contentType: false,
                    success: function (res) {
                        console.log('success')

                    },
                    error: function (res) {

                    }
                });
            }
        });

    });


</script>

<div>
    <form enctype="multipart/form-data" action="upload.php" method="post">
        <input name="file" type="file" multiple/>
        <button class="add_more">Add More Files</button>
        <input type="button" value="Upload File" id="upload"/>
    </form>
</div>

</body>