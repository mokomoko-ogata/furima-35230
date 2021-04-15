window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = (Math.floor( inputValue * 0.1));
    const addSalesProfit = document.getElementById("profit");
    addSalesProfit.innerHTML = (Math.floor(inputValue - (inputValue * 0.1)));
  });
});