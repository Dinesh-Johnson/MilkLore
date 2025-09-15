document.addEventListener('DOMContentLoaded', function() {
//    const productsUrl = '<c:url value="/json/products.json" />'; // works here
    fetch('json/products.json')
      .then(response => response.json())
      .then(products => {
          const container = document.getElementById('products-container');
          if (!container) return;
          let html = '';
          products.forEach(product => {
              html += `
                   <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                      <div class="product-card">
                          <img src="${product.image}" alt="${product.title}">
                          <div class="card-body">
                              <div class="card-title">${product.title}</div>
                              <div class="card-text">${product.description}</div>
                              <div class="fw-bold text-success">${product.price || ''}</div>
                          </div>
                      </div>
                  </div>
              `;
          });
          container.innerHTML = html;
      });
});