<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/arr.tld" prefix="afn" %>
<c:import url="/mobile/layout/main-header"/>

    <section class="subheader">
        <div class="txt-box">
            <ul class="txt-box-ul">
                <li class="<c:if test="${searchVO.product_ct eq null}">active</c:if>"><a href="/mall/today" >${afn:getMessage("all",sessionScope.locale)}</a></li>
                <c:if test="${not empty categoryList}">
                <c:forEach var="categoryList" items="${categoryList}" varStatus="status">
                    <li <c:if test="${searchVO.product_ct eq categoryList.pd_category_id}">class="active"</c:if> ><a href="/mall/today?product_ct=${categoryList.pd_category_id}">${categoryList.pd_category_name}</a></li>
                </c:forEach>
            	</c:if>
            </ul>
        </div>
    </section>
    <section class="wrap category-wrap">
        
        <p class="gift-amount">${afn:getMessage("todayPrice_cate",sessionScope.locale)}
       		<c:if test="${searchVO.product_ct eq null}">${afn:getMessage("all",sessionScope.locale)}</c:if>
			<c:forEach var="categoryList" items="${categoryList}" varStatus="status">
                <c:if test="${searchVO.product_ct eq categoryList.pd_category_id}">${categoryList.pd_category_name}</c:if>
            </c:forEach> 
            ${afn:getMessage("msg.today.cateIn",sessionScope.locale)} <span class="gift-amount-number"><fmt:formatNumber value="${searchVO.totRow}" groupingUsed="true" /></span>${afn:getMessage("msg.today.EntProduct",sessionScope.locale)}</p>
        <article class="epoint-gift-wrap">
                <div class="inner clearfix">
                    <div class="sort-tab-left">
                        <c:if test="${not empty param.product_ct}">
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder == '1'}">active</c:if>" onclick="location.href='<c:url value="/mall/today?product_ct=${param.product_ct}&sortOrder=1"/>'">${afn:getMessage("shortRanking",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder == '2'}">active</c:if>" onclick="location.href='<c:url value="/mall/today?product_ct=${param.product_ct}&orderByKey=product_payment&orderByValue=ASC&sortOrder=2"/>'">${afn:getMessage("shortLowPrice",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder == '3'}">active</c:if>" onclick="location.href='<c:url value="/mall/today?product_ct=${param.product_ct}&orderByKey=product_payment&orderByValue=DESC&sortOrder=3"/>'">${afn:getMessage("shorthighPrice",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder == '4'}">active</c:if>" onclick="location.href='<c:url value="/mall/today?product_ct=${param.product_ct}&sortOrder=4"/>'">${afn:getMessage("shortSales",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder == '5'}">active</c:if>" onclick="location.href='<c:url value="/mall/today?product_ct=${param.product_ct}&sortOrder=5"/>'">${afn:getMessage("shortNewest",sessionScope.locale)}</button>
                        </c:if>
                        <c:if test="${empty param.product_ct}">
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder == 1}"><c:out value=" active"/></c:if>" onclick="location.href='<c:url value="/mall/today?sortOrder=1"/>'">${afn:getMessage("shortRanking",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder == '2'}">active</c:if>" onclick="location.href='<c:url value="/mall/today?orderByKey=product_payment&orderByValue=ASC&sortOrder=2"/>'">${afn:getMessage("shortLowPrice",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder eq 3}">active</c:if>" onclick="location.href='<c:url value="/mall/today?orderByKey=product_payment&orderByValue=DESC&sortOrder=3"/>'">${afn:getMessage("shorthighPrice",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder eq '4'}">active</c:if>" onclick="location.href='<c:url value="/mall/today?sortOrder=4"/>'">${afn:getMessage("shortSales",sessionScope.locale)}</button>
                            <button type="button" class="sort-tab-item <c:if test="${searchVO.sortOrder eq 5}">active</c:if>" onclick="location.href='<c:url value="/mall/today?sortOrder=5"/>'">${afn:getMessage("shortNewest",sessionScope.locale)}</button>
                        </c:if>
                    </div>
                </div>
                <div class="point-product-list clearfix">
                	<c:if test="${not empty list}">
                	<c:forEach var="list" items="${list}" varStatus="status">
                    <div class="point-product-item">
                        <a href="<c:url value="/product/productDetail?product_cd=${list.product_cd}"/>">
                            <img src='${list.file_1}' onerror="this.src='http://placehold.it/300x300'" >
                            <p class="sale-percent">${list.percent_discount} <span>%</span></p>
                       
                            
                            <p class="info-production">${list.product_made_company_name}</p>
                            <p class="point-pdt-title">${list.product_name}</p>
                        </a>
                        <p class="info-price">
                            <span class="price-before"><fmt:formatNumber value="${list.product_user_payment}" groupingUsed="true" />${afn:getMessage("korea_won",sessionScope.locale)}</span><br><fmt:formatNumber value="${list.product_payment}" groupingUsed="true" />${afn:getMessage("korea_won",sessionScope.locale)}
                        </p>
                        <p class="info-score">
                            <i class="star-ic"></i>
                        <c:if test="${list.review_score == NULL }"><span class="score-number">0.0</span></c:if>
    					<c:if test="${list.review_score != NULL }"><span class="score-number">${list.review_score}</span></c:if>
                       
                        <c:if test="${list.review_cnt == NULL }"><span class="score-text">(0)</span></c:if>
                        <c:if test="${list.review_cnt != NULL }"><span class="score-text">(${list.review_cnt})</span></c:if>
                      <input type="hidden" name="product_option_yn" value="${list.product_option_yn}" />
                       <i class="share-ic" onclick="share_product('${list.product_cd}', '${list.product_name}')"></i>
                     <a href="#"  onclick="addShoppingBasketF('${list.product_cd}')"class="list-cartic"></a>
                        </p>
                    </div>
                    </c:forEach>
       				</c:if>
                </div>
            <form id="form1" name="form1"  method="get">
                <jsp:include page="/WEB-INF/views/common/pagingforSubmit.jsp" />
                <c:if test="${not empty param.product_ct}">
                	<input type="hidden" name="product_ct" value="${param.product_ct}">
                </c:if>
            </form>
        </article>
    </section>
     <c:import url="/layout/footer"/>
<%--<%@ include file="/WEB-INF/views/mobile/layout/footer.jsp" %> --%>