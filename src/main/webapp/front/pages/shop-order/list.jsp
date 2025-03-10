<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!-- 订单 -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<title>订单</title>
		<link rel="stylesheet" href="../../layui/css/layui.css">
		<!-- 样式 -->
		<link rel="stylesheet" href="../../css/style.css" />
		<!-- 主题（主要颜色设置） -->
		<link rel="stylesheet" href="../../css/theme.css" />
		<!-- 通用的css -->
		<link rel="stylesheet" href="../../css/common.css" />
	</head>
	<style>
		#swiper {
			overflow: hidden;
		}
		#swiper .layui-carousel-ind li {
			width: 16px;
			height: 8px;
			border-width: 0;
			border-style: solid;
			border-color: rgba(0, 0, 0, 0.5);
			border-radius: 4px;
			background-color: #f7f7f7;
			box-shadow: 0 0 0px 4px rgba(0, 0, 0, 0.5);
		}
		#swiper .layui-carousel-ind li.layui-this {
			width: 34px;
			height: 8px;
			border-width: 0;
			border-style: solid;
			border-color: rgba(0,0,0,.3);
			border-radius: 4px;
			background-color: rgba(252, 241, 211, 1);
			box-shadow: 0 0 0px 4px rgba(0, 0, 0, 0.5);
		}
		
		.index-title {
		    text-align: center;
		    box-sizing: border-box;
		    width: 980px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    flex-direction: column;
		}
		
		.layui-laypage .layui-laypage-count {
		  padding: 0 10px;
		}
		.layui-laypage .layui-laypage-skip {
		  padding-left: 10px;
		}
	</style>
	<body style="background: #EEEEEE;">

		<div id="app">

			<!-- 轮播图 -->
			<div class="layui-carousel" id="swiper" :style='{"boxShadow":"0 0 0px rgba(110,22,64,.8)","margin":"0 auto","borderColor":"rgba(0,0,0,.3)","borderRadius":"0","borderWidth":"0","width":"100%","borderStyle":"solid"}'>
			  <div carousel-item id="swiper-item">
				<div v-for="(item,index) in swiperList" :key="index">
					<img style="width: 100%;height: 100%;object-fit:cover;" :src="item.img" />
				</div>
			  </div>
			</div>
			<!-- 轮播图 -->

			<!-- 标题 -->
			<div class="index-title" :style='{"padding":"4px","boxShadow":"0 0 0px rgba(110,22,64,.8)","margin":"10px auto","borderColor":"rgba(0,0,0,.3)","backgroundColor":"rgba(209, 202, 184, 1)","color":"rgba(255, 255, 255, 1)","borderRadius":"4px","borderWidth":"0","fontSize":"20px","borderStyle":"solid","height":"auto"}'>
			  <span>USER / ORDER</span><span>我的订单</span>
			</div>
			<!-- 标题 -->

			<div class="center-container" style="width: 1024px;">
				<!-- 个人中心菜单 config.js-->
				<!-- <div class="left-container">
					<ul class="layui-nav layui-nav-tree">
						<li v-for="(item,index) in centerMenu" v-bind:key="index" class="layui-nav-item" :class="item.url=='../shop-order/list.jsp'?'layui-this':''">
							<a :href="'javascript:jump(\''+item.url+'\')'">{{item.name}}</a>
						</li>
					</ul>
				</div> -->
				<!-- 个人中心菜单 -->
				<div class="right-container" style="padding-top: 0;">
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
						<ul class="layui-tab-title">
							<li @click="pageList('未支付')" class="layui-this">未支付</li>
							<li @click="pageList('已支付')">已支付</li>
							<li @click="pageList('已发货')">已发货</li>
							<li @click="pageList('已完成')">已完成</li>
							<li @click="pageList('已退款')">已退款</li>
							<li @click="pageList('已取消')">已取消</li>
						</ul>
						<div class="layui-tab-content">
							<table class="layui-table" lay-skin="nob">
								<thead>
									<tr>
										<th>订单编号</th>
										<th>商品</th>
										<th>价格</th>
										<th>数量</th>
										<th>总价</th>
										<th style="min-width:100px">地址</th>
										<th>电话</th>
                                        <th>收货人</th>
                                        <th>下单时间</th>
										<th style="min-width:150px">操作</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="(item,index) in dataList" v-bind:key="index">
										<td style="width: 50px;">
											{{item.orderid}}
										</td>
										<td style="display: flex;text-align: left;width: 250px;">
											<img :src="baseurl+item.picture" style="width: 100px;height: 100px;object-fit: cover;">
											<div style="margin-left: 10px;margin-top: 10px;">
												{{item.goodname}}
											</div>
										</td>
                                        <td style="width: 20px;" v-if="item.type==1"><span :style='{"fontSize":"12px"}'>￥</span>{{item.price.toFixed(2)}}</td>
                                        <td style="width: 20px;" v-if="item.type==2">{{item.price}} 积分</td>
										<td style="width: 50px;">
											{{item.buynumber}}
										</td>
                                        <td style="width: 0px;" v-if="item.type==1"><span :style='{"fontSize":"12px"}'>￥</span>{{(item.price*item.buynumber).toFixed(2)}}</td>
                                        <td style="width: 0px;" v-if="item.type==2">{{(item.price*item.buynumber).toFixed(2)}} 积分</td>
										<td style="width: 200px;">
											{{item.address}}
										</td>
                                        <td style="width: 30px;">
                                                {{item.tel}}
                                        </td>
                                        <td style="width: 80px;">
                                                {{item.consignee}}
                                        </td>
                                        <td style="width: 120px;">
                                                {{item.addtime}}
                                        </td>
										<td style="width: 100px;">
                                            <button v-if="item.status=='未支付'" @click="pay(item)" type="button" class="layui-btn layui-btn-sm layui-btn-radius btn-theme">
                                                    <i class="layui-icon">&#xe65e;</i> 支付
                                            </button>
                                            <button v-if="item.status=='未支付'" @click="cancel(item)" type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-btn-warm">
                                                    取消
                                            </button>
                                            <button v-if="item.status=='已支付'" @click="refund(item)" type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-btn-warm">
                                                    <i class="layui-icon">&#xe65e;</i> 退款
                                            </button>
                                            <button v-if="item.status=='已发货'" @click="confirm(item)" type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-bg-green">
                                                    <i class="layui-icon">&#xe65e;</i> 确认收货
                                            </button>
                                            <button v-if="item.logistics" @click="logistics(item)" type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-btn-warm">
                                            <i class="layui-icon layui-icon-user"></i> 物流
                                            <button v-if="item.status=='已完成'" @click="returnGood(item)" type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-bg-green">
                                                    <i class="layui-icon">&#xe65e;</i> 退货
                                            </button>
                                            <button v-if="item.status=='已完成'" @click="jump('../'+item.tablename+'/detail.jsp?id='+item.goodid)" type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-bg-green">
                                                    <i class="layui-icon">&#xe611;</i> 评价
                                            </button>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="pager" id="pager" :style="{textAlign:2==1?'left':2==2?'center':'right'}"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- layui -->
		<script src="../../layui/layui.js"></script>
		<!-- vue -->
		<script src="../../js/vue.js"></script>
		<!-- 组件配置信息 -->
		<script src="../../js/config.js"></script>
		<!-- 扩展插件配置信息 -->
		<script src="../../modules/config.js"></script>
		<!-- 工具方法 -->
		<script src="../../js/utils.js"></script>
		<!-- 校验格式工具类 -->
		<script src="../../js/validate.js"></script>

		<script>
			var vue = new Vue({
				el: '#app',
				data: {
					// 轮播图
					swiperList: [{
						img: '../../img/banner.jpg'
					}],
					baseurl:'',
					dataList: [],
					centerMenu: centerMenu,
					status: '未支付',
					limit: 10,
					user: {}
				},
				methods: {
					jump(url) {
						jump(url)
					},
					pageList(status) {
						this.status = status;
						console.log(layui)
						// 获取列表数据
						layui.http.request('orders/list', 'get', {
							page: 1,
							limit: this.limit,
							userid: localStorage.getItem('userid'),
							status: vue.status
						}, function(res) {
							vue.dataList = res.data.list
							// 分页
							layui.laypage.render({
								elem: 'pager',
								count: res.data.total,
								limit: this.limit,
								jump: function(obj, first) {
									//首次不执行
									if (!first) {
										layui.http.request('orders/list', 'get', {
											page: obj.curr,
											limit: obj.limit,
											userid: localStorage.getItem('userid'),
											status: this.status
										}, function(res) {
											this.dataList = res.data.list
										})
									}
								}
							});
						})
					},
					// 支付
					pay(item) {
						// 获取商品详情信息
						layui.http.request(`${item.tablename}/info/${item.goodid}`, 'get', {}, (res) => {
							// 商品信息
							let data = res.data;
							// 用户当前用户信息
							let table = localStorage.getItem("userTable");
							layui.http.request(`${table}/session`, 'get', {}, function(data) {
								this.user = data.data;
								// 判断余额是否充足
								if (Number(this.user.money) < Number(item.total)) {
									layui.layer.msg('余额不足，请先充值', {
										time: 2000,
										icon: 5
									});
									return
								}
								// 如果该商品存在积分
								if (data.jf) {
									this.user.jf = Number(this.user.jf) + Number(data.jf * item.buynumber);
								}
								this.user.money = this.user.money - item.total;
								// 更新用户余额
								layui.http.requestJson(`${localStorage.getItem("userTable")}/update`, 'post', this.user, (res) => {
									item.status = '已支付'
									layui.http.requestJson(`orders/update`, 'post', item, (res) => {
										layui.layer.msg('支付成功', {
											time: 2000,
											icon: 6
										}, function() {
											window.location.reload();
										});
									});
								});
							});
						});
					},
                                        // 退款
                                        refund(item) {
                                                // 获取商品详情信息
                                                layui.http.request(`${item.tablename}/info/${item.goodid}`, 'get', {}, (res) => {
                                                        // 商品信息
                                                        let good = res.data;
                                                        // 用户当前用户信息
                                                        let table = localStorage.getItem("userTable");
                                                        layui.http.request(`${table}/session`, 'get', {}, function(data) {
                                                                this.user = data.data;
                                                                if(item.type==1) {
                                                                        // 如果该商品存在积分
                                                                        if (good.jf) {
                                                                                this.user.jf = Number(this.user.jf) - Number(item.price * item.buynumber);
                                                                        }
                                                                        this.user.money = Number(this.user.money) + Number(item.total);
                                                                        // 更新用户余额
                                                                        layui.http.requestJson(`${localStorage.getItem("userTable")}/update`, 'post', this.user, (res) => {
                                                                                item.status = '已退款'
                                                                                layui.http.requestJson(`orders/update`, 'post', item, (res) => {
                                                                                        layui.layer.msg('退款成功', {
                                                                                                time: 2000,
                                                                                                icon: 6
                                                                                        }, function() {
                                                                                                window.location.reload();
                                                                                        });
                                                                                });
                                                                        });
                                                                } else if(item.type==2) {
                                                                        this.user.jf = Number(this.user.jf) + Number(item.total);
                                                                        // 更新用户余额
                                                                        layui.http.requestJson(`${localStorage.getItem("userTable")}/update`, 'post', this.user, (res) => {
                                                                                item.status = '已退款'
                                                                                layui.http.requestJson(`orders/update`, 'post', item, (res) => {
                                                                                        layui.layer.msg('退款成功', {
                                                                                                time: 2000,
                                                                                                icon: 6
                                                                                        }, function() {
                                                                                                window.location.reload();
                                                                                        });
                                                                                });
                                                                        });

                                                                }
                                                        });
                                                });
                                        },
					confirm(item){
						item.status = '已完成'
						layui.http.requestJson(`orders/update`, 'post', item, (res) => {
							layui.layer.msg('确认收货成功', {
								time: 2000,
								icon: 6
							}, function() {
								window.location.reload();
							});
						});
					},
                    cancel(item){
                            item.status = '已取消'
                            layui.http.requestJson(`orders/update`, 'post', item, (res) => {
                                    layui.layer.msg('订单取消成功', {
                                            time: 2000,
                                            icon: 6
                                    }, function() {
                                            window.location.reload();
                                    });
                            });
                    },

                    //物流
                    logistics(item) {
                        layui.layer.open({
                            type: 2,
                            title: '物流信息',
                            area: ['600px', '600px'],
                            content: './logistics.jsp?id='+item.id
                        });
                    },
                    // 退货
                    returnGood(item) {
                        // 获取商品详情信息
                        layui.http.request(`${item.tablename}/info/${item.goodid}`, 'get', {}, (res) => {
                                // 商品信息
                                let good = res.data;
                                // 用户当前用户信息
                                let table = localStorage.getItem("userTable");
                                layui.http.request(`${table}/session`, 'get', {}, function(data) {
                                        this.user = data.data;
                                        if(item.type==1) {
                                                // 如果该商品存在积分
                                                if (good.jf) {
                                                        this.user.jf = Number(this.user.jf) - Number(item.price * item.buynumber);
                                                }
                                                this.user.money = Number(this.user.money) + Number(item.total);
                                                // 更新用户余额
                                                layui.http.requestJson(`${localStorage.getItem("userTable")}/update`, 'post', this.user, (res) => {
                                                        item.status = '已退款'
                                                        layui.http.requestJson(`orders/update`, 'post', item, (res) => {
                                                                layui.layer.msg('退货成功', {
                                                                        time: 2000,
                                                                        icon: 6
                                                                }, function() {
                                                                        window.location.reload();
                                                                });
                                                        });
                                                });
                                        } else if(item.type==2) {
                                                this.user.jf = Number(this.user.jf) + Number(item.total);
                                                // 更新用户余额
                                                layui.http.requestJson(`${localStorage.getItem("userTable")}/update`, 'post', this.user, (res) => {
                                                        item.status = '已退款'
                                                        layui.http.requestJson(`orders/update`, 'post', item, (res) => {
                                                                layui.layer.msg('退货成功', {
                                                                        time: 2000,
                                                                        icon: 6
                                                                }, function() {
                                                                        window.location.reload();
                                                                });
                                                        });
                                                });

                                        }
                                });
                        });
                    },

				}
			})

			layui.use(['layer', 'element', 'carousel', 'http', 'jquery', 'form', 'laypage'], function() {
				var layer = layui.layer;
				var element = layui.element;
				var carousel = layui.carousel;
				var http = layui.http;
				var jquery = layui.jquery;
				var laypage = layui.laypage;
				var form = layui.form;

				var limit = 10;
				vue.baseurl = http.baseurl;

				// 获取轮播图 数据
				http.request('config/list', 'get', {
					page: 1,
					limit: 5
				}, function(res) {
					if (res.data.list.length > 0) {
						var swiperItemHtml = '';
						for (let item of res.data.list) {
							if (item.name.indexOf('picture') >= 0 && item.value && item.value != "" && item.value != null) {
								swiperItemHtml +=
									'<div>' +
									'<img class="swiper-item" style="width: 100%;height: 100%;object-fit:cover;" src="' + http.baseurl+item.value + '">' +
									'</div>';
							}
						}
						jquery('#swiper-item').html(swiperItemHtml);
						// 轮播图
						vue.$nextTick(() => {
						  carousel.render({
						  	elem: '#swiper',
							width: '100%',
						  	height: '320px',
						  	arrow: 'hover',
						  	anim: 'default',
						  	autoplay: 'true',
						  	interval: '3000',
						  	indicator: 'inside'
						  });
						
						})
					}
				});

				// 获取列表数据
				http.request('orders/list', 'get', {
					page: 1,
					limit: limit,
					userid: localStorage.getItem('userid'),
					status: vue.status
				}, function(res) {
					vue.dataList = res.data.list
					// 分页
					laypage.render({
						elem: 'pager',
						count: res.data.total,
						limit: vue.limit,
						groups: 5,
						layout: ["prev","page","next"],
						theme: '#D1CAB8',
						jump: function(obj, first) {
							//首次不执行
							if (!first) {
								http.request('orders/list', 'get', {
									page: obj.curr,
									limit: obj.limit,
									userid: localStorage.getItem('userid'),
									status: vue.status
								}, function(res) {
									vue.dataList = res.data.list
								})
							}
						}
					});
				})

			});
		</script>
	</body>
</html>
