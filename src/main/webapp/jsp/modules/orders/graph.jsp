<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <%@ include file="../../static/head.jsp"%>
    <script src="${pageContext.request.contextPath}/resources/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/macarons.js"></script>
</head>
<style>
    .graph{
        margin: 10px auto;
    }
</style>
<body>
    <!-- Pre Loader -->
    <div class="loading">
        <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
        </div>
    </div>
    <!--/Pre Loader -->
    <div class="wrapper">
        <!-- Page Content -->
        <div id="content">
                <!-- Top Navigation -->
                <%@ include file="../../static/topNav.jsp"%>
                <!-- Menu -->
                <div class="container menu-nav">
                    <nav class="navbar navbar-expand-lg lochana-bg text-white">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                         aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="ti-menu text-white"></span>
                        </button>
                
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <!-- <div class="z-navbar-nav-title">$template2.back.menu.title.text</div> -->
                            <ul class="navbar-nav mr-auto" id="navUl">
                                
                            </ul>
                        </div>
                    </nav>
                </div>
                <!-- /Menu -->
                <!-- Breadcrumb -->
                <!-- Page Title -->
                <div class="container mt-0">
                    <div class="row breadcrumb-bar">
                        <div class="col-md-6">
                            <h3 class="block-title">订单统计</h3>
                        </div>
                        <div class="col-md-6">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="${pageContext.request.contextPath}/index.jsp">
                                        <span class="ti-home"></span>
                                    </a>
                                </li>
                                <li class="breadcrumb-item"><span>订单管理</span></li>
                                <li class="breadcrumb-item active"><span>订单统计</span></li>
                            </ol>
                        </div>
                    </div>
                </div>
            
            <!-- /Breadcrumb -->
            <!-- Main Content -->
            <div class="container">             
                <!-- Main Content -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="widget-area-2 lochana-box-shadow min-h200">
                            <h3 class="widget-title"></h3>
                            <!-- 
                            Your Content goes Here
                            -->
                            <!--<div id="main" style="width: 900px;height:600px;"></div>-->
                            <div id="ordersMain" class="graph" style="width: 900px;height:600px;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Main Content -->
            <!--Copy Rights-->
            <div class="container">
                <div class="d-sm-flex justify-content-center">
                  
                </div>
            </div>
            <!-- /Copy Rights-->
        </div>
        <!-- /Page Content -->
    </div>
    <!-- Back to Top -->
    <a id="back-to-top" href="#" class="back-to-top">
            <span class="ti-angle-up"></span>
    </a>
    <!-- /Back to Top -->
    <%@ include file="../../static/foot.jsp"%>

    <script>
    <%@ include file="../../utils/menu.jsp"%>
    <%@ include file="../../static/setMenu.js"%>
    <%@ include file="../../utils/baseUrl.jsp"%>        
    var pageType = "graph";

    var ordersValArr = [];
    var ordersNameArr = [];
    var ordersMapList = [];
    var valueArr = []
    var graphType = "bar";

    var ordersVal = '';
    
    var type = "";

    $(document).ready(function() { 
        var afterUrl =  window.location.search.substring(1);
        type = afterUrl.substring(afterUrl.indexOf('=')+1).toUpperCase();
        //设置右上角用户名
        $('.dropdown-menu h5').html(window.sessionStorage.getItem('username')+'('+window.sessionStorage.getItem('role')+')')
        //设置项目名
        $('.sidebar-header h3 a').html(projectName)
        setMenu();
        getDetails();
        //draw();
        <%@ include file="../../static/myInfo.js"%>
    });

    function draw(){
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'),'macarons');

        // 指定图表的配置项和数据
        var option = {
            title: {text : '订单'},
            tooltip: {},
            legend: {},
            xAxis: {
                data : nameArr
            },
            yAxis: {
            },
            series: [{
                type: graphType,
                data: [
                ]
            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);

    }
    // 需要调group的字段，一个字段一个统计图
    function ordersDraw(){
        var yColumnCnName="";
        if(type==1) {
            yColumnCnName="日销量";
        } else if(type==2) {
            yColumnCnName="月销量";
        } else if(type==3) {
            yColumnCnName="年销量";
        } else if(type==4) {
            yColumnCnName="商品销量";
        } else if(type==5) {
            yColumnCnName="类型销量";
        } else if(type==6) {
            yColumnCnName="日销额";
        } else if(type==7) {
            yColumnCnName="月销额";
        } else if(type==8) {
            yColumnCnName="年销额";
        } else if(type==9) {
            yColumnCnName="商品销额";
        } else if(type==10) {
            yColumnCnName="类型销额";
        }
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('ordersMain'),'macarons');

        // 指定图表的配置项和数据
        var option = {
                title: {
                        text: yColumnCnName,
                },
            tooltip: {},
            legend: {},
            xAxis: {
                data : ordersNameArr
            },
            yAxis: {
            },
            series: [{
                type: graphType,
                data: ordersValArr
            }]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function getDetails(){
        byVal(type);
    }
    // 值 字段 数据绑定
    function dataBindByValue(list){
            for(var i=0;i<list.length;i++){
                if(type==1) {
                    ordersNameArr.push(list[i].addtime);
                    ordersValArr.push(list[i].total);
                } else if(type==2) {
                    ordersNameArr.push(list[i].addtime);
                    ordersValArr.push(list[i].total);
                } else if(type==3) {
                    ordersNameArr.push(list[i].addtime);
                    ordersValArr.push(list[i].total);
                } else if(type==4) {
                    ordersNameArr.push(list[i].goodname);
                    ordersValArr.push(list[i].total);
                } else if(type==5) {
                    ordersNameArr.push(list[i].goodtype);
                    ordersValArr.push(list[i].total);
                } else if(type==6) {
                    ordersNameArr.push(list[i].addtime);
                    ordersValArr.push(list[i].total.toFixed(2));
                } else if(type==7) {
                    ordersNameArr.push(list[i].addtime);
                    ordersValArr.push(list[i].total.toFixed(2));
                } else if(type==8) {
                    ordersNameArr.push(list[i].addtime);
                    ordersValArr.push(list[i].total.toFixed(2));
                } else if(type==9) {
                    ordersNameArr.push(list[i].goodname);
                    ordersValArr.push(list[i].total.toFixed(2));
                } else if(type==10) {
                    ordersNameArr.push(list[i].goodtype);
                    ordersValArr.push(list[i].total.toFixed(2));
                }
            }
            ordersDraw();
    }

    //按值统计
    function byVal(type){
        var url = "";
        if(type==1) {
            url = baseUrl+"orders/value/addtime/buynumber/日";
        } else if(type==2) {
            url = baseUrl+"orders/value/addtime/buynumber/月";
        } else if(type==3) {
            url = baseUrl+"orders/value/addtime/buynumber/年";
        } else if(type==4) {
            url = baseUrl+"orders/value/goodname/buynumber";
        } else if(type==5) {
            url = baseUrl+"orders/value/goodtype/buynumber";
        } else if(type==6) {
            url = baseUrl+"orders/value/addtime/total/日";
        } else if(type==7) {
            url = baseUrl+"orders/value/addtime/total/月";
        } else if(type==8) {
            url = baseUrl+"orders/value/addtime/total/年";
        } else if(type==9) {
            url = baseUrl+"orders/value/goodname/total";
        } else if(type==10) {
            url = baseUrl+"orders/value/goodtype/total";
        }
        $.ajax({ 
            type: "GET",
            url: url,
            data:{ },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("token", window.sessionStorage.getItem('token'));
            },
            success: function(res){                 
                if(res.code == 0){
                    console.log(res.data)
                    if(res.data != null){
                        dataBindByValue(res.data);
                    }
                }else if(res.code == 401){
                    <%@ include file="../../static/toLogin.jsp"%>           
                }else{
                    alert(res.msg);
                }
            },
        });
    }
    // 用户登出
    <%@ include file="../../static/logout.jsp"%>
    </script>
</body>

</html>
