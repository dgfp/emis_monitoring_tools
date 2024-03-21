
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/area_dropdown_controls.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>

<script>

    $(function () {
        // We can attach the `fileselect` event to all file inputs on the page
        $(document).on('change', ':file', function () {
            var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            input.trigger('fileselect', [numFiles, label]);
        });

        // We can watch for our custom `fileselect` event like this
        $(document).ready(function () {
            $(':file').on('fileselect', function (event, numFiles, label) {
                var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;
                if (input.length) {
                    input.val(log);
                } else {
                    if (log)
                        alert(log);
                }
            });

            $("#viewLog").click(function () {
               alert("Clicked");
                $.ajax({
                    url: "upload?action=viewLog",
                    data: {},
                    type: "POST",
                    success: function (result) {
                        //alert("Clicked");
                        var json = JSON.parse(result);
                        if (json.length === 0) {
                            btn.button('reset');
                            alert("No data found");
                        }

                        var tableBody = $('#tableBody');
                        tableBody.empty(); //first empty table before showing data
                        $('#tableFooter').empty();

                        for (var i = 0; i < json.length; i++) {
                            var parsedData = "<tr><td>" + (i + 1) + "</td>"
                                    + "<td style='text-align:center'>" + json[i].version + "</td>"
                                    + "<td style='text-align:center'>" + json[i].date_time + "</td></tr>";
                            tableBody.append(parsedData);
                        }

                        btn.button('reset');
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        btn.button('reset');
                        alert("Request can't be processed");
                    }
                });
            });
        });


        var bar = $('.bar');
        var percent = $('.percent');
        var status = $('#status');

        $('form').ajaxForm({
            beforeSend: function () {
                status.empty();
                var percentVal = '0%';
                bar.width(percentVal);
                percent.html(percentVal);
            },
            uploadProgress: function (event, position, total, percentComplete) {
                var percentVal = percentComplete + '%';
                bar.width(percentVal);
                percent.html(percentVal);
                //console.log(percentVal, position, total);
            },
            success: function () {
                var percentVal = '100%';
                bar.width(percentVal);
                percent.html(percentVal);
            },
            complete: function (xhr) {
                status.html(xhr.responseText);
            }
        });




    });
</script>

<script>
    (function () {



    })();
</script>

<div id="page-wrapper">

    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <h3>Upload module(.apk file) to server </h3>
            </div>
        </div>

        <br>

        <form method="POST" action="upload?action=uploadFile" class="form-horizontal"  role="form" >

            <div class="form-group">
                <label class="control-label col-sm-2" for="district">District:</label>
                <div class="col-sm-5">
                    <select class="form-control" name="district" id="district"> </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="upazila">Upazila:</label>
                <div class="col-sm-5">
                    <select class="form-control" name="upazila" id="upazila">
                        <option value="">All</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="union">Union:</label>
                <div class="col-sm-5">
                    <select class="form-control" name="union" id="union">
                        <option value="">All</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="folder">System:</label>
                <div class="col-sm-5">
                    <select class="form-control" name="folder" id="folder">
                        <option value="/test/UpdateFWA">FWA</option> <!--/test/  F:\RHIS Modules\fwa -->
                        <option value="/test/UpdateHA">HA</option> <!--/test/  F:\RHIS Modules\ha -->
                        <option value="/test/UpdateAHI">AHI</option> <!--/test/  F:\RHIS Modules\ahi -->
                        <option value="/test/UpdateHI">HI</option> <!--/test/  F:\RHIS Modules\ahi -->
                        <option value="/test/UpdateFPI">FPI</option> <!--/test/  F:\RHIS Modules\ahi -->
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="file">APK: </label>


                <div class="col-sm-5">
                    <div class="input-group">
                        <label class="input-group-btn btn-file">
                            <span class="btn btn-success">
                                Browse&hellip; <input  type="file" name="file" accept=".txt" style="display: none;">
                            </span>
                        </label>
                        <input type="text" class="form-control" readonly>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="version">Version:</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="version" name="version" placeholder="Enter version of APK">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-5">
                    <button class="btn btn-success" type="submit" class="btn btn-default" enctype="multipart/form-data">Upload</button>
                    <button class="btn btn-success" type="button" class="btn btn-default" id="viewLog" >View Log</button>
                </div>

            </div>



            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-5">
                    <div class="progress">
                        <div class="bar"></div >
                        <div class="percent">0%</div>
                    </div>
                </div>
            </div>

            <div id="status"></div>

        </form>
    </div> 

    <div class="col-ld-12">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Version</th>
                        <th>Uploaded Date</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- /.container-fluid -->

</div>


<%@include file="/WEB-INF/jspf/footer.jspf" %>