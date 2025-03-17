<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="shop.Product" %>

<jsp:include page="base.jsp"/>
<jsp:useBean id="db" scope="session" class="shop.ShopDB"/>
<jsp:useBean id="basket" scope="session" class="shop.Basket" />


<div id="content">
    <div id="content">
        <div class="middle-container">
            <h1>Search For Art Piece</h1>

            <!-- First Form: Search by Name -->
            <form onsubmit="return verifyForm2()" name="search-form" class="search-form" method="post" action="search.jsp" style="margin-bottom: 30px;">
                <label for="pname">Search by Product Name</label>
                <div id="product-name">
                    <input type="text" name="pname" id="pname" placeholder="Enter product name...">
                </div>

                <div class="search-button-container">
                    <input id="search-submit-button" type="submit" value="Search">
                    <input id="search-clear-button" type="reset" value="Reset">
                </div>
            </form>

            <!-- Second Form: Search by Price Range -->
            <form onsubmit="return verifyPriceForm()" name="price-search-form" class="search-form" method="post" action="search.jsp">
                <label for="minprice">Search by Price Range</label>
                <div style="display: flex; gap: 10px;">
                    <input type="number" min="0" name="minprice" id="minprice" placeholder="Min Price (£)" style="flex: 1;">
                    <input type="number" min="0" name="maxprice" id="maxprice" placeholder="Max Price (£)" style="flex: 1;">
                </div>

                <div class="search-button-container">
                    <input id="price-search-button" type="submit" value="Search">
                    <input id="price-clear-button" type="reset" value="Reset">
                </div>
            </form>

        <%
            String productName = request.getParameter("pname");
            String minPrice = request.getParameter("minprice");
            String maxPrice = request.getParameter("maxprice");

            ArrayList<Product> listOfProducts = null;

            // Handle name search
            if(productName != null && productName.length() >= 3){
                listOfProducts = db.getAllProductsByName(productName);
            }

            // Handle price range search
            if(minPrice != null && !minPrice.isEmpty() && maxPrice != null && !maxPrice.isEmpty()){
                if(productName != null && productName.length() >= 3){
                    // If both name and price range are provided
                    listOfProducts = db.getAllProductsByPriceAndName(productName, Float.parseFloat(minPrice), Float.parseFloat(maxPrice));
                }
                else {
                    // If only price range is provided
                    listOfProducts = db.getAllProductsByPrice(Float.parseFloat(minPrice), Float.parseFloat(maxPrice));
                }
            }
        %>

        <%
            if(listOfProducts != null && !listOfProducts.isEmpty()){
        %>
            <table class="table" style="margin: 30px auto;">
            <tr>
                <th>Title</th>
                <th>Artist</th>
                <th>Price</th>
                <th>Picture</th>
                <th></th>
            </tr>
                <%
                    for (Product p : listOfProducts){
                %>
                <tr>
                    <td><%= p.title %></td>
                    <td><%= p.artist %></td>
                    <td><%= basket.poundConverter(p) %></td>
                    <td><img src="<%= p.thumbnail %>" alt="<%=p.title%>"/></td>
                    <td>
                        <a href="basket.jsp?action=add&pid=<%= p.PID %>">
                            <button class="bttn">Add to Basket</button>
                        </a>
                    </td>
                </tr>
                <%
                        }
                    }else if(productName != null){
                %>
                <h1>NO SUCH PRODUCT WITH THE TEXT: <%= productName%></h1>
                <%
                        }
                %>
            </table>
        </div>
    </div>
</div>