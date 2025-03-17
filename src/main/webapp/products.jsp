<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="base.jsp" />
<%@ page import="shop.Product"%>
<%@ page import="shop.Basket" %>

<jsp:useBean id='db' scope='session' class='shop.ShopDB' />
<jsp:useBean id="basket" scope="session" class="shop.Basket" />

<div id="content">
    <div class="middle-container">
        <table class="table">
            <tr>
                <th>Title</th>
                <th>Price</th>
                <th>Picture</th>
            </tr>
            <%
                for (Product product : db.getAllProducts()) {
            %>
            <tr>
                <td><%= product.title %></td>
                <td><%= product.getPrice(product.price) %></td>
                <td>
                    <a href="viewProduct.jsp?pid=<%= product.PID %>">
                        <img class="product-table-image" src="<%= product.thumbnail %>" alt="<%= product.title %>"/>
                    </a>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</div>