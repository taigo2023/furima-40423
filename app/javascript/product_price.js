document.addEventListener("turbo:load", () => {
  const updatePrices = () => {
    const priceInput = document.getElementById("item-price");
    if (!priceInput) return; //

    const calculatePrices = () => {
      const inputValue = parseInt(priceInput.value, 10);

      if (!isNaN(inputValue) && inputValue >= 300 && inputValue <= 9999999) {
        const tax = Math.floor(inputValue * 0.10);
        const profit = inputValue - tax;

        const addTaxDom = document.getElementById("add-tax-price");
        addTaxDom.textContent = tax.toLocaleString();

        const profitDom = document.getElementById("profit");
        profitDom.textContent = profit.toLocaleString();
      } else {
        const addTaxDom = document.getElementById("add-tax-price");
        addTaxDom.textContent = "0";

        const profitDom = document.getElementById("profit");
        profitDom.textContent = "0";
      }
    };

    priceInput.addEventListener("input", calculatePrices);

    calculatePrices();
  };

  updatePrices();

  document.addEventListener("ajax:success", (event) => {
    if (event.target.id === "your-form-id") {
      updatePrices();
    }
  });

  document.addEventListener("turbo:before-stream-render", updatePrices);
  document.addEventListener("turbo:submit-end", updatePrices);
});

document.addEventListener("turbo:render", () => {
  const updatePrices = () => {
    const priceInput = document.getElementById("item-price");
    if (!priceInput) return;

    const calculatePrices = () => {
      const inputValue = parseInt(priceInput.value, 10);

      if (!isNaN(inputValue) && inputValue >= 300 && inputValue <= 9999999) {
        const tax = Math.floor(inputValue * 0.10);
        const profit = inputValue - tax;

        const addTaxDom = document.getElementById("add-tax-price");
        addTaxDom.textContent = tax.toLocaleString();

        const profitDom = document.getElementById("profit");
        profitDom.textContent = profit.toLocaleString();
      } else {
        const addTaxDom = document.getElementById("add-tax-price");
        addTaxDom.textContent = "0";

        const profitDom = document.getElementById("profit");
        profitDom.textContent = "0";
      }
    };

    priceInput.addEventListener("input", calculatePrices);

    calculatePrices();
  };

  updatePrices();

  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.textContent = "";

  const profitDom = document.getElementById("profit");
  profitDom.textContent = "";
});
