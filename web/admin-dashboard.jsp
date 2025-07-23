<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Director | Dashboard</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

        <!-- Stylesheets -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />

        <!-- Chart.js CDN -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body class="skin-black">
        <jsp:include page="admin-slider.jsp" />

        <aside class="right-side">
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
                                <span><fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" /> VNĐ</span>
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

                <div class="row">
                    <!-- Biểu đồ cột theo Vai trò -->
                    <div class="col-lg-8">
                        <section class="panel">
                            <header class="panel-heading">Số lượng người dùng theo vai trò</header>
                            <div class="panel-body">
                                <canvas id="userRoleChart" width="600" height="330"></canvas>
                            </div>
                        </section>
                    </div>

                    <!-- Biểu đồ tròn theo Status -->
                    <div class="col-lg-4">
                        <section class="panel">
                            <header class="panel-heading">Trạng thái người dùng</header>
                            <div class="panel-body">
                                <canvas id="userStatusChart" width="300" height="300"></canvas>
                            </div>
                        </section>
                    </div>
                </div>

                <!-- Chart Script -->
                <script>
                    // ===== BIỂU ĐỒ THEO VAI TRÒ (BAR CHART) =====
                    const roleLabels = [
                    <c:forEach var="entry" items="${roleCountMap}" varStatus="loop">
                    '<c:out value="${entry.key}"/>'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];
                    const roleData = [
                    <c:forEach var="entry" items="${roleCountMap}" varStatus="loop">
                        ${entry.value}<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];
                    const roleColors = ['#4CAF50', '#FFC107', '#F44336', '#2196F3', '#9C27B0', '#00BCD4'];

                    new Chart(document.getElementById('userRoleChart'), {
                        type: 'bar',
                        data: {
                            labels: roleLabels,
                            datasets: roleLabels.map((label, index) => ({
                                    label: label,
                                    data: roleLabels.map((_, i) => i === index ? roleData[index] : 0),
                                    backgroundColor: roleColors[index % roleColors.length],
                                    borderColor: '#ffffff',
                                    borderWidth: 1
                                }))
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            const value = context.raw;
                                            const total = context.chart.data.datasets.reduce((sum, ds) => sum + ds.data[context.dataIndex], 0);
                                            const percent = Math.round((value / total) * 100);
                                            return context.dataset.label + ': ' + value + ' người ';
                                        }
                                    }
                                },
                                legend: {
                                    display: true,
                                    position: 'bottom'
                                },
                                title: {
                                    display: true,
                                    text: 'Số lượng người dùng theo vai trò'
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    title: {
                                        display: true,
                                        text: 'Số người dùng'
                                    },
                                    ticks: {
                                        precision: 0
                                    }
                                },
                                x: {
                                    stacked: true,
                                    title: {
                                        display: true,
                                        text: 'Vai trò'
                                    }
                                }
                            }
                        }
                    });

                    // ===== BIỂU ĐỒ TRẠNG THÁI (PIE CHART) =====
                    const statusLabels = [
                    <c:forEach var="entry" items="${statusCounts}" varStatus="loop">
                    '<c:out value="${entry.key}"/>'<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];
                    const statusData = [
                    <c:forEach var="entry" items="${statusCounts}" varStatus="loop">
                        ${entry.value}<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                    ];
                    const statusColors = ['#4CAF50', '#FFC107', '#F44336', '#2196F3', '#9C27B0', '#00BCD4'];

                    new Chart(document.getElementById('userStatusChart'), {
                        type: 'pie',
                        data: {
                            labels: statusLabels,
                            datasets: [{
                                    data: statusData,
                                    backgroundColor: statusColors.slice(0, statusData.length),
                                    borderWidth: 1
                                }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: 'bottom'
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            const value = context.raw;
                                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                            const percent = Math.round((value / total) * 100);
                                            return context.label + ': ' + value + ' người (' + percent + '%)';
                                        }
                                    }
                                },
                                title: {
                                    display: true,
                                    text: 'Tình trạng người dùng'
                                }
                            }
                        }
                    });
                </script>

            </section>
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

            <div class="footer-main">
                Hệ thống quản lí kí túc xá, 2025
            </div>
        </aside>
    </body>
</html>