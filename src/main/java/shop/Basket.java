package shop;

import java.util.*;

public class Basket {

    Map<Product, Integer> items;
    ShopDB db;

    public Basket() {
        db = ShopDB.getSingleton();
        items = new HashMap<>();
    }

    /**
     *
     * @return Collection of Product items that are stored in the basket
     *
     * Each item is a product object - need to be clear about that...
     *
     * When we come to list the Basket contents, it will be much more
     * convenient to have all the product details as items in this way
     * in order to calculate that product totals etc.
     *
     */
    public Map<Product, Integer> getItems() {
        return items;
    }

    /**
     * empty the basket - the basket should contain no items after calling this method
     */
    public void clearBasket() {
        // this would clear out the arrayList but the size remains
        items.clear();

        // this would completely clear the old array
//        items = new ArrayList<>();
    }

    /**
     *
     *  Adds an item specified by its product code to the shopping basket
     *
     * @param pid - the product code
     */
    public void addItem(String pid) {

        // need to look the product name up in the
        // database to allow this kind of item adding...
        addItem( db.getProduct( pid ) );

    }

    public void addItem(Product p) {

        /*
        Basically, check the map if the item is there already. if it is, then just increase the count
        if it's not there then add it.
         */

        // ensure that we don't add any nulls to the item list
        if (p != null ) {
            // Directly update the count in the map
            if (items.containsKey(p)) {
                items.put(p, items.get(p) + 1);
            }else{
                items.put(p, 1);
            }
        }
//        System.out.println(items);
//        System.out.println("called addItem");


    }

    /**
     *
     * @return the total value of items in the basket in pence
     */
    public int getTotal() {
        // iterate over the set of products
        int total = 0;
        for ( Map.Entry<Product, Integer> entry : items.entrySet() ) {
            total += (entry.getKey().price * entry.getValue());
        }
        // return the total
        return total;
    }

    /**
     *
     * @return the total value of items in the basket as
     * a pounds and pence String with exactly two decimal places - hence
     * suitable for inclusion as a total in a web page
     */
    public String getTotalString() {
//        System.out.println("called getTotalString");
        int total = getTotal();
        float valueInPounds = total / 100f;
//        System.out.println(valueInPounds);
		return String.format("£%.2f", valueInPounds);
//        return "Dog";
    }

    public String poundConverter(Product p) {
        float valueInPounds = 0;
        if (p != null) {
            valueInPounds = p.price / 100f;
            return  String.format("£%.2f", valueInPounds);
        }
        return null;
    }

    public void removeItem(String pid) {
        Product productToRemove = getProductById(pid);

        // Then remove it outside the loop
        if (productToRemove != null) {
            items.remove(productToRemove);
//            System.out.println(items);
//            System.out.println("Deleted");
        }
    }

    public Product getProductById(String pid) {
        /*
            Method to return the product based of its ID from the basket
         */
        Product productToReturn = null;

        for (Map.Entry<Product, Integer> entry : items.entrySet()) {
            if (entry.getKey().PID.equals(pid)) {
                productToReturn = entry.getKey();
            }
        }
        return productToReturn;
    }
    public void increaseItemQuantity(String pid) {
        /*
            Increase an item quantity by 1
         */
        Product productToIncrease = getProductById(pid);
        Integer newValue = items.get(productToIncrease);
        items.replace(productToIncrease, newValue + 1);
    }
    public void decreaseItemQuantity(String pid) {
        /*
            Reduces the value of each product item quantity
         */
        Product productToDecrease = getProductById(pid);
        Integer newValue = items.get(productToDecrease)-1;
        if  (newValue > 0) {
            items.replace(productToDecrease,newValue);
        }else{
            items.remove(productToDecrease);
        }
    }

}
