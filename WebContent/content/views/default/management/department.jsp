<%@page import="com.yc.entity.user.Personnel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>机构管理</title>
<link href="content/static/css/bootstrap/navbar.css" rel="stylesheet">
<link href="content/static/css/bootstrap/bootstrap.min.css"
	rel="stylesheet">
<script src="content/static/js/echart/ie-emulation-modes-warning.js"></script>
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="content/static/img/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="content/static/img/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="content/static/img/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="content/static/img/apple-touch-icon-57-precomposed.png">
<link rel="shortcut icon" href="content/static/img/favicon.png">

<script type="text/javascript"
	src="content/static/js/lib/jquery.min.js"></script>
<script type="text/javascript"
	src="content/static/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="./content/static/js/lib/scripts.js"></script>

<script type="text/javascript"
	src="content/static/js/echart/ie10-viewport-bug-workaround.js"></script>
<link href="content/static/css/bootstrap/bootstrap-tree.css"
	rel="stylesheet">
</head>
<body>
<c:set var="person"
	value='<%=(Personnel) request.getSession().getAttribute(
						"loginPersonnle")%>'></c:set>
	<!-- Static navbar -->
	<jsp:include page="../common/header.jsp"></jsp:include>
	<jsp:include page="../common/menu.jsp"></jsp:include>
	<div class="col-md-4 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					机构
				</h3>
			</div>
			<div class="tree well">
				<c:set var="index" value="0" scope="request" />
				<!-- 自增序号，注意scope-->
				<c:set var="level" value="0" scope="request" />
				<!-- 记录树的层次，注意scope-->
				<c:import url="__department.jsp" />
			</div>
		</div>
	</div>
	<div class="col-md-6 column">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">操作</h3>
			</div>
			<div class="list-group-item">
				<p class="list-group-item-text">
					<br>
					<form class="form-horizontal" action="management/addOrUpdateDep"  id="form" name="form" 
						method="POST">
						<div class="form-group">
							<label class="col-sm-2 control-label">上级机构:</label>
							<c:if test="${department.parentLevel != null }">
								<label class="col-sm-2 control-label">${department.parentLevel.departmentName }</label>
							</c:if>
							<br>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">机构名称:</label> 
							<div class="col-sm-8">
							<input id="departmentID" name="departmentID" value="${department.departmentID }" type="hidden">
								<input name="departmentname" class="form-control"
									value="${department.departmentName }"> <br>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">
								机构描述:</label>
							<div class="col-sm-8">
								<textarea rows="2" name="describes" id="describes"
									class="form-control">${department.describes }</textarea>
								<br>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-8" style="text-align: center;">
								<c:if test="${person.department.departmentID == department.departmentID && person.department.level <4 }">
								<button type="submit" class="btn btn-default">添加下级机构</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								<button type="button" class="btn btn-default" onclick="updateDepartmen();">修改机构内容</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-default" onclick="deleteDepartmen();">删除本机构</button>
							</div>
						</div>
					</form>
				</P>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function onclickID(id) {
			location.href = 'management/getDepartment?departmentId=' + id+"&page=department";
		}
		function updateDepartmen(){
			document.form.action="management/updateDepartmen?departmentId="+$('#departmentID').val();
			document.form.submit();
		}
		function deleteDepartmen(){
			document.form.action="management/deleteDepartmen?departmentId="+$('#departmentID').val();
			document.form.submit();
		}
		$(function() {
			$('.tree li:has(ul)').addClass('parent_li').find(' > span').attr(
					'title', 'Collapse this branch');
			$('.tree li.parent_li > span').on(
					'click',
					function(e) {
						var children = $(this).parent('li.parent_li').find(
								' > ul > li');
						if (children.is(":visible")) {
							children.hide('fast');
							$(this).attr('title', 'Expand this branch').find(
									' > i').addClass('icon-plus-sign')
									.removeClass('icon-minus-sign');
						} else {
							children.show('fast');
							$(this).attr('title', 'Collapse this branch').find(
									' > i').addClass('icon-minus-sign')
									.removeClass('icon-plus-sign');
						}
						e.stopPropagation();
					});
		});
	</script>
</body>
</html>
