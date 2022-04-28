<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <style>

    .remove-icon {
        display: flex;
        background-image: url("<g:resource dir="images" file="remove.png"/>") ;
        background-size: 100%;
        margin-left: 5px;
        width: 15px;
        height: 15px;
    }

    #gallery img {
        width: 150px;
        margin-bottom: 10px;
        margin-right: 10px;
        vertical-align: middle;
    }

    .button {
        padding: 10px;
        background: #ccc;
        cursor: pointer;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    .button:hover {
        background: #ddd;
    }

    #fileElem {
        display: none;
    }

    .drop-area {
        border: 2px dashed #ccc;
        border-radius: 20px;
        width: 480px;
        font-family: sans-serif;
        text-align: center;
        height: 100px;
    }

    .drop-area.highlight {
        border-color: purple;
    }

    .flex-column {
        display: flex;
        flex-direction: column;
    }

    .flex-row-center {
        display: flex;
        align-items: center;
    }

    .flex-row {
        display: flex;
    }

    .file-item {
        display: flex;
        align-items: center;
        height: 20px;
        margin-left: 10px;
    }


    </style>

    <title>Upload</title>


    <r:require modules="jquery"/>

    <r:layoutResources/>

    <link rel="stylesheet" type="text/css"
          href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/dataTables.jqueryui.min.js"></script>
    <script src="https://cdn.datatables.net/scroller/2.0.3/js/dataTables.scroller.min.js"></script>

</head>
%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%

<body>

<div id="myUploader" class="flex-row">

    <div id="notificationComment" class="flex-column">
        <div >
            <label class="flex-row-center">
                <p>Describe changes in the source document</p><span>info</span>
            </label>
        </div>
        <div>
            <textarea id="comment-input" class="form-control" style="resize: vertical"
                      placeholder="Write a short comment describing the changes" cols="50" rows="6" maxlength="600"></textarea>
        </div>
    </div>

    <div class="flex-column" style="margin-left: 20px">
        <div>
            <label class="button" for="fileElem">Select some files</label>
        </div>

        <div class="flex-row" style="margin-top: 20px;">
            <div id="drop-area" class="drop-area">
                <form class="my-form">
                    <p>Drag and drop files here to attach</p>
                    <input type="file" id="fileElem" multiple accept="image/*" onchange="handleChosenFiles(this.files)">
                </form>
            </div>

            <div id="storedFilesWrapper" style="max-width: 500px">
                <h4 style="margin: 0px 5px;;">Attached files:</h4>

                <div id="storedFiles" class="">
                    <div class="file-item"><p class="">name</p><span class="remove-icon remove-file-js"
                                                                           title="remove"></span></div>
                </div>
            </div>
        </div>

    </div>

</div>

<div>
    <button onclick="sendFiles()">send files</button>
</div>

%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%
%{--//////////////////////////////////////////////////////////////////--}%

<script>
    let dropArea = document.getElementById('drop-area');
    let $storedFilesDiv = $('#storedFiles');
    let storedFilesList = new Array();

    const VALID_EXTENSIONS = new Set(['doc', 'docx', 'pdf', 'jpg', 'jpeg']);
    const INVALID_EXTENTION_MESSAGE = 'Valid extensions for attachments are .doc, .docx, .pdf, .jpeg and .jpg';
    const MAX_ATTACHED_FILES = 5;
    const MAX_ATTACHED_FILES_EXCEEDED_MESSAGE = "The maximum number of files couldn't exceed 5 " ;
    const ATTACHMENTS_MAX_SIZE = 10 * 1024 * 1014 ; // 10 Mb
    const MAX_SIZE_EXCEEDED = 'Maximum size of attachments is 10mb' ; // 10 Mb

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, preventDefaults, false)
    });

    ['dragenter', 'dragover'].forEach(eventName => {
        dropArea.addEventListener(eventName, highlight, false)
    });

    ;['dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, unhighlight, false)
    });

    dropArea.addEventListener('drop', handleDroppedFiles, false);

    $storedFilesDiv.on('click', '.remove-file-js', handleRemove);

    function handleDroppedFiles(e) {
        let dt = e.dataTransfer;
        var addedFiles = Array.from(dt.files);
        handleFiles(addedFiles);
    }

    function highlight(e) {
        $(dropArea).addClass('highlight')
    }

    function unhighlight(e) {
        $(dropArea).removeClass('highlight')
    }

    function preventDefaults(e) {
        console.log('1');
        e.preventDefault();
        e.stopPropagation();
    }

    function handleChosenFiles(chosenFiles) {
        var addedFiles = Array.from(chosenFiles);
        handleFiles(addedFiles);
    }

    function createHtmlForStoredFile(file) {
        let fileName = file.name;
        let html = '<div class="file-item" style="height:25px" ><p>'+ fileName+ '</p><span class="remove-icon remove-file-js" title="remove"></span></div>';
        return html;
    }

    function handleRemove(e) {
        var target = e.target;
        var fileName = $(target).prev().text();

        storedFilesList = storedFilesList.filter(file => file.name != fileName);
        redrawStoredFilesDiv();
    }

    function redrawStoredFilesDiv() {
        $storedFilesDiv.empty();
        displayFilesOnPage(storedFilesList);
    }

    function displayFilesOnPage(files) {
        $.each(files, function (index, file) {
            let html = createHtmlForStoredFile(file);
            $storedFilesDiv.append(html);
        });
    }

    function handleFiles(addedFiles) {

        var validationResult = validateFiles(addedFiles);
        //if valid -> add to stored files and redraw
        if(validationResult.isValid){
            storedFilesList = storedFilesList.concat(addedFiles);
            redrawStoredFilesDiv();
        }
        else {
            showValidationMessage(validationResult.message);
        }
    }

    function validateFiles(addedFiles) {
        var validationResult;

        validationResult = validateExtensions(addedFiles);
        if(!validationResult.isValid){
            return validationResult
        }

        validationResult = validateNumberOfAttachedFiles(addedFiles);
        if(!validationResult.isValid){
            return validationResult
        }

        validationResult = validateTotalSizeOfAttachments(addedFiles);
        if(!validationResult.isValid){
            return validationResult
        }

        return validationResult
    }

    function validateExtensions(addedFiles) {

        var extensions = addedFiles.map(file => getExtension(file.name));

        for (var i = 0; i <extensions.length ; i++) {
            if(!VALID_EXTENSIONS.has(extensions[i])){
                return {
                    isValid: false,
                    message: INVALID_EXTENTION_MESSAGE}
            }
        }
        return {isValid: true}
    }

    function validateNumberOfAttachedFiles(addedFiles) {

        var totalNumber = addedFiles.length + storedFilesList.length;

        if (totalNumber>MAX_ATTACHED_FILES) {
            return {
                isValid: false,
                message: MAX_ATTACHED_FILES_EXCEEDED_MESSAGE
            }
        }

        return {isValid: true}
    }

    function validateTotalSizeOfAttachments(addedFiles) {
        var attachments = storedFilesList.concat(addedFiles);
        var reducer = (accumulator, currentValue) => accumulator + currentValue;

        var totalSize = attachments
                                .map(file=>file.size)
                                .reduce(reducer,0);

        if (totalSize>ATTACHMENTS_MAX_SIZE) {
            return {
                isValid: false,
                message: MAX_SIZE_EXCEEDED
            }
        }

        return {isValid: true}
    }

    function getExtension(name) {
        return name.split('.').pop()
    }

    function showValidationMessage(message) {
        //toast here instead of alert
        alert(message);
    }

    function sendFiles() {
        var formdata = new FormData();
        formdata.append('notificationId', '12345');
        storedFilesList.forEach((file, i) => formdata.append('file[' + i + ']', file));

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
                console.log('error')
            }
        });
    }

</script>

</body>
