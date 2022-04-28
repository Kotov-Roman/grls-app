<html>
<head>
    <meta name="layout" content="main"/>
    <r:require modules="jquery-ui"/>
    <r:script>
        $(function () {
            $('#form');
            $('#form').click(function () {
                alert("hola")
            })
        });
    </r:script>
</head>

<body>
<div id="form">
    Hello World
</div>
</body>
</html>