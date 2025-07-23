<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Director | Dashboard</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicon -->
        <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="css/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <!-- fullCalendar -->
        <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
        <!-- Daterange picker -->
        <link href="css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- iCheck for checkboxes and radio inputs -->
        <link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <!-- <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" /> -->
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="css/style.css" rel="stylesheet" type="text/css" />



        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
          <![endif]-->

        <style type="text/css">

        </style>
    </head>
    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
        <jsp:include page="slider.jsp" />


        <aside class="right-side">

            <!-- Main content -->
            <section class="content">

                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-3">
                        <div class="sm-st clearfix">
                            <span class="sm-st-icon st-red"><i class="fa fa-check-square-o"></i></span>
                            <div class="sm-st-info">
                                <span>${totalRegistrations}</span>
                                Tổng số yêu cầu 
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="sm-st clearfix">
                            <span class="sm-st-icon st-violet"><i class="fa fa-home"></i></span>
                            <div class="sm-st-info">
                                <span>${totalRooms}</span>
                                Tổng số phòng
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="sm-st clearfix">
                            <span class="sm-st-icon st-blue"><i class="fa fa-dollar"></i></span>
                            <div class="sm-st-info">
                                <span> <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" /> VNĐ</span>
                                Tổng số doanh thu
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="sm-st clearfix">
                            <span class="sm-st-icon st-green"><i class="fa fa-users"></i></span>
                            <div class="sm-st-info">
                                <span>${totalOccupants}</span>
                                Tổng số người ở 
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main row -->
                <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

                <div class="row">
                    <div class="col-md-8">
                        <section class="panel">
                            <header class="panel-heading">Biểu đồ doanh thu theo tháng</header>
                            <div class="panel-body">
                                <canvas id="barchart" width="600" height="330"></canvas>
                            </div>
                        </section>
                    </div>

                    <div class="col-lg-4">
                        <section class="panel">
                            <header class="panel-heading">Tỷ lệ hoàn thành và hủy yêu cầu phòng</header>
                            <div class="panel-body">
                                <canvas id="piechart" width="300" height="300"></canvas>
                            </div>
                        </section>
                    </div>
                </div>

                <script>
                    // ===== Bar Chart (Doanh thu) =====
                    const barLabels = [
                    <c:forEach var="r" items="${revenueList}" varStatus="loop">
                    '<c:out value="${r.month}"/>'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];
                    const barData = [
                    <c:forEach var="r" items="${revenueList}" varStatus="loop">
                        <c:out value="${r.revenue}"/><c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];

                    new Chart(document.getElementById('barchart'), {
                        type: 'bar',
                        data: {
                            labels: barLabels,
                            datasets: [{
                                    label: 'Doanh thu (VNĐ)',
                                    data: barData,
                                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 1
                                }]
                        },
                        options: {
                            responsive: true,
                            scales: {
                                x: {title: {display: true, text: 'Tháng'}},
                                y: {beginAtZero: true, title: {display: true, text: 'Doanh thu (VNĐ)'}}
                            }
                        }
                    });

                    // ===== Pie Chart (Tỷ lệ hoàn thành vs hủy) =====
                    const completed = parseInt('${completedCount}') || 0;
                    const rejected = parseInt('${rejectedCount}') || 0;

                    const pieData = [completed, rejected];
                    const pieLabels = ['Hoàn thành', 'Hủy'];

                    new Chart(document.getElementById('piechart'), {
                        type: 'pie',
                        data: {
                            labels: pieLabels,
                            datasets: [{
                                    data: pieData,
                                    backgroundColor: ['#4CAF50', '#F44336'],
                                    borderColor: ['#388E3C', '#D32F2F'],
                                    borderWidth: 1
                                }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {position: 'bottom'},
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            const value = context.raw;
                                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                            const percent = Math.round((value / total) * 100);
                                            return context.label + ': ' + value + ' (' + percent + '%)';
                                        }
                                    }
                                }
                            }
                        }
                    });
                </script>

                <div class="col-md-12">
                    <section class="panel">
                        <header class="panel-heading">Sức chứa và số người ở từng phòng</header>
                        <div class="panel-body">
                            <canvas id="roomchart" width="900" height="400"></canvas>
                        </div>
                    </section>
                </div>
                <script>
                    // ===== Bar Chart for Rooms (Sức chứa vs Người ở) =====
                    const roomLabels = [
                    <c:forEach var="room" items="${roomList}" varStatus="loop">
                    '<c:out value="${room.roomNumber}"/>'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];

                    const capacityData = [
                    <c:forEach var="room" items="${roomList}" varStatus="loop">
                        <c:out value="${room.capacity}"/><c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];

                    const occupancyData = [
                    <c:forEach var="room" items="${roomList}" varStatus="loop">
                        <c:out value="${room.currentOccupancy}"/><c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];

                    new Chart(document.getElementById('roomchart'), {
                        type: 'bar',
                        data: {
                            labels: roomLabels,
                            datasets: [
                                {
                                    label: 'Sức chứa',
                                    data: capacityData,
                                    backgroundColor: 'rgba(255, 99, 132, 0.6)',
                                    borderColor: 'rgba(255, 99, 132, 1)',
                                    borderWidth: 1
                                },
                                {
                                    label: 'Số người ở',
                                    data: occupancyData,
                                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 1
                                }
                            ]
                        },
                        options: {
                            responsive: true,
                            scales: {
                                x: {title: {display: true, text: 'Phòng'}},
                                y: {beginAtZero: true, title: {display: true, text: 'Số lượng người'}}
                            },
                            plugins: {
                                legend: {
                                    position: 'top'
                                },
                                tooltip: {
                                    mode: 'index',
                                    intersect: false
                                }
                            }
                        }
                    });
                </script>

                <!-- row end -->
            </section><!-- /.content -->
            <div class="footer-main">
                Hệ thống quản lí kí túc xá, 2025
            </div>
        </aside><!-- /.right-side -->

    </div><!-- ./wrapper -->


    <!-- jQuery 2.0.2 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="js/jquery.min.js" type="text/javascript"></script>

    <!-- jQuery UI 1.10.3 -->
    <script src="js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
    <!-- Bootstrap -->
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <!-- daterangepicker -->
    <script src="js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>

    <script src="js/plugins/chart.js" type="text/javascript"></script>

    <!-- datepicker
    <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
    <!-- Bootstrap WYSIHTML5
    <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
    <!-- iCheck -->
    <script src="js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <!-- calendar -->
    <script src="js/plugins/fullcalendar/fullcalendar.js" type="text/javascript"></script>

    <!-- Director App -->
    <script src="js/Director/app.js" type="text/javascript"></script>

    <!-- Director dashboard demo (This is only for demo purposes) -->
    <script src="js/Director/dashboard.js" type="text/javascript"></script>

    <!-- Director for demo purposes -->
    <script type="text/javascript">
                    $('input').on('ifChecked', function (event) {
                        // var element = $(this).parent().find('input:checkbox:first');
                        // element.parent().parent().parent().addClass('highlight');
                        $(this).parents('li').addClass("task-done");
                        console.log('ok');
                    });
                    $('input').on('ifUnchecked', function (event) {
                        // var element = $(this).parent().find('input:checkbox:first');
                        // element.parent().parent().parent().removeClass('highlight');
                        $(this).parents('li').removeClass("task-done");
                        console.log('not');
                    });

    </script>
    <script>
        $('#noti-box').slimScroll({
            height: '400px',
            size: '5px',
            BorderRadius: '5px'
        });

        $('input[type="checkbox"].flat-grey, input[type="radio"].flat-grey').iCheck({
            checkboxClass: 'icheckbox_flat-grey',
            radioClass: 'iradio_flat-grey'
        });
    </script>
    <script type="text/javascript">
        $(function () {
            "use strict";
            //BAR CHART
            var data = {
                labels: ["January", "February", "March", "April", "May", "June", "July"],
                datasets: [
                    {
                        label: "My First dataset",
                        fillColor: "rgba(220,220,220,0.2)",
                        strokeColor: "rgba(220,220,220,1)",
                        pointColor: "rgba(220,220,220,1)",
                        pointStrokeColor: "#fff",
                        pointHighlightFill: "#fff",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                        data: [65, 59, 80, 81, 56, 55, 40]
                    },
                    {
                        label: "My Second dataset",
                        fillColor: "rgba(151,187,205,0.2)",
                        strokeColor: "rgba(151,187,205,1)",
                        pointColor: "rgba(151,187,205,1)",
                        pointStrokeColor: "#fff",
                        pointHighlightFill: "#fff",
                        pointHighlightStroke: "rgba(151,187,205,1)",
                        data: [28, 48, 40, 19, 86, 27, 90]
                    }
                ]
            };
            new Chart(document.getElementById("linechart").getContext("2d")).Line(data, {
                responsive: true,
                maintainAspectRatio: false,
            });

        });
        // Chart.defaults.global.responsive = true;
    </script>
</body>
</html>
