document.addEventListener("DOMContentLoaded", () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    console.log(inputValue);

    if (inputValue >= 300 && inputValue <= 9999999) {
      const tax = Math.floor(inputValue * 0.10);
      const profit = inputValue - tax;

      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = tax;

      const profitDom = document.getElementById("profit");
      profitDom.innerHTML = profit;
    } else {
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = "0";

      const profitDom = document.getElementById("profit");
      profitDom.innerHTML = "0";
    }
  });
});
