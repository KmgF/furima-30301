

function calculation(){
  const price_num = document.getElementById("item-price");
    price_num.addEventListener('keyup',function(){
      const price = document.getElementById("item-price").value;
      const TaxPrice = document.getElementById("add-tax-price");
      const Profit = document.getElementById("profit");
      const tax_price = price*0.1
      const profit = price-tax_price
      const HTMLPrice = `
      ${parseInt(tax_price,0)}`
      const HTMLProfit = `
      ${parseInt(profit)}`
      TaxPrice.innerHTML = HTMLPrice
      Profit.innerHTML = HTMLProfit
    });
};

window.addEventListener('load',calculation);