<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/arr.tld" prefix="afn" %>
<c:import url="/mobile/layout/sub-header"/>

    <section class="subheader">
        <div class="subTitle">${afn:getMessage('giveaway_parti_list',sessionScope.locale)} ${afn:getMessage('lookup',sessionScope.locale)}</div>
        <section class="subheader">
            <c:import url="/MyPage/RightHeaderSub"/>
        </section>
        <ul class="taps">
            <li><a href="javascript:show(1)" id="tap1" class="active">${afn:getMessage('giveaway',sessionScope.locale)}</a></li>
            <%-- <li><a href="javascript:show(2)" id="tap2">이벤트</a></li> --%>
            <li><a href="javascript:void(0)" class="ready" id="tap2">${afn:getMessage('event',sessionScope.locale)}</a></li>
        </ul>
    </section>
    <section class="wrap clearfix" id="write">
    <form id="form1" name="form1">
        <!-- <select class="full text-center mb-02">
            <option value="0" selected>전체</option>
            <option value="1">진행중</option>
            <option value="2">추첨완료</option>
            <option value="3">당첨</option>
        </select> -->
        <ul class="btns">
            <li><a href="javascript:void(0)" class="ra-num" data-id="con1">${afn:getMessage('today',sessionScope.locale)}</a></li>
            <li><a href="javascript:void(0)" class="ra-num" data-id="con2">1${afn:getMessage('week',sessionScope.locale)}</a></li>
            <li><a href="javascript:void(0)" class="ra-num" data-id="con3">1${afn:getMessage('month',sessionScope.locale)}</a></li>
            <li><a href="javascript:void(0)" class="ra-num" data-id="con4">3${afn:getMessage('month',sessionScope.locale)}</a></li>
<%--            <li><a href="#" data-id="con2">기간설정</a></li>--%>
        </ul>
        <div class="date-box">
            <div class="input-box2">
                <div class="cla">
                    <input type="text" id="from_date" name="start_date" class="date_pick" value="<c:out value="${param.start_date}"/>">
                    <!-- <div class="cla-img1"></div> -->
                </div>
                <p class="cla-p1"> ~ </p>
                <div class="cla">
                    <input type="text" id="to_date" name="end_date" class="date_pick" value="<c:out value="${param.end_date}"/>">
                    <!-- <div class="cla-img1"></div> -->
                </div>
            </div>
            <button type="submit" class="date-btn">${afn:getMessage('lookup',sessionScope.locale)}</button>
        </div>
        <table>
            <colgroup>
                <col style="width: 70%;">
                <col style="width: 30%;">
            </colgroup>
            <thead class="lis-head">
                <tr>
                    <th colspan="2">${afn:getMessage('giveaway_parti',sessionScope.locale)}</th>
                </tr>
            </thead>
        </table>

        <c:if test="${not empty list}">
            <c:forEach var="list" items="${list}" varStatus="status">
                <ul class="product pb-0">
                    <h5><fmt:formatDate value="${list.reg_date}" pattern="yyyy.MM.dd"/><br><fmt:formatDate value="${list.reg_date}" pattern="HH:mm"/></h5>
                    <ul class="pb-0">
                        <li>
                            <a href="/giveaway/giveawaydetail?giveaway_cd=${list.giveaway_cd}"><img src="${list.file_1}" onerror="this.src='http://placehold.it/80'" alt=""></a></li>
                        <li>
                            <p>${list.giveaway_brand}</p>
                            <h5>${list.giveaway_name}</h5>
                            <p class="grey">${list.giveaway_model_name}</p>
                        </li>
                    </ul>
                    <ul class="options mb-1">
                        <li>${afn:getMessage('use_point_total',sessionScope.locale)}</li>
                        <li><fmt:formatNumber value="${list.giveaway_payment_epoint}" groupingUsed="true" /> <span>P</span></li>
                    </ul>
                    <ul class="options bg_grey p-1 op-width">
                        <c:if test="${empty list.giveaway_winner_reg_date && empty list.winner_id}">
                            <td>
                                <li>${afn:getMessage('ongoing',sessionScope.locale)}</li>
                                
                            </td>
                        </c:if>
                        <c:if test="${not empty list.giveaway_winner_reg_date && empty list.winner_id}">
                            <td>
                                <li>${afn:getMessage('use_point_total',sessionScope.locale)}</li>
                                <span class="grey text-xs">(<fmt:formatDate value="${list.giveaway_winner_reg_date}" pattern="yyyy.MM.dd"/>)</span>
                            </td>
                        </c:if>
                        <c:if test="${not empty list.giveaway_winner_reg_date && list.winner_id > 0}">
                            <li><span class="txt-active">${afn:getMessage('win',sessionScope.locale)}</span></li>
                            <c:if test="${list.giveaway_payment_status !=  'A'}"><p class="txt-s"><span>(${list.payment_status_name})</span></p></c:if>
                            <span class="grey text-xs">(<fmt:formatDate value="${list.giveaway_winner_reg_date}" pattern="yyyy.MM.dd"/>)</span>
                        </c:if>
<%--                        <li>진행중<span class="grey text-xs">(2019.04.15)</span></li>--%>
                        <li>
<%--                            <button class="btn btn-blue">다른경품 더보기</button>--%>

                            <c:if test="${not empty list.giveaway_winner_reg_date && list.winner_id > 0}">
                                <c:if test="${list.giveaway_payment_status eq 'A' || list.payment_status == 'N'}">
                                    <a href="/MyPage/giveawayform?giveaway_cd=${list.giveaway_cd}&giveaway_play_cd=${list.giveaway_play_cd}">
                                        <button type="button" class="btn btn-red">${afn:getMessage('giveaway',sessionScope.locale)}${afn:getMessage('receive',sessionScope.locale)}</button>
                                    </a>
                                </c:if>
                                <c:if test="${list.giveaway_payment_status !=  'A' && list.payment_status != 'N'}">
                                    <a href="#" id="SearchDelivery">
                                        <button type="button" class="btn btn-red">${afn:getMessage('QA_delivery',sessionScope.locale)}${afn:getMessage('receive',sessionScope.locale)}</button>
                                    </a>
                                    <c:if test="${list.payment_status == 'M' && list.pay_method == 'vbank'}">
	                                    <a href="javascript:vbankNoCheck('${list.imp_uid}')" >
	                                    	<button type="button" class="btn">${afn:getMessage('vbank',sessionScope.locale)} ${afn:getMessage('QAok',sessionScope.locale)}</button>
	                                    </a>
                                    </c:if>
                                    <c:if test="${list.payment_status != 'M' }">
                                    	<a href="javascript:withholding('${list.order_no}')">
                                    		<button type="button" class="btn">${afn:getMessage('withholding',sessionScope.locale)}</button>
                                   		</a>
                                    </c:if>
                                </c:if>
                            </c:if>
                        </li>
                    </ul>
                </ul>
            </c:forEach>
        </c:if>
        <c:if test="${empty list}">
            <ul>
                <li colspan="5">${afn:getMessage('msg.none_content',sessionScope.locale)}</li>
                <li></li>
                <li></li>
            </ul>
        </c:if>
        <hr>
        <jsp:include page="/WEB-INF/views/common/pagingforSubmit.jsp" />
        </form>
    </section>
    <section class="wrap clearfix" id="list">
       <select class="full text-center mb-02" align="center">
            <option value="0" selected>전체</option>
            <option value="1">진행중</option>
            <option value="2">추첨완료</option>
            <option value="3">당첨</option>
       </select>
       <ul class="btns" id="date">
            <li><a href="#" class="active">오늘</a></li>
            <li><a href="#">1주일</a></li>
            <li><a href="#">1개월</a></li>
            <li><a href="#">3개월</a></li>
            <li><a href="#">기간설정</a></li>
       </ul>
       <table>
            <colgroup>
                <col style="width: 70%;">
                <col style="width: 30%;">
            </colgroup>
            <thead class="lis-head">
                <tr>
                    <th colspan="2">이벤트 응모</th>
                </tr>
            </thead>
            <tbody class="lis-body">
                <tr>
                    <td class="lis-td-con">
                        <p><span>예쁜 우리집 자랑만해도 E-POINT가 쏟아진다!</span></p>
                        <p><span>2019.04.11 ~ 2019.12.31</span></p>
                    </td>
                    <td class="lis-td-p">
                        <p><span class="txt-active">추첨완료</span></p>
                    </td>
                </tr>
                <tr>
                    <td class="lis-td-con">
                        <p><span>예쁜 우리집 자랑만해도 E-POINT가 쏟아진다!</span></p>
                        <p><span>2019.04.11 ~ 2019.12.31</span></p>
                    </td>
                    <td class="lis-td-p">
                        <p><span>진행중</span></p>
                    </td>
                </tr>
                <tr>
                    <td class="lis-td-con">
                        <p><span>예쁜 우리집 자랑만해도 E-POINT가 쏟아진다!</span></p>
                        <p><span>2019.04.11 ~ 2019.12.31</span></p>
                    </td>
                    <td class="lis-td-p">
                        <p><span>진행중</span></p>
                    </td>
                </tr>
                <tr>
                    <td class="lis-td-con">
                        <p><span>예쁜 우리집 자랑만해도 E-POINT가 쏟아진다!</span></p>
                        <p><span>2019.04.11 ~ 2019.12.31</span></p>
                    </td>
                    <td class="lis-td-p">
                        <p><span>진행중</span></p>
                    </td>
                </tr>
                <tr>
                    <td class="lis-td-con">
                        <p><span>예쁜 우리집 자랑만해도 E-POINT가 쏟아진다!</span></p>
                        <p><span>2019.04.11 ~ 2019.12.31</span></p>
                    </td>
                    <td class="lis-td-p">
                        <p><span>진행중</span></p>
                    </td>
                </tr>
            </tbody>
        </table>
        <ul class="centerBtns mt-3">
            <li><a href="#"><i class="ri-arrow-left-s-line"></i></a></li>
            <li><a href="#" class="active">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#"><i class="ri-arrow-right-s-line"></i></a></li>
        </ul>
    </section>
    <nav class="nav">
        <ul>
            <li><a href="#" id="nav-cate"><i class="cate-ic">카테고리</i></a></li>
            <li><a href="../../index-mobile.html" id="nav-home"><i class="home-ic">홈</i></a></li>
            <li><a href="/product/search-page" id="nav-src"><i class="src-ic">검색</i></a></li>
            <li><a href="mypage-main.html" id="nav-user"><i class="user-ic">마이페이지</i></a></li>
        </ul>
    </nav>
    <div class="category">
       <div class="cate-bg"></div>
        <div class="content">
            <div class="cate-close"><span></span></div>
            <header class="cate-hd">
                <div class="cate-hdTop">
                    <p><span>asiddfdfj@naver.com</span>님 환영합니다.</p>
<!--                    <a href="#" class="login">로그인 ＞</a>-->
                </div>
                <ul class="cate-hdBtm">
                    <li><a href="sub/mobile/mypage-main.html"><i class="user-ic"></i><p>마이페이지</p></a></li>
                    <li><a href="sub/mobile/mypage-6.html"><i class="ship-ic"></i><p>주문/배송</p></a></li>
                    <li><a href="sub/mobile/mypage-5.html"><i class="heart-ic"></i><p>위시리스트</p></a></li>
                    <li><a href="sub/mobile/help-4-2.html"><i class="call-ic"></i><p>고객센터</p></a></li>
                </ul>
            </header>
            <div class="cate-body">
                <h4 class="cate-ttl">카테고리</h4>
                <hr>
                <ul class="cateList">
                    <li>
                        <a href="#">뷰티</a>
                        <ul class="cateList-2dp">
                            <li>
                                <a href="#">수입</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">스킨케어</a></li>
                                    <li><a href="#">클렌징 ∙ 필링</a></li>
                                    <li><a href="#">팩 ∙ 마스크</a></li>
                                    <li><a href="#">메이크업</a></li>
                                    <li><a href="#">네일케어</a></li>
                                    <li><a href="#">헤어케어</a></li>
                                    <li><a href="#">바디케어</a></li>
                                    <li><a href="#">향수</a></li>
                                    <li><a href="#">남성 화장품</a></li>
                                    <li><a href="#">뷰티소품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">명품</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">스킨케어</a></li>
                                    <li><a href="#">클렌징 ∙ 필링</a></li>
                                    <li><a href="#">팩 ∙ 마스크</a></li>
                                    <li><a href="#">메이크업</a></li>
                                    <li><a href="#">네일케어</a></li>
                                    <li><a href="#">헤어케어</a></li>
                                    <li><a href="#">바디케어</a></li>
                                    <li><a href="#">향수</a></li>
                                    <li><a href="#">남성 화장품</a></li>
                                    <li><a href="#">뷰티소품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">매스티지</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">스킨케어</a></li>
                                    <li><a href="#">클렌징 ∙ 필링</a></li>
                                    <li><a href="#">팩 ∙ 마스크</a></li>
                                    <li><a href="#">메이크업</a></li>
                                    <li><a href="#">네일케어</a></li>
                                    <li><a href="#">헤어케어</a></li>
                                    <li><a href="#">바디케어</a></li>
                                    <li><a href="#">향수</a></li>
                                    <li><a href="#">남성 화장품</a></li>
                                    <li><a href="#">뷰티소품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">매스</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">스킨케어</a></li>
                                    <li><a href="#">클렌징 ∙ 필링</a></li>
                                    <li><a href="#">팩 ∙ 마스크</a></li>
                                    <li><a href="#">메이크업</a></li>
                                    <li><a href="#">네일케어</a></li>
                                    <li><a href="#">헤어케어</a></li>
                                    <li><a href="#">바디케어</a></li>
                                    <li><a href="#">향수</a></li>
                                    <li><a href="#">남성 화장품</a></li>
                                    <li><a href="#">뷰티소품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">트렌드</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">스킨케어</a></li>
                                    <li><a href="#">클렌징 ∙ 필링</a></li>
                                    <li><a href="#">팩 ∙ 마스크</a></li>
                                    <li><a href="#">메이크업</a></li>
                                    <li><a href="#">네일케어</a></li>
                                    <li><a href="#">헤어케어</a></li>
                                    <li><a href="#">바디케어</a></li>
                                    <li><a href="#">향수</a></li>
                                    <li><a href="#">남성 화장품</a></li>
                                    <li><a href="#">뷰티소품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">해외직구</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">스킨케어</a></li>
                                    <li><a href="#">클렌징 ∙ 필링</a></li>
                                    <li><a href="#">팩 ∙ 마스크</a></li>
                                    <li><a href="#">메이크업</a></li>
                                    <li><a href="#">네일케어</a></li>
                                    <li><a href="#">헤어케어</a></li>
                                    <li><a href="#">바디케어</a></li>
                                    <li><a href="#">향수</a></li>
                                    <li><a href="#">남성 화장품</a></li>
                                    <li><a href="#">뷰티소품</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">식품</a>
                        <ul class="cateList-2dp">
                            <li>
                                <a href="#">과일</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">사과/배</a></li>
                                    <li><a href="#">감귤/한라봉</a></li>
                                    <li><a href="#">감</a></li>
                                    <li><a href="#">키위</a></li>
                                    <li><a href="#">토마토/자두/복숭아</a></li>
                                    <li><a href="#">수박/메론/참외</a></li>
                                    <li><a href="#">딸기/블루베리/기타</a></li>
                                    <li><a href="#">바나나/오렌지/수입과일</a></li>
                                    <li><a href="#">냉동과일</a></li>
                                    <li><a href="#">건조과일</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">채소</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">산/들/바다</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">쌀/잡곡</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">쌀</a></li>
                                    <li><a href="#">잡곡</a></li>
                                    <li><a href="#">혼합곡</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">정육/계란</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">소고기</a></li>
                                    <li><a href="#">돼지고기</a></li>
                                    <li><a href="#">닭/오리/양고기</a></li>
                                    <li><a href="#">계란/알류</a></li>
                                    <li><a href="#">양념/가공육</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">수산물/건어물</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">생선류</a></li>
                                    <li><a href="#">조개류</a></li>
                                    <li><a href="#">생선회</a></li>
                                    <li><a href="#">오징어/낙지</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">간편/냉장/냉동</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">만두/돈까스/떡갈비</a></li>
                                    <li><a href="#">면/떡/국/찌개</a></li>
                                    <li><a href="#">햄/어묵/맛살</a></li>
                                    <li><a href="#">빙과/디저트</a></li>
                                    <li><a href="#">밀키트</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">라면/즉석밥/통조림</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">라면</a></li>
                                    <li><a href="#">즉석식품</a></li>
                                    <li><a href="#">통조림</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">김치</a>
                            </li>
                            <li>
                                <a href="#">스낵/견과/빵/떡</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">스낵</a></li>
                                    <li><a href="#">견과</a></li>
                                    <li><a href="#">빵</a></li>
                                    <li><a href="#">떡</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">밀가루/오일/소스/장류</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">밀가루/설탕/소금/조미료</a></li>
                                    <li><a href="#">장류</a></li>
                                    <li><a href="#">소스류</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">생수/음료/커피/유제품</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">생수</a></li>
                                    <li><a href="#">음료</a></li>
                                    <li><a href="#">커피</a></li>
                                    <li><a href="#">유제품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">건강/홍삼/선식</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">헬스/뷰티</a></li>
                                    <li><a href="#">홍삼/인삼/산삼</a></li>
                                    <li><a href="#">선식/대체식품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">전통주</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">반려동물</a>
                        <ul class="cateList-2dp">
                            <li>
                                <a href="#">강아지</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">사료</a></li>
                                    <li><a href="#">간식</a></li>
                                    <li><a href="#">건강</a></li>
                                    <li><a href="#">위생/배변</a></li>
                                    <li><a href="#">미용/목욕</a></li>
                                    <li><a href="#">급수기/급식기</a></li>
                                    <li><a href="#">하우스/울타리</a></li>
                                    <li><a href="#">이동장</a></li>
                                    <li><a href="#">의류/액세서리</a></li>
                                    <li><a href="#">목줄/인식표/리드줄</a></li>
                                    <li><a href="#">장난감</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">고양이</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">사료</a></li>
                                    <li><a href="#">간식</a></li>
                                    <li><a href="#">건강</a></li>
                                    <li><a href="#">위생/배변</a></li>
                                    <li><a href="#">미용/목욕</a></li>
                                    <li><a href="#">급수기/급식기</a></li>
                                    <li><a href="#">하우스/울타리</a></li>
                                    <li><a href="#">이동장</a></li>
                                    <li><a href="#">의류/액세서리</a></li>
                                    <li><a href="#">목줄/인식표/리드줄</a></li>
                                    <li><a href="#">장난감</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">모바일·디지털</a>
                        <ul class="cateList-2dp">
                            <li>
                                <a href="#">모바일</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">휴대폰</a></li>
                                    <li><a href="#">액세서리</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">가전</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">TV/영상가전</a></li>
                                    <li><a href="#">냉장고/김치냉장고/냉동고</a></li>
                                    <li><a href="#">세탁기</a></li>
                                    <li><a href="#">계절가전</a></li>
                                    <li><a href="#">주방가전</a></li>
                                    <li><a href="#">생활가전</a></li>
                                    <li><a href="#">이미용가전</a></li>
                                    <li><a href="#">건강가전</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">디지털·컴퓨터</a>
                                <ul class="cateList-3dp">
                                    <li><a href="#">게임 · 소프트웨어</a></li>
                                    <li><a href="#">노트북 · 데스크탑</a></li>
                                    <li><a href="#">PC부품 · 주변기기</a></li>
                                    <li><a href="#">저장장치</a></li>
                                    <li><a href="#">모니터</a></li>
                                    <li><a href="#">프린터 · 복합기 · 잉크</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#" class="noDp">여행 · 티켓</a></li>
                    <li><a href="#" class="noDp">렌탈</a></li>
                    <li><a href="#" class="noDp">경품</a></li>
                </ul>
                <div class="logoutWrap">
                   <hr>
                    <a href="#" class="logout">로그아웃 <i class="ri-logout-box-r-line"></i></a>
                </div>
            </div>
        </div>
    </div>
</body>

<script>
$(document).ready(function(){
    $('#write').show();
    $('#list').hide();
    $('.qna').on('click',function(){
        $(this).addClass('active');
        $('.qna').not($(this)).removeClass('active');
    })
    $('#date li a').on('click',function(){
        $(this).addClass('active');
        $('#date li a').not($(this)).removeClass('active');
    })
});
/**
 * 탭 function
 */
function show(num){
    if(num == 1){
        $('#write').show();
        $('#list').hide();
        $('#tap1').addClass('active');
        $('#tap2').removeClass('active');
    } else if (num == 2) {
        $('#write').hide();
        $('#list').show();
        $('#tap1').removeClass('active');
        $('#tap2').addClass('active');
    }
}
</script>
    <c:import url="/layout/footer"/>
<%--<%@ include file="/WEB-INF/views/mobile/layout/footer.jsp" %> --%>