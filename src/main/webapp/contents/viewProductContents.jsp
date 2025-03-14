<%@ page import="shop.Product"%>
<%@ page import="shop.Basket" %>

<jsp:useBean id='db' scope='session' class='shop.ShopDB' />
<jsp:useBean id="basket" scope="session" class="shop.Basket" />

<%
    String pid = request.getParameter("pid");
    String action = request.getParameter("action");
    Product product = db.getProduct(pid);

    if ("add".equals(action) && pid != null) {
        basket.addItem(product);
    }
    // out.println("pid = " + pid);
    if (product == null) {
        // do something sensible!!!
%>
<h1>NO PRODUCT SELECTED</h1>
<%
    }
    else {
%>

<div class="middle-container" align="center">
    <h2> <%= product.title %>  by <%= product.artist %> </h2>
    <div class="solo-product-image-container" >
        <img src="<%= product.fullimage %>" />
    </div>
    <p>Price: <%= basket.poundConverter(product)%></p>
    <p> <%= product.description %> </p>
    <a href="viewProduct.jsp?action=add&pid=<%= product.PID %>">
        <button class="bttn">Add to basket</button>
    </a>
</div>
<%
    }
%>
