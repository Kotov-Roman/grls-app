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

    <script>
        $(document).ready(function () {
            // $('#addDependencyDialog').dialog({
            //     autoOpen: false
            // });


            $('#tablesDialog').dialog({
                minHeight: 800,
                width: '1000px',
                autoOpen: false,
                title: 'Basic Dialog',
                buttons: [
                    {
                        text: "manage dependencies",
                        icon: "ui-icon-heart",
                        click: function () {
                            // $('#addDependencyDialog').dialog('open');
                            <g:remoteFunction controller="books" action="addDependencyDialog" update="addDependencyDialog"></g:remoteFunction>
                        }
                    }
                ]
            });

            $('#opener').click(function () {
                <g:remoteFunction controller="books" action="renderTablesDialog" update="tablesDialog"></g:remoteFunction>
            });
            $('#dataGenerator').click(function () {
                <g:remoteFunction controller="books" action="generateDataForFirstTable"></g:remoteFunction>
            });

            jQuery.ajax({
                type: 'POST',
                url: "<g:createLink controller="books" action="getFirstData" params="[foo: 'bar', name: 'far']"/>",
                success: function (data, textStatus) {
                    jQuery('#secondData').text(data.name);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });



        //     $('#drop').change(function(event){
        //         files = event.target.files;
        //         $('#drop').css('display', 'none');
        //         for(var i = 0, len = files.length; i < len; i++) {
        //             file = files[i];
        //             if((file.fileName+"").substring((file.fileName+"").length-4,(file.fileName+"").length)=='.mp3'){
        //                 $.ajax({
        //                     type: "POST",
        //                     url: "uploader.php?id="+i,
        //                     contentType: "multipart/form-data",
        //                     headers: {
        //                         "X-File-Name" : file.fileName,
        //                         "X-File-Size" : file.fileSize,
        //                         "X-File-Type" : file.type
        //                     },
        //                     beforeSend:  function() {
        //                         $('#info').append('<li class="indicator"><span class="label">File Name :</span> '+file.fileName+' | <span class="label">Size :</span> ' + file.fileSize + ' | <img id="item'+i+'" src="loading.gif" /></li>');
        //                     },
        //                     processData: false,
        //                     data: file,
        //                     success: function(data){
        //                         $('#item'+data).attr('src', 'check.png');
        //                     },error: function(data){
        //                         $('#info').append('Error: ' + data + '<br />');
        //                     }
        //                 });
        //             }else{
        //                 $('#info').append('Error: Incorrect file type. Looking for .mp3');
        //             }
        //         }
        //     });
        //

             $('#postCheck').click(function () {
                  $.ajax({
                       type: "POST",
                       url: "<g:createLink controller="books" action="testPost" params="[id: '999']"/>",
                       contentType: "application/x-www-form-urlencoded",
                       headers: {

                       },
                       beforeSend:  function() {
                    //       $('#info').append('<li class="indicator"><span class="label">File Name :</span> '+file.fileName+' | <span class="label">Size :</span> ' + file.fileSize + ' | <img id="item'+i+'" src="loading.gif" /></li>');
                       },
                       processData: false,
                       success: function(data){
                           alert('ok');
                       },error: function(data){
                           alert('not ok');
                       }
                   });

            });

            $('#disable').click(function () {
            alert('CLIED');
            });
        });
    </script>

</head>

<body>

<img id="loading-indicator" src="${resource(dir: 'images', file: 'spinner.gif')} " alt="Grails"/>

<ul>
		<li><g:link controller='books' action='testPost' params="[enabled: false]">tets post grails link</g:link></li>
		<li><g:link controller='books' action='index' params="[enabled: true]">index grails link</g:link></li>
		<li><a id="disableACT" href="#">Disable ACT</a></li>
        <li><a id="enableACT" href="#">Enable ACT</a></li>
</ul>


    <button id="postCheck">
        Post
    </button>

<button id="opener">
    Open tables dialog
</button>

<button id="dataGenerator">
    Generate data for first table
</button>

<g:form controller="books">
    <g:actionSubmit value="clearFirstTable" action="clearFirstTable"/>
</g:form>
<div>
    text
    %{--<uploadr:add name="myFifthUploadr1" path="/tmp" direction="up" rating="true" class="demo" placeholder="Behold: the drop area!" fileselect="Behold: the fileselect!" maxVisible="4" noSound="true">--}%

    %{--</uploadr:add>--}%
</div>
<div>
    <g:form enctype='multipart/form-data' method='POST' action='saveUserProfile' controller='user'>
        <input type='file' name='userFiles[]' multiple />    //Using this we have upload multiple files in one go.
        <button type='submit'>Submit</button>
    </g:form>
</div>
<div id="secondData"/>

<div id="tablesDialog"/>

<div id="addDependencyDialog">

    <r:layoutResources/>

</body>
%{--<body>--}%
%{--<div id="drop">--}%
    %{--<h1>Drop files here</h1>--}%
    %{--<p>To add them as attachments</p>--}%
    %{--<input type="file" multiple="true" id="filesUpload" />--}%
%{--</div>--}%
%{--<div id="info">--}%
%{--</div>--}%
%{--</body>--}%
</html>