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
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
		
	//============= 썸네일 물품상세보기  Event  처리(Click) =============	
	 $(function() {
		$( ".thumbnail" ).on("click" , function() {
			var prodNo = $(this).find('.prodNo').val();
			self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
		});						
	});	
	
	</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<div class="page-header text-info">
			<h3>
			 <c:if test="${param.menu == 'manage' }">
			 	상품관리
			 </c:if>
			 <c:if test="${param.menu == 'search' }">	
			 	상품목록조회
			 </c:if>
			</h3>	
		</div>
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
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
				  <input type="hidden" id="menu" name="menu" value="${param.menu}"/>
				  			  
				</form>
	    	</div>
		</div>						    
	<!-- table 위쪽 검색 End //////////////////////////////////////////////////////////////////-->

    <!--  table Start /////////////////////////////////////-->
        
	<tbody>
		<c:set var="i" value="0" />

<div class="row">
		<c:forEach var="product" items="${list}">		
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
			  
			  <!-- 썸네일 -->
				  <div class="col-sm-6 col-md-4">
				    <div class="thumbnail" style="height : 450px;">
				    <input type="hidden" value="${product.prodNo}" class="prodNo"/>				
				      <img src="/images/uploadFiles/${product.fileName}" alt="..." width="242" height="200">
				      <div class="caption">
						<c:if test= "${empty product.proTranCode }"> 판매중		
						</c:if>
						<c:if test= "${product.proTranCode == '111'}"> 구매완료
						<c:if test="${user.role == 'admin'}">
						<a href="/purchase/updateTranCode?prodNo=${product.prodNo}&tranCode=222">배송하기</a>
						</c:if>
						</c:if>	
						<c:if test= "${product.proTranCode == '222'}"> 배송중
						</c:if>
						<c:if test= "${product.proTranCode == '333'}"> 배송완료 
						</c:if>
				        <h3>${product.prodName}</h3>
				        <h4>${product.price}원</h4>
				        <p>${product.prodDetail}</p>
				      </div>
				    </div>
				  </div>
				<!-- 썸네일 -->
				<!-- 
				<td align="left" >
					<c:if test="${ !empty product.proTranCode}">
						${product.prodName}
					</c:if>
					<c:if test="${empty product.proTranCode }">
						${product.prodName}
					
					</c:if>
				</td>
				<td align="left">${product.price}</td>
				<td align="left">${product.regDate}</td>
				<td align="left">
					<c:if test= "${empty product.proTranCode }"> 판매중		
					</c:if>
					<c:if test= "${product.proTranCode == '111'}"> 구매완료
					<c:if test="${user.role == 'admin'}">
					<a href="/purchase/updateTranCode?prodNo=${product.prodNo}&tranCode=222">배송하기</a>
					</c:if>
					</c:if>	
					<c:if test= "${product.proTranCode == '222'}"> 배송중
					</c:if>
					<c:if test= "${product.proTranCode == '333'}"> 배송완료 
					</c:if>
				</td>
				<td align="left"><i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
					<input type="hidden" value="${product.prodNo}" class="hiddenProduct"/>
				
				</td>-->
			</tr>
		</c:forEach>
</div>

	</tbody>
	<!--  table End /////////////////////////////////////-->
	</div>
	<!--  화면구성 div End /////////////////////////////////////-->
	 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
</body>
</html>