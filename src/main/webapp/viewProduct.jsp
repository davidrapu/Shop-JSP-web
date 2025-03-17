<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="base.jsp" />
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
    if (product == null) {
%>
<div id="content">
    <div class="middle-container">
        <h1>NO PRODUCT SELECTED</h1>
    </div>
</div>
<%
} else {
%>
<div id="content">
    <div class="middle-container">
        <h2><%= product.title %> by <%= product.artist %></h2>
        <div class="solo-product-image-container">
            <img src="<%= product.fullimage %>" alt="<%= product.title %>"/>
        </div>
        <p><strong>Price:</strong> <%= basket.poundConverter(product) %></p>
        <p><%= product.description %></p>
        <a href="viewProduct.jsp?action=add&pid=<%= product.PID %>">
            <button class="bttn">Add to Basket</button>
        </a>
    </div>
</div>
<%
    }
%>