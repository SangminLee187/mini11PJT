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
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
		
	//============= prodName �� ��ǰ�󼼺���  Event  ó��(Click) =============	
	 $(function() {
		$( ".ct_list_pop td:nth-child(2)" ).on("click" , function() {
			var prodNo = $(this).find('.prodNo').val();
			self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
		});
							
	});	
	
	//Ŭ���� �ڼ������� �� ���Ź�ư
	$(function () {						//start of function
		$( ".ct_list_pop td:nth-child(6)" ).on("click" , function() {
			var prodNo = $(this).find('.hiddenProduct').val();
			$.ajax(
				{
					url : "/product/json/getProduct/"+prodNo ,					
					method : "GET" ,			
					dataType : "json" ,
					headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						var displayValue = "<h4>"
								+"��ǰ�� : "+JSONData.prodName+"<br/>"
								+"��  �� : "+JSONData.price+"<br/>"
								+"���λ��� : "+JSONData.prodDetail+"<br/>"
								+"������ : "+JSONData.manuDate+"<br/>"
+"<input type='button' value='����' onclick=location.href='/product/getProduct?prodNo="+JSONData.prodNo+"&menu=${param.menu}'>"
										+"</h4>";
						$("h3").remove();
						$( "#"+prodNo+"" ).html(displayValue);	
					}
				});
		});
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "blue");
	});
	</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<div class="page-header text-info">
			<h3>
			 <c:if test="${param.menu == 'manage' }">
			 	��ǰ����
			 </c:if>
			 <c:if test="${param.menu == 'search' }">	
			 	��ǰ�����ȸ
			 </c:if>
			</h3>	
		</div>
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
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
				  <input type="hidden" id="menu" name="menu" value="${param.menu}"/>
				  			  
				</form>
	    	</div>
		</div>						    
	<!-- table ���� �˻� End //////////////////////////////////////////////////////////////////-->

    <!--  table Start /////////////////////////////////////-->
<table class="table table-hover table-striped" >
   
	<thead>
		<tr>
		 <th align="center">��ȣ</th>
		 <th align="left" >��ǰ��</th>
		 <th align="left">����</th>
		 <th align="left">�����</th>
		 <th align="left">�������</th>
		 <th align="left">��������</th>
		</tr>
	</thead>
     
	<tbody>
		<c:set var="i" value="0" />
		<c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
				<td align="center">${ i }</td>
				<td align="left" >
					<input type="hidden" value="${product.prodNo}" class="prodNo"/>				
					<c:if test="${ !empty product.proTranCode}">
						${product.prodName}
					</c:if>
					<c:if test="${empty product.proTranCode }">
						${product.prodName}
					<!-- 
					<input type="hidden" value="${product.prodNo}" class="hiddenProduct"/>
					 -->
					</c:if>
				</td>
				<td align="left">${product.price}</td>
				<td align="left">${product.regDate}</td>
				<td align="left">
					<c:if test= "${empty product.proTranCode }"> �Ǹ���		
					</c:if>
					<c:if test= "${product.proTranCode == '111'}"> ���ſϷ�
					<c:if test="${user.role == 'admin'}">	
					<a href="/purchase/updateTranCode?prodNo=${product.prodNo}&tranCode=222">����ϱ�</a>
					</c:if>
					</c:if>	
					<c:if test= "${product.proTranCode == '222'}"> �����
					</c:if>
					<c:if test= "${product.proTranCode == '333'}"> ��ۿϷ� 
					</c:if>
				</td>
				<td align="left"><i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
					<input type="hidden" value="${product.prodNo}" class="hiddenProduct"/>
				
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
	<!--  table End /////////////////////////////////////-->
	</div>
	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
	 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
</body>
</html>