<%-- 
    Document   : error404
    Created on : Jan 28, 2016, 11:19:08 AM
    Author     : shahaz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="resources/logo/rhis_favicon.png">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>eMIS</title>
    </head>
     <style>
        *,
        *:before,
        *:after {
          box-sizing: border-box;
        }

        body {
          padding: 30px;
        }

        .warning404-wrap {
          position: absolute;
          width: 460px;
          height: 270px;
          left: 50%;
          top: 50%;
          transform: translate(-50%, -50%);
          padding-top: 170px;
          text-align: center;
        }

        .warning404-wrap:before {
          content: '404';
          position: absolute;
          width: 100%;
          text-align: center;
          font-size: 10em;
          font-weight: bold;
          top: 0;
          left: 0;
          height: 170px;
          padding-top: 0;
          color: #dd4b39;
        }

        .warning404-wrap:after {
          content: '';
          position: absolute;
          z-index: 1;
          width: 100%;
          height: 1px;
          background-image: linear-gradient(to right, #ffffff 0%, #000000 50%, #ffffff 100%);
          box-shadow: 0 -1px 1px 0 rgba(223, 223, 223, 0.72);
          left: 0;
          top: 160px;
        }

        .warning-icon {
          position: absolute;
          background-color: orange;
          text-align: left;
          left: 27px;
          top: 189px;
        }

        .warning-icon span {
          position: absolute;
          z-index: 1;
          transform: rotate(45deg) skewX(0deg) scale(1, 1);
          color: #fff;
          font-size: 51px;
          top: 2px;
          left: 12px;
          font-weight: bold;
          font-family: "Times New Roman", serif;
          text-shadow: 2px 1px 5px rgba(134, 89, 6, 0.86), 2px 1px 5px rgba(134, 89, 6, 0.86), 3px 2px 5px rgba(134, 89, 6, 0.86), 4px 2px 5px rgba(134, 89, 6, 0.86), 5px 2px 5px rgba(134, 89, 6, 0.86);
        }

        .warning-icon:before,
        .warning-icon:after {
          content: '';
          position: absolute;
          background-color: inherit;
        }

        .warning-icon,
        .warning-icon:before,
        .warning-icon:after {
          width: 50px;
          height: 50px;
          border-top-right-radius: 30%;
        }

        .warning-icon {
          transform: rotate(-60deg) skewX(-30deg) scale(1, .866);
        }

        .warning-icon:before {
          transform: rotate(-135deg) skewX(-45deg) scale(1.414, .707) translate(0, -50%);
        }

        .warning-icon:after {
          transform: rotate(135deg) skewY(-45deg) scale(.707, 1.414) translate(50%);
        }

        .warning404-text {
          padding-left: 66px;
          padding-top: 30px;
          font-size: 28px;
          font-weight: 100;
          height: 100px;
          font-weight: bold;
        }
    </style>
    <body align="center">
        <div class="warning404-wrap">
          <div class="warning404-text">
            <div class="warning-icon"> <span>!</span>
            </div>Opps! Page not found.</div>
        </div>
    </body>
</html>
