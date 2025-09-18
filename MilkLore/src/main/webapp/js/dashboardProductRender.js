document.addEventListener("DOMContentLoaded", function () {
  fetch("json/products.json")
    .then(response => response.json())
    .then(products => {
      const container = document.getElementById("card-carousel-products");
      let html = "";

      // Function to determine items per slide based on screen width
      function getItemsPerSlide() {
        const w = window.innerWidth;
        if (w >= 992) return 3; // Desktop
        if (w >= 576) return 2; // Tablet
        return 1; // Mobile
      }

      const itemsPerSlide = getItemsPerSlide();

      for (let i = 0; i < products.length; i += itemsPerSlide) {
        let chunk = products.slice(i, i + itemsPerSlide);
        html += `<div class="carousel-item ${i === 0 ? "active" : ""}">
                    <div class="d-flex justify-content-center gap-2 flex-wrap">`;
        chunk.forEach(product => {
          html += `
            <img src="${product.image}" alt="${product.name}"
                 style="height:80px; object-fit:cover; border-radius:0.5rem; width: calc(100% / ${itemsPerSlide} - 8px);">
          `;
        });
        html += `</div></div>`;
      }

      container.innerHTML = html;

      // Recalculate carousel on window resize
      window.addEventListener("resize", () => location.reload());
    });
});
