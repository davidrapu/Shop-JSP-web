<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Art Shop</title>
        <link rel="stylesheet" href="css/2409829_base.css" />
        <link rel="icon" href="images/icons8-art-48.png" />
        <script defer src="js/2409829_script.js" ></script>
    </head>
    <body>
        <div id="head-container">
            <div id="head">ART SHOP</div>
            <div id="navigation">
                <ul>
                    <li><a href="products.jsp">Products</a></li> |
                    <li><a href="basket.jsp">Cart</a></li> |
                    <li><a href="">Search</a></li>
                </ul>
            </div>
        </div>

        <!-- Dynamic content for each page -->
        <div id="content">
            <%
                String contentPage = (String) request.getAttribute("contentPage");
                if (contentPage != null) {
            %>
            <jsp:include page="<%= contentPage %>" />
            <%
            } else {
            %>
            <jsp:include page="base.jsp" />
            <%
                }
            %>

        </div>
    </body>
</html>
