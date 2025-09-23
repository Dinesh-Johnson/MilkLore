document.addEventListener('DOMContentLoaded', function() {
    const productForm = document.getElementById('productForm');
    const productList = document.getElementById('productList');
    const loadingSpinner = document.getElementById('loadingSpinner');
    const messageDiv = document.getElementById('message');
    const submitBtn = productForm.querySelector('button[type="submit"]');
    const submitSpinner = document.getElementById('submitSpinner');
    const submitText = document.getElementById('submitText');
    const cancelEditBtn = document.getElementById('cancelEdit');
    const formTitle = document.getElementById('formTitle');
    const imageInput = document.getElementById('productImage');
    const imagePreview = document.getElementById('imagePreview');
    const productCount = document.getElementById('productCount');
    const template = document.getElementById('productCardTemplate');

    const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

    let products = [];

    function showMessage(message, type) {
        messageDiv.textContent = message;
        messageDiv.className = `alert alert-${type} show`;
        setTimeout(() => {
            messageDiv.classList.remove('show');
            setTimeout(() => messageDiv.className = 'alert d-none', 300);
        }, 3000);
    }

    function setLoading(isLoading) {
        loadingSpinner.classList.toggle('d-none', !isLoading);
    }

    async function loadProducts() {
        try {
            setLoading(true);
            const response = await fetch(contextPath + '/products');
            if (!response.ok) throw new Error('Failed to load products');
            products = await response.json();
            renderProducts();
        } catch (error) {
            showMessage('Error loading products: ' + error.message, 'danger');
        } finally {
            setLoading(false);
        }
    }

    function renderProducts() {
        productList.innerHTML = '';
        if (!products || products.length === 0) {
            productList.innerHTML = '<div class="col-12 text-center py-4">No products found</div>';
            productCount.textContent = '0';
            return;
        }

        products.forEach((product, index) => {
            const clone = template.content.cloneNode(true);
            clone.querySelector('.product-title').textContent = product.title;
            clone.querySelector('.product-description').textContent = product.description;
            clone.querySelector('.product-price').textContent = product.price ? '₹' + product.price : '';

            const imgElement = clone.querySelector('.product-image');
            imgElement.src = product.imagePath ? contextPath + '/' + product.imagePath : contextPath + '/images/default-product.png';
            imgElement.alt = product.title;

            clone.querySelector('.edit-btn').addEventListener('click', () => editProduct(index));
            clone.querySelector('.delete-btn').addEventListener('click', () => deleteProduct(product.id));

            productList.appendChild(clone);
        });

        productCount.textContent = products.length;
    }

    function editProduct(index) {
        const product = products[index];
        document.getElementById('productId').value = product.id || '';
        document.getElementById('productTitle').value = product.title || '';
        document.getElementById('productPrice').value = product.price || '';
        document.getElementById('productDescription').value = product.description || '';

        imagePreview.innerHTML = product.imagePath ?
            `<p class="small text-muted mb-1">Current Image:</p>
             <img src="${contextPath}/${product.imagePath}" alt="Current" style="max-height: 100px;" class="img-thumbnail">`
            : '';

        formTitle.textContent = 'Edit Product';
        submitText.textContent = 'Update Product';
        cancelEditBtn.classList.remove('d-none');
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function deleteProduct(id) {
        if (!confirm('Are you sure you want to delete this product?')) return;

        fetch(contextPath + '/deleteProduct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `id=${id}`
        })
        .then(() => {
            showMessage('Product deleted successfully', 'success');
            loadProducts();
        })
        .catch(() => showMessage('Failed to delete product', 'danger'));
    }

    productForm.addEventListener('submit', function(e) {
        e.preventDefault();
        submitBtn.disabled = true;
        submitSpinner.classList.remove('d-none');
        submitText.textContent = 'Saving...';

        const formData = new FormData(productForm);

        fetch(contextPath + '/saveProduct', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Save failed");
            return response.text();
        })
        .then(() => {
            showMessage('Product saved successfully', 'success');
            resetForm();
            loadProducts();
        })
        .catch(() => showMessage('Failed to save product', 'danger'))
        .finally(() => {
            submitBtn.disabled = false;
            submitSpinner.classList.add('d-none');
            submitText.textContent = 'Save Product';
        });
    });

    cancelEditBtn.addEventListener('click', resetForm);

    function resetForm() {
        productForm.reset();
        document.getElementById('productId').value = '';
        imagePreview.innerHTML = '';
        formTitle.textContent = 'Add New Product';
        submitText.textContent = 'Save Product';
        cancelEditBtn.classList.add('d-none');
    }

    imageInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (!file) return;
        const reader = new FileReader();
        reader.onload = function(ev) {
            imagePreview.innerHTML = `
                <p class="small text-muted mb-1">New Image Preview:</p>
                <img src="${ev.target.result}" alt="Preview" style="max-height: 100px;" class="img-thumbnail">
            `;
        };
        reader.readAsDataURL(file);
    });

    loadProducts();
});
