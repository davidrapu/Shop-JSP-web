<jsp:include page="base.jsp" />
<jsp:useBean id='basket' scope='session' class='shop.Basket'/>
<jsp:useBean id='db' scope='page' class='shop.ShopDB' />

<%
    String custName = request.getParameter("fname");
    if (custName != null && !custName.trim().isEmpty()) {
        db.order(basket, custName);
        basket.clearBasket();
%>
<div id="content">
    <div class="middle-container">
        <h2>Dear <%= custName %>! Thank you for your order.</h2>
        <p>Your order has been successfully placed.</p>
        <a href="products.jsp"><button class="bttn">Continue Shopping</button></a>
    </div>
</div>
<%
} else {
%>
<div id="content">
    <div class="middle-container">
        <h2>Please go back and supply a name</h2>
        <a href="basket.jsp"><button class="bttn">Back to Cart</button></a>
    </div>
</div>
<%
    }
%>