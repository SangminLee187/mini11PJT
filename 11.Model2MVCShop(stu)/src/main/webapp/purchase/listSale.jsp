<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
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
<!-- 화면구성 시작 -->
	<div class="container">
	<!-- 화면이름 -->
		<div class="page-header text-info">
			<h3 align="center">판매목록 조회</h3>	
		</div>
	<!-- 화면이름 -->
	<!-- 검색 시작 -->
		<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  			  
				</form>
	    	</div>
		</div>
		<!-- 검색 끝 -->
		
	
	</div>
<!-- 화면구성 끝 -->

<table width="100%" border="0" cellspacing="0" cellpadding="0"   style="margin-top: 10px;">
   <tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
   </tr>
   <tr>
      <td class="ct_list_b" width="100">배송번호</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="150">회원ID</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="150">상품번호</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b">전화번호</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b">배송현황</td>
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
			<c:if test= "${empty purc.tranCode }"> 판매중		
			</c:if>
			<c:if test= "${purc.tranCode == '111'}"> 구매완료
			</c:if>	
			<c:if test= "${purc.tranCode == '222'}"> 배송중
			</c:if>
			<c:if test= "${purc.tranCode == '333'}"> 배송완료 
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
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetSaleList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetSaleList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetSaleList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %>      
			--%>
		<jsp:include page="../common/pageNavigator_new.jsp"/>
			
      </td>
   </tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>