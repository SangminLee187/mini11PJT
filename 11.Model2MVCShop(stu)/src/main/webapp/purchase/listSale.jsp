<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {padding-top : 50px;}
    </style>
    
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listSale.do" method="post">
<!-- ȭ�鱸�� ���� -->
	<div class="container">
	<!-- ȭ���̸� -->
		<div class="page-header text-info">
			<h3 align="center">�ǸŸ�� ��ȸ</h3>	
		</div>
	<!-- ȭ���̸� -->
	<!-- �˻� ���� -->
		<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  			  
				</form>
	    	</div>
		</div>
		<!-- �˻� �� -->
		
	
	</div>
<!-- ȭ�鱸�� �� -->

<table width="100%" border="0" cellspacing="0" cellpadding="0"   style="margin-top: 10px;">
   <tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
   </tr>
   <tr>
      <td class="ct_list_b" width="100">��۹�ȣ</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="150">ȸ��ID</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="150">��ǰ��ȣ</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b">��ȭ��ȣ</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b">�����Ȳ</td>
      <td class="ct_line02"></td>
   </tr>
   <tr>
      <td colspan="11" bgcolor="808285" height="1"></td>
   </tr>
	<%--
	<%
		for(int i=0; i<list.size(); i++) {
			Purchase purc = (Purchase)list.get(i);
	%>		
	<tr class="ct_list_pop">
		<td align="center">
			 <%=i+1 %></a>
		</td>
		<td></td>
		<td align="center">
			<a href="/getUser.do?userId=<%=purc.getBuyer().getUserId()%>"><%=purc.getBuyer().getUserId() %></a>
		</td>
		<td></td>
		<td align="center"><a href="/getPurchase.do?tranNo=<%=purc.getTranNo() %>"><%=purc.getPurchaseProd().getProdNo()%></a>
		</td>
		<td></td>
		<td align="left"><%=purc.getReceiverPhone() %></td>
		<td></td>
		<td align="center"><%=purc.getTranCode() %>	</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	

	<%
		}
	%>	
   	 --%>
       <c:set var="i" value="0"/>
    <c:forEach var="purc" items="${list}">
    <c:set var="i" value="${i+1}"/>
   	<tr classs="ct_list_pop">
    	<td align="center">
			<a href="/purchase/getPurchase?tranNo=${purc.tranNo}">${purc.tranNo}</a>
    	</td>
		<td></td>
		<td align="center">
			<a href="/user/getUser?userId=${purc.buyer.userId}">${purc.buyer.userId}</a>
		</td>
		<td></td>
		<td align="center">
			<a href="/product/getProduct?prodNo=${purc.purchaseProd.prodNo}&menu=${param.menu}"> ${purc.purchaseProd.prodNo}</a>
		</td>
		<td></td>
		<td align="center">${purc.receiverPhone}</td>
		<td></td>
		<td align="center">
			<c:if test= "${empty purc.tranCode }"> �Ǹ���		
			</c:if>
			<c:if test= "${purc.tranCode == '111'}"> ���ſϷ�
			</c:if>	
			<c:if test= "${purc.tranCode == '222'}"> �����
			</c:if>
			<c:if test= "${purc.tranCode == '333'}"> ��ۿϷ� 
			</c:if>		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
    </c:forEach>
    
   

   
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
   <tr>
      <td align="center">
       
 <input type="hidden" id="currentPage" name="currentPage" value=""/>
 <input type="hidden" id="menu" name="menu" value="${param.menu}"/>
 
			
			<%--
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					�� ����
			<% }else{ %>
					<a href="javascript:fncGetSaleList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetSaleList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="javascript:fncGetSaleList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
			<% } %>      
			--%>
		<jsp:include page="../common/pageNavigator_new.jsp"/>
			
      </td>
   </tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>