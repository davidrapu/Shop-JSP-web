<%@ page import="shop.Product"%>
<%@ page import="shop.Basket" %>

<jsp:useBean id='db' scope='session' class='shop.ShopDB' />
<jsp:useBean id="basket" scope="session" class="shop.Basket" />

<div class="middle-container">
    <table class="table">
        <tr>
            <th> Title </th> <th> Price </th> <th> Picture </th>
        </tr>
        <%
            for (Product product : db.getAllProducts() ) {
                // now use HTML literals to create the table
                // with JSP expressions to include the live data
                // but this page is unfinished - the thumbnail
                // needs a hyperlink to the product description,
                // and there should also be a way of selecting
                // pictures from a particular artist
        %>
        <tr>
            <td> <%= product.title %> </td>
            <td> <%= product.getPrice(product.price) %> </td>
            <td> <a href = '<%="viewProduct.jsp?pid="+product.PID%>'> <img class="product-table-image" src="<%= product.thumbnail %>"/> </a> </td>
        </tr>
        <%
            }
        %>
    </table>
</div>
