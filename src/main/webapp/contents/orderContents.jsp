<jsp:useBean id='basket' scope='session' class='shop.Basket'/>
<jsp:useBean id = 'db' scope='page' class='shop.ShopDB' />

<% String custName = request.getParameter("fname");

    // need to call the appropriate method of db to
    // order the product
    // at present we thank the customer, but then fail
    // to make the order

    // when the order has been made, we should also empty
    // the contents of this shopping basket - but how ???

    if (custName != null) {
        // order the basket of items!
        db.order(basket, custName);
        // then empty the basket
        basket.clearBasket();
%>
<h2> Dear <%= custName %> ! Thank you for your order. </h2>
<%
}
else {
%>
<h2> please go back and supply a name </h2>
<%
    }

%>
