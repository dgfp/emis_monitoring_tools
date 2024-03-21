$(function () {
    $.export = {
        print: function (contents, title, area) {
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            frameDoc.document.write('<html><head><title>eMIS Initiative</title></head>');
            frameDoc.document.write('<body>');
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;} .area{text-align: left !important;} .dataTables_length, .dataTables_filter, .dataTables_info, .dataTables_paginate{display: none;} .numeric_field{text-align: right;} .viewLevel{text-align: left;}</style>');
            frameDoc.document.write('<link href="style.css" rel="stylesheet" type="text/css" />');
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center" class="center">' + title + '</h3>');
            frameDoc.document.write('<h5 style="text-align:center" class="center">' + area + '</h5>');
            frameDoc.document.write(contents);
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
            $($.prs.dataTable).DataTable().page.len($.prs.dataTableLength).draw();
        },
        excel: function (el) {
            var clon = el.clone();
            var html = clon.wrap('<div>').parent().html();
            //add more symbols if needed...
            while (html.indexOf('á') != - 1)
                html = html.replace(/á/g, '&aacute;');
            while (html.indexOf('é') != - 1)
                html = html.replace(/é/g, '&eacute;');
            while (html.indexOf('í') != - 1)
                html = html.replace(/í/g, '&iacute;');
            while (html.indexOf('ó') != - 1)
                html = html.replace(/ó/g, '&oacute;');
            while (html.indexOf('ú') != - 1)
                html = html.replace(/ú/g, '&uacute;');
            while (html.indexOf('º') != - 1)
                html = html.replace(/º/g, '&ordm;');
            html = html.replace(/<td>/g, "<td>&nbsp;");
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent(html));
            $($.prs.dataTable).DataTable().page.len($.prs.dataTableLength).draw();
        },
        printChart: function (title, area) {
            var dataUrl = document.getElementById('canvas').toDataURL();
            var frame1 = $('<iframe />');
            frame1[0].name = "frame1";
            frame1.css({"position": "absolute", "top": "-1000000px"});
            $("body").append(frame1);
            var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
            frameDoc.document.open();
            frameDoc.document.write('<html><head><title>eMIS Initiative</title>');
            frameDoc.document.write('</head><body>');
            frameDoc.document.write('<style>table, th, td{border:1px solid black; border-collapse: collapse;padding:10px;}th{vertical-align: text-center} td{text-align:right;}</style>');
            frameDoc.document.write('<link href="style.css" rel="stylesheet" type="text/css" />');
            frameDoc.document.write('<h3 style="margin-bottom:-12px;text-align:center" class="center">' + title + '</h3>');
            frameDoc.document.write('<h5 style="text-align:center" class="center">' + area + '</h5>');
            frameDoc.document.write('<span style="text-align:center;"><center><img src="' + dataUrl + '"></span></center>');
            //frameDoc.document.write('</div>');
            frameDoc.document.write('</body></html>');
            frameDoc.document.close();
            setTimeout(function () {
                window.frames["frame1"].focus();
                window.frames["frame1"].print();
                frame1.remove();
            }, 500);
        }
    };
});