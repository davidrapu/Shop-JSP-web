<%@ page import="java.util.Map" %>
<%@ page import="shop.Product" %>

<jsp:useBean id='basket'
             scope='session'
             class='shop.Basket'
/>

<%
  String empty = request.getParameter("emptyBasket");
  if (empty!=null) {
    basket.clearBasket();
  }
  String item = request.getParameter("addItem");
  if(item != null){
    basket.addItem(item);
  }
  String pid = request.getParameter("pid");
  String action = request.getParameter("action");
  if ("delete".equals(action) && pid != null){
    basket.removeItem(pid);
  }
  if ("increase".equals(action) && pid != null){
    basket.increaseItemQuantity(pid);
  }
  if("decrease".equals(action) && pid != null){
    basket.decreaseItemQuantity(pid);
  }
%>
<%
  if(basket.getItems().isEmpty())
  {
%>
<h1>No items in your basket</h1><%
  }
  else
  {
    %>
    <table id="basket-items" class="table">
      <tr>
        <th></th>
        <th>Picture</th>
        <th>Title</th>
        <th>Quantity</th>
        <th>Price Per Item</th>
      </tr>
      <%
        Map<Product, Integer> items = basket.getItems();
        for (Map.Entry<Product, Integer> entry: items.entrySet()){
      %>
      <tr>
        <td class="delete-button">
          <div class="price-container">
            <a href="basket.jsp?action=delete&pid=<%=entry.getKey().PID%>">
              <img class="delete-image" src="images/icons8-delete-24.png" alt="Delete"/>
            </a>
          </div>
        </td>
        <td><img class="no-edit" src="<%=entry.getKey().thumbnail%>"  alt="<%=entry.getKey().title%>" /></td> <%--Product Image--%>
        <td><%=entry.getKey().title%></td> <%-- Product Name--%>
        <td>
          <div class="buttons-container">
            <a href="basket.jsp?action=decrease&pid=<%=entry.getKey().PID%>"
               id="decrease-quantity-button" class="quantity-change-button"></a>
            <span style="font-size: 20px"><%=entry.getValue()%></span>
            <a href="basket.jsp?action=increase&pid=<%=entry.getKey().PID%>"
               id="increase-quantity-button" class="quantity-change-button"></a>
          </div>
        </td> <%--Product Quantity--%>
        <td> <%--Product Price--%>
            <%=basket.poundConverter(entry.getKey())%>
        </td>
      <tr>
          <%
            }
        %>
    </table>

        <%
        if ( basket.getTotal() > 0) {
            %>
          <div class="middle-container">
            <p> <b>Order total</b> = <%= basket.getTotalString() %>
            <form onsubmit="return submitForm()" id="form1" name="form1" action="order.jsp" method="post">
              Name: <input type="text" name="fname" size="20">
              <input class="bttn" type="submit" value="Place Order" />
            </form>

            <form action="basket.jsp" method="get">
              <input type="hidden" name="emptyBasket" value="yes">
              <input id="emptyBasket" type="submit" value="Empty Basket" />
            </form>
          </div>
        <%
        }
        %>
  <%
  }
  %>
