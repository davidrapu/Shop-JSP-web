
package shop;

import java.sql.*;
import java.util.Collection;
import java.util.LinkedList;
import java.util.Iterator;
import java.util.Map;

public class ShopDB {

    Connection con;
    static int nOrders = 0;
    static ShopDB singleton;

    // if you are using your own machine you may need to change the URL in the
    // getConnection call; if you do so you must restore it to the original version
    // before submitting the assignment
    public ShopDB() {
        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver");
            System.out.println("loaded class");
//            con = DriverManager.getConnection("jdbc:hsqldb:file:\\tomcat\\webapps\\ass2\\ShopDB", "sa", "");
            con = DriverManager.getConnection("jdbc:hsqldb:file:C:\\Program Files\\Apache Software Foundation\\Tomcat 11.0\\webapps\\ass2\\ShopDB", "sa", "");
            System.out.println("created con");
        } catch (Exception e) {
            System.out.println("Exception: " + e);
        }
    }

    public static ShopDB getSingleton() {
        if (singleton == null) {
            singleton = new ShopDB();
        }
        return singleton;
    }

    public Collection<Product> getAllProducts() {
        return getProductCollection("Select * from Product");
    }

    public Product getProduct(String pid) {
        try {
            // re-use the getProductCollection method
            // even though we only expect to get a single Product Object
            String query = "Select * from Product where PID = '" + pid + "'";
            Collection<Product> c = getProductCollection( query );
            Iterator<Product> i = c.iterator();
            return i.next();
        }
        catch(Exception e) {
            // unable to find the product matching that pid
            return null;
        }
    }

    public Collection<Product> getProductCollection(String query) {
        LinkedList<Product> list = new LinkedList<Product>();
        try {
            Statement s = con.createStatement();

            ResultSet rs = s.executeQuery(query);
            while (rs.next()) {
                Product product = new Product(
                        rs.getString("PID"),
                        rs.getString("Artist"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getInt("price"),
                        rs.getString("thumbnail"),
                        rs.getString("fullimage")
                );
                list.add(product);
            }
//            System.out.println("Successfully found " + list.size() + " products");
            return list;
        }
        catch(Exception e) {
            System.out.println( "Exception in getProductCollection(): " + e );
            return null;
        }
    }

    public void order(Basket basket , String customerName) {
        try {
            // create a unique order id
            String orderId = System.currentTimeMillis() + ":" + nOrders++;

            // iterate over the basket of contents
            Map<Product, Integer> i = basket.getItems();
            for (Map.Entry<Product, Integer> entry : i.entrySet()) {
                Product product = entry.getKey();
                int quantity = entry.getValue();

                // Place the order for each product with the correct quantity
                order(con, product, orderId, customerName, quantity);
            }
        }
        catch(Exception e) {
            e.printStackTrace();
        }

    }

    private void order(Connection con, Product p, String orderId, String customerName, int quantity) throws Exception {
        // method to add the order to the db
        try {
            String add = "INSERT INTO ORDERS (PID, OrderID, CustomerName, Quantity, Price) VALUES (?, ?, ?, ?, ?)";

            // Using PreparedStatement to avoid SQL injection
            PreparedStatement ps = con.prepareStatement(add);

            // Setting the values for the placeholders (?)
            ps.setString(1, p.PID); // Assuming PID is an integer
            ps.setString(2, orderId);
            ps.setString(3, customerName);
            ps.setInt(4, quantity); // Quantity set to 1
            ps.setDouble(5, p.price); // Assuming price is a double

            // Execute the update
            int i = ps.executeUpdate();

            if (i == -1) {
                System.out.println("Insert error");
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



}
