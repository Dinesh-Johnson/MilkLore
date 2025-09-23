document.addEventListener('DOMContentLoaded', function() {
    fetch('json/products.json')
        .then(response => response.json())
        .then(products => {
            const container = document.getElementById('products-container');
            if (!container) return;

            let html = '';
            products.forEach(product => {
                const imgSrc = product.imagePath && product.imagePath !== ''
                               ? product.imagePath
                               : 'images/default-product.png'; // fallback image

                html += `
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                        <div class="product-card card h-100 shadow-sm">
                            <img src="${imgSrc}" alt="${product.title}" class="card-img-top" style="height:200px; object-fit:cover;">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${product.title}</h5>
                                <p class="card-text text-muted">${product.description}</p>
                                <p class="fw-bold text-success mt-auto">${product.price || ''}</p>
                            </div>
                        </div>
                    </div>
                `;
            });

            container.innerHTML = html;
        })
        .catch(error => {
            console.error('Error loading products:', error);
        });
});
