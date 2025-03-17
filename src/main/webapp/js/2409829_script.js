function submitForm() {
    let x = document.forms["form1"]["fname"].value;
    if (x === "") {
        alert("Name is required");
        return false;
    }
    return true;
}

function verifyForm2(){
    let productName = document.forms["search-form"]["pname"].value;

    if (productName.length < 3){
        alert("Name of Art must be at least 3 characters long");
        return false;
    }
    return true
}
function verifyPriceForm(){
    let maxPrice = document.forms["price-search-form"]["maxprice"].value;
    let minPrice = document.forms["price-search-form"]["minprice"].value;

    if(minPrice.length === 0 && maxPrice.length === 0){
        alert("Please enter at least one price value");
        return false;
    }

    if (minPrice.length > 0 && maxPrice.length > 0 && parseFloat(maxPrice) < parseFloat(minPrice)){
        alert("Maximum price cannot be less than Minimum price");
        return false;
    }
    return true;
}