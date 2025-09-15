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
                      <div class="card">
                          <img src="${product.image}" class="card-img-top" alt="${product.title}">
                          <div class="card-body">
                              <h5 class="card-title">${product.title}</h5>
                              <p class="card-text">${product.description}</p>
                              <p class="card-text fw-bold text-success">${product.price || ''}</p>
                          </div>
                      </div>
                  </div>
              `;
          });
          container.innerHTML = html;
      });
});