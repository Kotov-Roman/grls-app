<html>
<head>
    %{--<meta name="layout" content="main"/>--}%
    <r:require modules="jquery, jquery-ui,core"/>
    <r:layoutResources/>
    %{--<script src="D:\IdeaProjects\grls-app\web-app\datatables\media\js\jquery.dataTables.min.js"></script>--}%

    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css"/>
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>

    %{--<script>--}%
        %{--$( function() {--}%
            %{--$( "#accordion" ).accordion();--}%
        %{--} );--}%
    %{--</script>--}%
</head>
<body>

<script>
    $(document).ready(function() {
        $('#table').dataTable();
    } );
</script>

<table id="table" class="display">
    <thead>
    <tr>
        <th>Column 1</th>
        <th>Column 2</th>
        <th>etc</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>Row 1 Data 1</td>
        <td>Row 1 Data 2</td>
        <td>etc</td>
    </tr>
    <tr>
        <td>Row 2 Data 1</td>
        <td>Row 2 Data 2</td>
        <td>etc</td>
    </tr>
    </tbody>
</table>
<r:layoutResources/>

</body>
</html>