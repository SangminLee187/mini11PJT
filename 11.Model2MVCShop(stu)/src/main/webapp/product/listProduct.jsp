<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%--
<%@ page import="java.util.List"  %>
<%@page import="com.model2.mvc.service.domain.User"%>
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>


/////////////////////////EL - JSTL 수정 ///////////////////
		String menu =(String)request.getAttribute("menu");
		User user = (User)request.getAttribute("user");
List<Product> list= (List<Product>)request.getAttribute("list");
Page resultPage=(Page)request.getAttribute("resultPage");

Search search = (Search)request.getAttribute("search");
//==> null 을 ""(nullString)으로 변경
String searchCondition = CommonUtil.null2str(search.getSearchCondition());
String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
--%>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		console.log("current Page : "+$("#currentPage").val());
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
	//클릭시 자세히보기 및 구매버튼
	$(function () {						//start of function
		$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			fncGetList(1);
		});
			
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			//self.location ="/product/getProduct?prodNo="+$("input[type='hidden']").val()+"&menu=${param.menu}";
			//var prodNo = $("input[type='hidden']").val();
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
						var displayValue = "<h3>"
								+"제품명 : "+JSONData.prodName+"<br/>"
								+"가  격 : "+JSONData.price+"<br/>"
								+"세부사항 : "+JSONData.prodDetail+"<br/>"
								+"제조일 : "+JSONData.manuDate+"<br/>"
+"<input type='button' value='구매' onclick=location.href='/product/getProduct?prodNo="+JSONData.prodNo+"&menu=${param.menu}'>"
										+"</h3>";
						$("h3").remove();
						$( "#"+prodNo+"" ).html(displayValue);	
					}
				});
		});
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
		
		/////////////////////////////////////////////////////////////////
		var count = 1;
		for(var i = 1 ; i<=20 ; i++){
			count = i;
		   $("<h1>"+count+" line scroll</h1>").appendTo("body");

	        if(count == 20) {
	            $(window).bind("scroll",infinityScrollFunction);
	        }
		}
		
		 function infinityScrollFunction() {

		        //현재문서의 높이를 구함.
		        var documentHeight  = $(document).height();
		        console.log("documentHeight : " + documentHeight);
		        
		        //scrollTop() 메서드는 선택된 요소의 세로 스크롤 위치를 설정하거나 반환    
		        //스크롤바가 맨 위쪽에 있을때 , 위치는 0
		        console.log("window의 scrollTop() : " + $(window).scrollTop()); 
		        //height() 메서드는 브라우저 창의 높이를 설정하거나 반환
		        console.log("window의 height() : " + $(window).height());
		        var windouwHeight = $(window).height();
		        
		        //세로 스크롤위치 max값과 창의 높이를 더하면 현재문서의 높이를 구할수있음.
		        //세로 스크롤위치 값이 max이면 문서의 끝에 도달했다는 의미
		        var scrollHeight = $(window).scrollTop()+$(window).height();         
		        console.log("scrollHeight : " + scrollHeight+"\n\n");
		            
		        ///////////////////////
		    var $window = $(this);
			var scrollTop = $(window).scrollTop();
			var windowHeight = $(window).height();
			var documentHeight = $(document).height();
		        //////////////////////
		        
		        if(scrollTop + windowHeight == documentHeight) { //문서의 맨끝에 도달했을때 내용 추가
		                //count = count + 1;
		                count++;
		                //$("<h1> infinity scroll </h>").appendTo("body");
		                $("<h1>"+count+" line scroll</h1>").appendTo(".ct_list_pop");
		            }
		        }
		    }//function infinityScrollFunction()

		/////////////////////////////////////////////////////////////////
	});									//end of function
	<%--
	//무한스크롤
	$(function(){
		var index = 1;
		$(window).scroll(function(){
			var $window = $(this);
			var scrollTop = $(window).scrollTop();
			var windowHeight = $(window).height();
			var documentHeight = $(document).height();
			
			if(scrollTop + windowHeight + 1 >= documentHeight){
				index++;
				setTimeout(infiniteScroll,200);
			}
			
			var prodNo = $(this).find('.hiddenProduct').val();
			function infiniteScroll(){
				$.ajax({
					url : "/product/json/getProduct/"+prodNo ,					
					method : "GET" ,			
					dataType : "json" ,
					success : function(JSONData , status) {
						var displayValue = "<h3>"
								+"제품명 : "+JSONData.prodName+"<br/>"
								+"가  격 : "+JSONData.price+"<br/>"
								+"세부사항 : "+JSONData.prodDetail+"<br/>"
								+"제조일 : "+JSONData.manuDate+"<br/>"
+"<input type='button' value='구매' onclick=location.href='/product/getProduct?prodNo="+JSONData.prodNo+"&menu=${param.menu}'>"
										+"</h3>";
						$("h3").remove();
						$( "#"+prodNo+"" ).html(displayValue);	
					}
				})	
				}
			}
			}
		})
	})
	--%>
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<!--
<form name="detailForm" action="/product/listProduct?menu=${param.menu}" method="post">
-->
<form name="detailForm">


<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">						
						<%--	<% if(menu.equals("manage")){ %>
									상품 관리
							<%}else{%>
									상품목록조회
							<% } %>	
						 --%>
						 <c:if test="${param.menu == 'manage' }">
						 	상품관리
						 </c:if>
						 <c:if test="${param.menu == 'search' }">	
						 	상품목록조회
						 </c:if>			
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>	
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			</select>
			<input 	type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
							class="ct_input_g" style="width:200px; height:19px" />
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- 
						<a href="javascript:fncGetList('1');">검색</a>
						 -->검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%--
		for(int i=0; i<list.size(); i++) {
			Product vo = (Product)list.get(i);
			
		
	
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>
		<td align="left">
			<a href="/getProduct.do?prodNo=<%=vo.getProdNo()%>&menu=<%=menu%>"><%=vo.getProdName() %></a>
		</td>
		<td></td>
		<td align="left"><%=vo.getPrice() %></td>
		<td></td>
		<td align="left"><%=vo.getRegDate() %></td>
		<td></td>
		<td align="left"> 
							<%if(vo.getProTranCode() == "111"){%>판매중<%}%>			
		<a href="/updateTranCode.do?prodNo=<%=vo.getProdNo() %>&tranCode=222">배송하기</a>	
						 	
			
			<!-- 추후 수정 필요 -->
		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	

		}
	--%>	
	
		<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">
				<c:if test="${ !empty product.proTranCode}">
					${product.prodName}
				</c:if>
				<c:if test="${empty product.proTranCode }">
					<!-- 
					<a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a>
					 -->${product.prodName}
				<!-- <input type="hidden" value="${product.prodNo}"/> prodNo 10000 반복 --> 
				<input type="hidden" value="${product.prodNo}" class="hiddenProduct"/>
				</c:if>
				</td>
			<td></td>			
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>
			<td></td>
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
						 	
		</tr>
		<tr>
		<!--<td colspan="11" bgcolor="D6D7D6" height="1"></td>-->
		<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		
		</tr>
	</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			<input type="hidden" id="menu" name="menu" value="${param.menu}"/>
			<%--
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %>
			 --%>
			<jsp:include page="../common/pageNavigator.jsp"/>	
			 
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>