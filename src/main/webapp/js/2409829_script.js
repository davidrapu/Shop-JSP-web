function submitForm() {
    let x = document.forms["form1"]["fname"].value;
    if (x === "") {
        alert("Name is required");
        return false;
    }
    return true;
}