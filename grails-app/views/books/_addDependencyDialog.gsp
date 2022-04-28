<script>
    $(document).ready(function () {
        var addDependencyDialog = $('#addDependencyDialog').dialog({
            title: 'Add dependency',
            minHeight: 500,
            width: 500,
            autoOpen: false,
            buttons: [
                {
                    text: "add dependency",
                    id: "addDependencyButton",
                    class: "leftButton",
                    click: function () {
                        var relationType = $('#relationTypeSelector').val();
                        var comment = $('#commentForm').val();

                        var idsArray = $('#idsForm')
                            .val()
                            .split("\n")
                            .map(item => item.trim();)
                            .filter(function (el) {
                                return el != null && el !== "";
                            });

                        debugger;

                        // idsArray = idsArray.split("\n");
                        trimIds(idsArray);
                        idsArray = filterArray(idsArray);

                        var data = {
                            "relationType": relationType,
                            "ids": idsArray,
                            "comment": comment
                        };

                        var json = JSON.stringify(data);

                        $.ajax({
                            type: "POST",
                            url: '<g:createLink action="generateDataForFirstTable"></g:createLink>',
                            data: json,
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                alert('generated');
                            },
                            error: function (response, textStatus, errorThrown) {
                                alert('something went wrong on server side')
                            }

                        });

                        $('#firstTable').DataTable().ajax.reload();

                    }
                },
                {
                    text: "close",
                    click: function () {
                        addDependencyDialog.dialog('close');
                    }
                }
            ]
        });
        $('#addDependencyDialog').dialog('open');

        disableAddDependencyButton();
        manageAddButtonState();
    });

    // block button if text areas are not valid
    function manageAddButtonState() {
        $('#commentForm').keyup(function () {
            if (!isCommentValid()) {
                disableAddDependencyButton();
            } else {
                if (!isIdsEmpty()) {
                    unlockAddDependencyButton();
                }
            }
        });

        $('#idsForm').keyup(function () {
            if (isIdsEmpty()) {
                disableAddDependencyButton()
            } else {
                if (isCommentValid()) {
                    unlockAddDependencyButton();
                }
            }
        });
    }

    function isIdsEmpty() {
        var idsFormText = $('#idsForm').val().trim();
        return (!idsFormText || 0 === idsFormText.length)
    }

    function isCommentValid() {
        var commentText = $('#commentForm').val();
        if (commentText.length < 600 && commentText.match(/^[\w,\. ]*$/)) {
            $("#lengthWarning").css("visibility", "hidden");
            return true;
        } else {
            $("#lengthWarning").css("visibility", "visible");
            return false;
        }
    }

    function disableAddDependencyButton() {
        $('#addDependencyButton').attr('disabled', true);
        $("#addDependencyButton").css("color", "red");
    }

    function unlockAddDependencyButton() {
        $('#addDependencyButton').attr('disabled', false);
        $("#addDependencyButton").removeAttr("style");
    }

    function trimIds(idsArray) {
        for (var i = 0; i < idsArray.length; i++) {
            idsArray[i] = idsArray[i].trim();
        }
    }

    function filterArray(array) {
        var filtered = array.filter(function (el) {
            return el != null && el != "";
        });
        return filtered;
    }

</script>

<div>Relationships to this resource:</div>

<div>
    <g:select id="relationTypeSelector"
              from="${['Child', 'Parent']}"
              keys="${['CHILD', 'PARENT']}"
              name="relationTypeSelector"></g:select>
    <span dir="images" id="relationTypeInfo" class="it_icon icon_info" title="info about relation type">info</span>
</div>

<div>
    <div>Enter a list of Resource IDs (one per line):</div>

    <div id="idListDiv">
        <g:textArea id="idsForm" name="idsForm" style="width: 300px"></g:textArea>
    </div>
</div>

<div>
    <div>Comment:</div>

    <div id="commentDiv">
        <g:textArea id="commentForm" name="commentForm" style="width: 300px"></g:textArea>
    </div>

    <div id="lengthWarning"
         style="visibility: hidden">Your comment shouldn't contain more than 600 symbols and invalid symbols</div>
</div>
