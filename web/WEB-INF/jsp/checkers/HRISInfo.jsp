<%-- 
    Document   : HRISInfo
    Created on : Dec 27, 2017, 3:13:33 PM
    Author     : Helal | m.helal.k@gmail.com
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>eMIS</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="resources/logo/rhis_favicon.png">
        <link href="resources/TemplateCSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
        <script src="resources/jquery/jquery.min.js"></script>
        <script src="resources/TemplateJs/toastr.js" type="text/javascript"></script>
        <link href="resources/TemplateCSS/toastr.css" rel="stylesheet" type="text/css"/>
        <script src="resources/js/$.app.js" type="text/javascript"></script>

        <!-- 
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        -->
        <style>
            #emis{
                color:#ECF0F5;
                font-size: 150px;
                margin-bottom: 25px;
            }
            .header{
                margin-top: 20px;
            }
            .full-width-div {
                position: absolute;
                width: 100%;
                left: 0;
            }
            .hightlight{
                background-color: #BDEDFF;
                font-weight:bold;
            }
            .form-control {
                border: 1.5px solid #8cc4f2!important;
            }
            /*            .btn-outlined {
                            border-radius: 0;
                            -webkit-transition: all .5s;
                            -moz-transition: all .5s;
                            transition: all .5s;
                        }
                        .btn-outlined.btn-primary {
                            background: none;
                            border: 1px solid #428bca;
                            color: #428bca;
                        }
                        .btn-outlined.btn-primary:hover,
                        .btn-outlined.btn-primary:active {
                            color: #FFF;
                            background: #428bca;
                            border-color: #428bca;
                        }*/

            #snackbar {
                visibility: hidden;
                min-width: 250px;
                margin-left: -125px;
                background-color: #0b5084;
                color: #fff;
                text-align: center;
                font-weight: bold;
                padding: 16px;
                position: fixed;
                z-index: 1;
                left: 50%;
                bottom: 30px;
                font-size: 17px;
            }

            #snackbar.show {
                visibility: visible;
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

            @-webkit-keyframes fadein {
                from {bottom: 0; opacity: 0;} 
                to {bottom: 30px; opacity: 1;}
            }

            @keyframes fadein {
                from {bottom: 0; opacity: 0;}
                to {bottom: 30px; opacity: 1;}
            }

            @-webkit-keyframes fadeout {
                from {bottom: 30px; opacity: 1;} 
                to {bottom: 0; opacity: 0;}
            }

            @keyframes fadeout {
                from {bottom: 30px; opacity: 1;}
                to {bottom: 0; opacity: 0;}
            }
            .form-control{
                border: 1px solid #adadad;
            }
            .scrollTop {
                position: fixed;
                right: 1%;
                bottom: 10px;
                padding: 20px;
                opacity: 0;
                transition: all 0.4s ease-in-out 0s;
            }

            .scrollTop a {
                font-size: 18px;
                color: #fff;
            }
            .container {
                width: 1300px!important;
                max-width: 100%;
            }
        </style>

        <script>
            $(document).ready(function () {

                //Populate day month year
                var date = new Date(), currentYear = date.getFullYear(), currentMonth = date.getMonth() + 1;
                for (var year = currentYear, strYear = ''; year >= 1950; year--)
                    strYear += '<option value=' + year + '>' + year + '</option>';
                $('.year').html(strYear);

                var strMonth = '';
                for (var month = 1; month <= 12; month++) {
                    var m = new Date('2018-' + month + '-01').toLocaleString('us-en', {month: "long"});
                    //console.log(m);
                    strMonth += '<option value=' + month + '>' + m + '</option>';
                }
                $('.month').html(strMonth).val(currentMonth);



                //Scroll top
                var scrollTop = $(".scrollTop");
                $(window).scroll(function () {
                    // declare variable
                    var topPos = $(this).scrollTop();

                    // if user scrolls down - show scroll to top button
                    if (topPos > 100) {
                        $(scrollTop).css("opacity", "1");

                    } else {
                        $(scrollTop).css("opacity", "0");
                    }

                }); // scroll END

                //Click event to scroll to top
                $(scrollTop).click(function () {
                    $('html, body').animate({
                        scrollTop: 0
                    }, 800);
                    return false;

                }); // click() scroll top EMD


            });

        </script>
    </head>

    <body>
        <div class="container">
            <div class="header clearfix" style="margin-bottom:-16px!important;">
                <center> <h2 class="text-muted">Information Collection Form for HRIS</h2></center>
            </div><span  ><hr></span>

            <div class="container">        
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <td>1.</td>
                            <th>Name (English)</th>
                            <td><input type="text" class="form-control" id="nameEnglish"></td>
                        </tr>
                        <tr>
                            <td>2.</td>
                            <th>Name (Bangla)</th>
                            <td><input type="text" class="form-control" id="nameBangla"></td>
                        </tr>
                        <tr>
                            <td>3.</td>
                            <th>ID No.</th>
                            <td><input type="number" class="form-control" id="idNo"></td>
                        </tr>
                        <tr>
                            <td>4.</td>
                            <th>Date of Birth</th>
                            <td><input type="text" class="form-control datepicker" id="dob"></td>
                        </tr>
                        <tr>
                            <td>5.</td>
                            <th>National ID No.</th>
                            <td><input type="number" class="form-control" id="nidNo"></td>
                        </tr>
                        <tr>
                            <td>6.</td>
                            <th>Father's Name</th>
                            <td><input type="text" class="form-control" id="fathersName"></td>
                        </tr>
                        <tr>
                            <td>7.</td>
                            <th>Mother's Name</th>
                            <td><input type="text" class="form-control" id="mothersName"></td>
                        </tr>
                        <tr>
                            <td>8.</td>
                            <th>E-mail Address (personal)</th>
                            <td><input type="text" class="form-control" id="email"></td>
                        </tr>
                        <tr>
                            <td>9.</td>
                            <th>Mobile No. 1</th>
                            <td><input type="text" class="form-control" id="mobile1"></td>
                        </tr>
                        <tr>
                            <td>10.</td>
                            <th>Mobile No. 2</th>
                            <td><input type="text" class="form-control" id="mobile2"></td>
                        </tr>
                        <tr>
                            <td>11.</td>
                            <td colspan="2">
                                <b>Present Address/Mailing Address</b>
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td colspan="2">
                                                <p>Vill/ House & Road</p>
                                                <input type="text" class="form-control" id="presentVillOrHouse">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p>Post Office</p>
                                                <input type="text" class="form-control" id="presentPostOffice">
                                            </td>
                                            <td>
                                                <p>Post Code</p>
                                                <input type="text" class="form-control" id="presentPostCode">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p>Thana/Upazila</p>
                                                <input type="text" class="form-control" id="presentUpazila">
                                            </td>
                                            <td>
                                                <p>District</p>
                                                <input type="text" class="form-control" id="PresentDistrict">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>12.</td>
                            <td colspan="2">
                                <b>Permanant Address:</b>
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td colspan="2">
                                                <p>Vill/ House & Road</p>
                                                <input type="text" class="form-control" id="permanantVillOrHouse">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p>Post Office</p>
                                                <input type="text" class="form-control" id="permanantPostOffice">
                                            </td>
                                            <td>
                                                <p>Post Code</p>
                                                <input type="text" class="form-control" id="permanantPostCode">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p>Thana/Upazila</p>
                                                <input type="text" class="form-control" id="permanantUpazila">
                                            </td>
                                            <td>
                                                <p>District</p>
                                                <input type="text" class="form-control" id="permanantDistrict">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>13.</td>
                            <th>Tribal Option</th>
                            <td>
                                <select class="form-control input-sm" name="tribalOption" id="tribalOption"> 
                                    <option value="0">- Select Tribal -</option>
                                    <option value="1">Tribal</option>
                                    <option value="2">Not Tribal</option>
                                    <option value="3">Chakma</option>
                                    <option value="4">Murma</option>
                                    <option value="5">Khasia</option>
                                    <option value="6">Other</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>14.</td>
                            <th>Sex</th>
                            <td>
                                <select class="form-control input-sm" name="sex" id="sex"> 
                                    <option value="0">- Select Sex -</option>
                                    <option value="1">Male</option>
                                    <option value="2">Female</option>
                                    <option value="3">Trans Gender</option>
                                    <option value="4">Other</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>15.</td>
                            <th>Marital Status</th>
                            <td>
                                <select class="form-control input-sm" name="maritalStatus" id="maritalStatus"> 
                                    <option value="0">- Select Marital Status -</option>
                                    <option value="1">Married</option>
                                    <option value="2">Unmarried</option>
                                    <option value="3">Separated</option>
                                    <option value="4">Widow</option>
                                    <option value="5">Widower</option>
                                    <option value="6">Divorced</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>16.</td>
                            <th>Religion</th>
                            <td>
                                <select class="form-control input-sm" name="religion" id="religion"> 
                                    <option value="0">- Select Religion -</option>
                                    <option value="1">Muslim</option>
                                    <option value="2">Hindu</option>
                                    <option value="3">Christian</option>
                                    <option value="4">Buddha</option>
                                    <option value="5">Other</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>17.</td>
                            <td colspan="2">
                                <b>Spouse Information</b>
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <p>Name</p>
                                                <input type="text" class="form-control" id="spouseName" name="spouseName">
                                            </td>
                                            <td>
                                                <p>Mobile Phone No</p>
                                                <input type="text" class="form-control" id="spousePhone" name="spousePhone">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <p>Spouse Occupation:</p>
                                                <select class="form-control input-sm" name="spouseOccupation" id="spouseOccupation"> 
                                                    <option value="0">- Select Spouse Occupation -</option>
                                                    <option value="1">Housewife</option>
                                                    <option value="2">Government Service</option>
                                                    <option value="3">Business</option>
                                                    <option value="4">Private Service</option>
                                                    <option value="5">Others</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <b>Select anyone  except housewife</b>
                                                <table class="table table-bordered">
                                                    <tbody>
                                                        <tr>
                                                            <td colspan="2">
                                                                <p>Designation</p>
                                                                <input type="text" class="form-control" id="spouseDesignation" name="spouseDesignation">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <p>Place of Posting</p>
                                                                <input type="text" class="form-control" id="spousePostingPlace" name="spousePostingPlace">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <p>Department/Organization</p>
                                                                <input type="text" class="form-control" id="spouseDepartment" name="spouseDepartment">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>


                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>18.</td>
                            <th>Number of Children</th>
                            <td><input type="text" class="form-control" name="noOfChildren" id="noOfChildren"></td>
                        </tr>
                        <tr>
                            <td rowspan="2">19.</td>
                            <th>Joining Designation</th>
                            <td><input type="text" class="form-control" name="joiningDesignation" id="joiningDesignation"></td>
                        </tr>
                        <tr>
                            <th>Joining Date</th>
                            <td><input type="text" class="form-control datepicker" name="joiningDate" id="joiningDate"></td>
                        </tr>
                        <tr>
                            <td rowspan="3">20.</td>
                            <th>Present Designation of Posting</th>
                            <td><input type="text" class="form-control" name="presentDesignationOfPosting" id="presentDesignationOfPosting"></td>
                        </tr>
                        <tr>
                            <th>Present Designation</th>
                            <td><input type="text" class="form-control" name="presentDesignation" id="presentDesignation"></td>
                        </tr>
                        <tr>
                            <th>Posted As Present Designation</th>
                            <td><input type="text" class="form-control" name="postedPresentDesignation" id="postedPresentDesignation"></td>
                        </tr>

                        <tr>
                            <td>21.</td>
                            <th>Designation Discipline</th>
                            <td><input type="text" class="form-control" id="nameEnglis"></td>
                        </tr>
                        <tr>
                            <td>22.</td>
                            <th>Designation Category</th>
                            <td><input type="text" class="form-control" id="nameEnglis"></td>
                        </tr>
                        <tr>
                            <td>23.</td>
                            <td>
                                <label>Joining Grade</label>
                                <select class="form-control input-sm" name="spouseOccupation" id="spouseOccupation"> 
                                    <option value="0">- Select -</option>
                                </select><br>

                                <label>Joining Post</label>
                                <select class="form-control input-sm" name="spouseOccupation" id="spouseOccupation"> 
                                    <option value="0">- Select -</option>
                                </select>
                            </td>
                            <td>
                    <li style="list-style-type:none"><b>Class:</b>
                        <ul style="list-style-type:none">
                            <li><b>Class I</b>
                                <ul style="list-style-type:none">
                                    <li>
                                        <b>Cadre</b>
                                    </li>
                                    <li>
                                        <label>Cadre ID</label>
                                        <input type="text" class="form-control" id="nameEnglis">
                                    </li>
                                    <li>
                                        <label>PDS ID</label>
                                        <input type="text" class="form-control" id="nameEnglis">
                                    </li>
                                    <br>
                                    <li>
                                        <b>Non-Cadre</b>
                                    </li>
                                    <li>
                                        <label>PDS ID</label>
                                        <input type="text" class="form-control" id="nameEnglis">
                                    </li>
                                    <br>
                                    <li>
                                        <b>Class II</b>
                                    </li>
                                    <li>
                                        <label>PDS ID</label>
                                        <input type="text" class="form-control" id="nameEnglis">
                                    </li>
                                    <br>
                                    <li>
                                        <b>Class III</b>
                                    </li>
                                    <li>
                                        <b>Class IV</b>
                                    </li>
                                </ul>

                            </li>
                        </ul>
                    </li>
                    </td>
                    </tr>
                    <tr>
                        <td>24.</td>
                        <th>Post Status</th>
                        <td>
                            <select class="form-control input-sm" name="spouseOccupation" id="spouseOccupation"> 
                                <option value="0">- Select -</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>25.</td>
                        <td>
                            <p>a) a) Current grade</p>
                            <input type="text" class="form-control" id="nameEnglis">
                        </td>
                        <td>
                            <p>b) Basic pay</p>
                            <input type="text" class="form-control" id="nameEnglis">
                        </td>
                    </tr>
                    <tr>
                        <td>26.</td>
                        <td>Current Basic Pay (Tk):</td>
                        <td>
                            <input type="text" class="form-control" id="nameEnglis">
                        </td>
                    </tr>
                    <tr>
                        <td>27.</td>
                        <td>Date of Joining to Govt. Service</td>
                        <td>
                            <input type="text" class="form-control datepicker" id="dob">
                        </td>
                    </tr>
                    <tr>
                        <td>28.</td>
                        <td>Date of Joining to Present Posting</td>
                        <td>
                            <input type="text" class="form-control datepicker" id="dob">
                        </td>
                    </tr>
                    <tr>
                        <td>29.</td>
                        <td>Date of Joining to Current Designation</td>
                        <td>
                            <input type="text" class="form-control datepicker" id="dob">
                        </td>
                    </tr>
                    <tr>
                        <td>30.</td>
                        <td>Has Govt. Quarter</td>
                        <td>
                            <select class="form-control input-sm" name="hasGovtInfo" id="hasGovtInfo"> 
                                <option value="0">- Select Govt. Quarter-</option>
                                <option value="1">Yes</option>
                                <option value="2">No</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>31.</td>
                        <td colspan="2">
                            <b>First appointment information</b>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td colspan="2">
                                            <p>First appointments GO. No.</p>
                                            <input type="text" class="form-control" id="nameEnglis">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <p>SL. No.</p>
                                            <input type="text" class="form-control" id="nameEnglis">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <p>Date</p>
                                            <input type="text" class="form-control datepicker" id="appointmentDate">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>32.</td>
                        <td colspan="2">
                            <b>BCS/ PSC Information (If applicable)</b>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><p>BCS Batch No.</p></td>
                                        <td><input type="text" class="form-control" id="nameEnglis"></td>
                                    </tr>
                                    <tr>
                                        <td><p>BCS/PSC Registration GO</p></td>
                                        <td><input type="text" class="form-control" id="nameEnglis"></td>
                                    </tr>
                                    <tr>
                                        <td><p>No./SL No</p></td>
                                        <td><input type="text" class="form-control" id="nameEnglis"></td>
                                    </tr>
                                    <tr>
                                        <td><p>BCS/PSC Registration Date</p></td>
                                        <td><input type="text" class="form-control datepicker" id="bcs_pscRegistrationDate"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>33.</td>
                        <td colspan="2">
                            <b>Service Confirmation Information</b>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td colspan="2">
                                            <p>Service Confirmation GO</p>
                                            <input type="text" class="form-control" id="serviceConfirmationGO">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <p>Service Confirmation SL No.</p>
                                            <input type="text" class="form-control" id="serviceConfirmationSLNo">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <p>Service Confirmation Date</p>
                                            <input type="text" class="form-control datepicker" id="serviceConfirmationDate">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>34.</td>
                        <td>Senior Scale Pass (If applicable)</td>
                        <td>
                            <select class="form-control input-sm" name="seniorScalePass" id="seniorScalePass"> 
                                <option value="0">- Select Scale Pass -</option>
                                <option value="1">Yes</option>
                                <option value="2">No</option>
                                <option value="3">Exempted</option>
                            </select>
                        </td>
                    </tr>
                    <!-- Education Information-->
                    <tr>
                        <td>35.</td>
                        <td colspan="2">
                            <b>Educational Information</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Sl. No.</th>
                                        <th>Level of Education</th>
                                        <th>Board/ University/ Institude</th>
                                        <th>Country</th>
                                        <th>Subject/ Discipline</th>
                                        <th>Division/ Class/ GPA</th>
                                        <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>a)</td>
                                        <td>S.S.C/O Level/ Dakhil/ Equivalent</td>
                                        <td><input type="text" class="form-control" id="sscBoard"></td>
                                        <td><input type="text" class="form-control" id="sscCountry"></td>
                                        <td><input type="text" class="form-control" id="sscSubject"></td>
                                        <td><input type="text" class="form-control" id="sscGPA"></td>
                                        <td><select class="form-control input-sm year" id="sscYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>b)</td>
                                        <td>H.S.C/A Level/ Alim/ Equivalent</td>
                                        <td><input type="text" class="form-control" id="hscBoard"></td>
                                        <td><input type="text" class="form-control" id="hscCountry"></td>
                                        <td><input type="text" class="form-control" id="hscSubject"></td>
                                        <td><input type="text" class="form-control" id="hscGPA"></td>
                                        <td><select class="form-control input-sm year" id="hscYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>c)</td>
                                        <td>Diploma (Nursing/ Paramedical/Other`s)</td>
                                        <td><input type="text" class="form-control" id="diplomaBoard"></td>
                                        <td><input type="text" class="form-control" id="diplomaCountry"></td>
                                        <td><input type="text" class="form-control" id="diplomaSubject"></td>
                                        <td><input type="text" class="form-control" id="diplomaGPA"></td>
                                        <td><select class="form-control input-sm year" id="diplomaYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>d)</td>
                                        <td>Graduation:<br>(B.A /B.Sc/ BSS <br>/Nursing/Fazil/Others)</td>
                                        <td><input type="text" class="form-control" id="graduationBoard"></td>
                                        <td><input type="text" class="form-control" id="graduationCountry"></td>
                                        <td><input type="text" class="form-control" id="graduationSubject"></td>
                                        <td><input type="text" class="form-control" id="graduationGPA"></td>
                                        <td><select class="form-control input-sm year" id="graduationYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>e)</td>
                                        <td>MBBS/BDS /Engineering Degree</td>
                                        <td><input type="text" class="form-control" id="mbbsBoard"></td>
                                        <td><input type="text" class="form-control" id="mbbsCountry"></td>
                                        <td><input type="text" class="form-control" id="mbbsSubject"></td>
                                        <td><input type="text" class="form-control" id="mbbsGPA"></td>
                                        <td><select class="form-control input-sm year" id="mbbsYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>f)</td>
                                        <td>Masters Degree (M.A /M.Sc./Ms/M.Com./Kamil)</td>
                                        <td><input type="text" class="form-control" id="mastersBoard"></td>
                                        <td><input type="text" class="form-control" id="mastersCountry"></td>
                                        <td><input type="text" class="form-control" id="mastersSubject"></td>
                                        <td><input type="text" class="form-control" id="mastersGPA"></td>
                                        <td><select class="form-control input-sm year" id="mastersYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>g)</td>
                                        <td>Post graduate (Diploma)</td>
                                        <td><input type="text" class="form-control" id="postGraduateDiplomaBoard"></td>
                                        <td><input type="text" class="form-control" id="postGraduateDiplomaCountry"></td>
                                        <td><input type="text" class="form-control" id="postGraduateDiplomaSubject"></td>
                                        <td><input type="text" class="form-control" id="postGraduateDiplomaGPA"></td>
                                        <td><select class="form-control input-sm year" id="postGraduateDiplomaYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>h)</td>
                                        <td>Post graduate (Degree)</td>
                                        <td><input type="text" class="form-control" id="postGraduateBoard"></td>
                                        <td><input type="text" class="form-control" id="postGraduateCountry"></td>
                                        <td><input type="text" class="form-control" id="postGraduateSubject"></td>
                                        <td><input type="text" class="form-control" id="postGraduateGPA"></td>
                                        <td><select class="form-control input-sm year" id="postGraduateYear"></select></td>
                                    </tr>
                                    <tr>
                                        <td>i)</td>
                                        <td>Doctoral/Post doctoral</td>
                                        <td><input type="text" class="form-control" id="postDoctoralBoard"></td>
                                        <td><input type="text" class="form-control" id="postDoctoralCountry"></td>
                                        <td><input type="text" class="form-control" id="postDoctoralSubject"></td>
                                        <td><input type="text" class="form-control" id="postDoctoralGPA"></td>
                                        <td><select class="form-control input-sm year" id="postDoctoralYear"></select></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!-- REGISTRATION INFORMATION -->
                    <tr>
                        <td>36.</td>
                        <td colspan="2">
                            <b>REGISTRATION INFORMATION: (BMDC/Nursing Council/IEB/Bangladesh Computer Society/Pharmacy Council/State Medical Faculty/etc.)</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Sl. No.</th>
                                        <th>Name of the Professional Body</th>
                                        <th>Registration Number</th>
                                        <th>Year</th>
                                        <th>Last Renewal Year</th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1)</td>
                                        <td><input type="text" class="form-control" id="oneNameOfProfessionalBody"></td>
                                        <td><input type="text" class="form-control" id="oneRegistrationNumber"></td>
                                        <td><select class="form-control input-sm year" id="oneYearRegistrationInformation"></select></td>
                                        <td><input type="text" class="form-control" id="oneLastRenewalYear"></td>
                                    </tr>
                                    <tr>
                                        <td>2)</td>
                                        <td><input type="text" class="form-control" id="twoNameOfProfessionalBody"></td>
                                        <td><input type="text" class="form-control" id="twoRegistrationNumber"></td>
                                        <td><select class="form-control input-sm year" id="twoYearRegistrationInformation"></select></td>
                                        <td><input type="text" class="form-control" id="twoLastRenewalYear"></td>
                                    </tr>
                                    <tr>
                                        <td>3)</td>
                                        <td><input type="text" class="form-control" id="threeNameOfProfessionalBody"></td>
                                        <td><input type="text" class="form-control" id="threeRegistrationNumber"></td>
                                        <td><select class="form-control input-sm year" id="threeYearRegistrationInformation"></select></td>
                                        <td><input type="text" class="form-control" id="threeLastRenewalYear"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!-- PROMOTIONS  -->
                    <tr>
                        <td>37.</td>
                        <td colspan="2">
                            <b>PROMOTIONS (ascending order):</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th rowspan="2">Sl. No.</th>
                                        <th colspan="3">Data</th>
                                        <th>G.O.No. (From Ministry)</th>
                                        <th>Sl .No. in the Govt.</th>
                                        <th>Promoted Post</th>
                                        <th>Pay Scale</th>
                                    </tr>
                                    <tr>
                                        <th>(Day)</th>
                                        <th>(month)</th>
                                        <th>(year)</th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1)</td>
                                        <td colspan="3"><input type="text" class="form-control datepicker" id="oneProDate"></td>
                                        <td><input type="text" class="form-control" id="oneProGoNo"></td>
                                        <td><input type="text" class="form-control" id="oneProSlGovt"></td>
                                        <td><input type="text" class="form-control" id="oneProPost"></td>
                                        <td><input type="text" class="form-control" id="oneProPayScale"></td>
                                    </tr>
                                    <tr>
                                        <td>2)</td>
                                        <td colspan="3"><input type="text" class="form-control datepicker" id="twoProDate"></td>
                                        <td><input type="text" class="form-control" id="twoProGoNo"></td>
                                        <td><input type="text" class="form-control" id="twoProSlGovt"></td>
                                        <td><input type="text" class="form-control" id="twoProPost"></td>
                                        <td><input type="text" class="form-control" id="twoProPayScale"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!-- Higher Grade  -->
                    <tr>
                        <td>38.</td>
                        <td colspan="2">
                            <b>Higher Grade (According order):</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Sl No.</th>
                                        <th>Achieved Grade</th>
                                        <th>Scale (Range)</th>
                                        <th>GO No</th>
                                        <th>Date</th>
                                        <th>Comment</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1)</td>
                                        <td><input type="text" class="form-control" id="oneHGAchievedGrade"></td>
                                        <td><input type="text" class="form-control" id="oneHGScale"></td>
                                        <td><input type="text" class="form-control" id="oneHGGoNo"></td>
                                        <td><input type="text" class="form-control datepicker" id="oneHGDate"></td>
                                        <td><input type="text" class="form-control" id="oneHGComment"></td>
                                    </tr>
                                    <tr>
                                        <td>2)</td>
                                        <td><input type="text" class="form-control" id="twoHGAchievedGrade"></td>
                                        <td><input type="text" class="form-control" id="twoHGScale"></td>
                                        <td><input type="text" class="form-control" id="twoHGGoNo"></td>
                                        <td><input type="text" class="form-control datepicker" id="twoHGDate"></td>
                                        <td><input type="text" class="form-control" id="twoHGComment"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!-- TRAINING PARTICULARS  -->
                    <tr>
                        <td>39.</td>
                        <td colspan="2">
                            <p>TRAINING PARTICULARS:</p><br>
                            <b>Local Training (applicable for two weeks and above):</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th rowspan="2">Sl No.</th>
                                        <th rowspan="2">Name of Course/Subject</th>
                                        <th rowspan="2">Name of Institute/Venue</th>
                                        <th colspan="2">Duration (Date)</th>
                                        <th rowspan="2">Remarks (if any Diploma/Degree.Others obtained)</th>
                                    </tr>
                                    <tr>
                                        <th>From</th>
                                        <th>To</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1)</td>
                                        <td><input type="text" class="form-control" id="oneLTNameOfCourse"></td>
                                        <td><input type="text" class="form-control" id="oneLTNameOfInstitute"></td>
                                        <td><input type="text" class="form-control datepicker" id="oneLTFrom"></td>
                                        <td><input type="text" class="form-control datepicker" id="oneLTTo"></td>
                                        <td><input type="text" class="form-control" id="oneLTRemarks"></td>
                                    </tr>
                                    <tr>
                                        <td>1)</td>
                                        <td><input type="text" class="form-control" id="twoLTNameOfCourse"></td>
                                        <td><input type="text" class="form-control" id="twoLTNameOfInstitute"></td>
                                        <td><input type="text" class="form-control datepicker" id="twoLTFrom"></td>
                                        <td><input type="text" class="form-control datepicker" id="twoLTTo"></td>
                                        <td><input type="text" class="form-control" id="twoLTRemarks"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <b>Foreign Training:</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th rowspan="2">Sl No.</th>
                                        <th rowspan="2">Name of Course/Subject (Study tour/Seminar, etc.)</th>
                                        <th rowspan="2">Sponsoring Agency</th>
                                        <th rowspan="2">Name of Institute</th>
                                        <th colspan="2">Duration (Date)</th>
                                        <th rowspan="2">Remarks (if any Diploma/Degree/Others obtained)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1)</td>
                                        <td><input type="text" class="form-control" id="oneFTNameOfCourse"></td>
                                        <td><input type="text" class="form-control" id="oneFTSponsoringAgency"></td>
                                        <td><input type="text" class="form-control" id="oneFTNameOfInstitute"></td>
                                        <td><input type="text" class="form-control datepicker" id="oneFTFrom"></td>
                                        <td><input type="text" class="form-control datepicker" id="oneFTTo"></td>
                                        <td><input type="text" class="form-control" id="oneFTRemarks"></td>
                                    </tr>
                                    <tr>
                                        <td>2)</td>
                                        <td><input type="text" class="form-control" id="twoFTNameOfCourse"></td>
                                        <td><input type="text" class="form-control" id="twoFTSponsoringAgency"></td>
                                        <td><input type="text" class="form-control" id="twoFTNameOfInstitute"></td>
                                        <td><input type="text" class="form-control datepicker" id="twoFTFrom"></td>
                                        <td><input type="text" class="form-control datepicker" id="twoFTTo"></td>
                                        <td><input type="text" class="form-control" id="twoFTRemarks"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!-- DISCIPLINARY ACTION/CRIMINAL PROSECUTION  -->
                    <tr>
                        <td>40.</td>
                        <td colspan="2">
                            <b>DISCIPLINARY ACTION/CRIMINAL PROSECUTION (Filled-up by the controlling officer):</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Sl No.</th>
                                        <th>Nature of Offence</th>
                                        <th>Punishment Type</th>
                                        <th>Government Order No.& Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1)</td>
                                        <td><input type="text" class="form-control" id="oneDACPName"></td>
                                        <td><input type="text" class="form-control" id="oneDACPPunishment"></td>
                                        <td><input type="text" class="form-control datepicker" id="oneDACPDate"></td>
                                    </tr>
                                    <tr>
                                        <td>2)</td>
                                        <td><input type="text" class="form-control" id="twoDACPName"></td>
                                        <td><input type="text" class="form-control" id="twoDACPPunishment"></td>
                                        <td><input type="text" class="form-control datepicker" id="twoDACPDate"></td>
                                    </tr>
                                    <tr>
                                        <td>3)</td>
                                        <td><input type="text" class="form-control" id="threeDACPName"></td>
                                        <td><input type="text" class="form-control" id="threeDACPPunishment"></td>
                                        <td><input type="text" class="form-control datepicker" id="threeDACPDate"></td>
                                    </tr>
                                    <tr>
                                        <td>4)</td>
                                        <td><input type="text" class="form-control" id="fourDACPName"></td>
                                        <td><input type="text" class="form-control" id="fourDACPPunishment"></td>
                                        <td><input type="text" class="form-control datepicker" id="fourDACPDate"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!-- DISCIPLINARY ACTION/CRIMINAL PROSECUTION  -->
                    <tr>
                        <td>41.</td>
                        <td colspan="2">
                            <b>ACR Monitoring system (Filled-up by the Competent Authority)</b>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Sl No.</th>
                                        <th>Marks Obtained (RO)</th>
                                        <th>Year</th>
                                        <th>Remarks</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1)</td>
                                        <td><input type="text" class="form-control" id="oneACRMarksObtained"></td>
                                        <td><select class="form-control input-sm year" id="oneACRYear"></select></td>
                                        <td><input type="text" class="form-control" id="oneACR"></td>
                                    </tr>
                                    <tr>
                                        <td>2)</td>
                                        <td><input type="text" class="form-control" id="twoACRMarksObtained"></td>
                                        <td><select class="form-control input-sm year" id="twoACRYear"></select></td>
                                        <td><input type="text" class="form-control" id="twoACR"></td>
                                    </tr>
                                    <tr>
                                        <td>3)</td>
                                        <td><input type="text" class="form-control" id="threeACRMarksObtained"></td>
                                        <td><select class="form-control input-sm year" id="threeACRYear"></select></td>
                                        <td><input type="text" class="form-control" id="threeACR"></td>
                                    </tr>
                                    <tr>
                                        <td>4)</td>
                                        <td><input type="text" class="form-control" id="fourACRMarksObtained"></td>
                                        <td><select class="form-control input-sm year" id="fourACRYear"></select></td>
                                        <td><input type="text" class="form-control" id="fourACR"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!--Submission-->
                    <tr>
                        <td></td>
                        <td style="text-align:center;" colspan="2"><button type="button" class="btn btn-primary btn-flat" id="submit"><i class="fa fa-send"></i> Submit Data</button></td>
                    </tr>




                    </tbody>
                </table>
            </div>
        </div>


        <div id="snackbar"></div>
        <div id="stop" class="scrollTop">
            <span><a href="" class="btn btn-success"><i class="fa fa-level-up"></i></a></span>
        </div>
    </body>
</html>
<script>
    $(function () {
        $(".datepicker").datepicker();
    });
</script>
