// product-price.js
// Robust delegated handlers for product add/edit/delete on the Products page
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('productPriceForm');
    const productName = document.getElementById('productName');
    const price = document.getElementById('price');
    const productNameError = document.getElementById('productNameError');
    const priceError = document.getElementById('priceError');

    // Helper to safely set element value
    function safeSetValue(id, value) {
        const el = document.getElementById(id);
        if (!el) return;
        el.value = (value == null) ? '' : value;
    }

    // Clear validation messages on input
    if (productName) {
        productName.addEventListener('input', () => {
            if (productNameError) productNameError.innerText = '';
            const name = productName.value.trim();
            if (!name) return;
            if (name.length < 3) return;
            // remote uniqueness check (non-blocking)
            fetch('/MilkLore/checkProductName?productName=' + encodeURIComponent(name))
                .then(r => r.json())
                .then(data => {
                    if (!productNameError) return;
                    productNameError.innerText = (data === true || data === 'true') ? 'Product name already exists.' : '';
                })
                .catch(() => {});
        });
    }

    if (price) {
        price.addEventListener('input', () => { if (priceError) priceError.innerText = ''; });
    }

    if (form) {
        form.addEventListener('submit', function(e) {
            let valid = true;
            const pn = productName ? productName.value.trim() : '';
            if (!pn || pn.length < 3 || (productNameError && productNameError.innerText !== '')) valid = false;

            const pv = price ? price.value.trim() : '';
            const parsed = pv === '' ? NaN : parseFloat(pv);
            if (isNaN(parsed) || parsed <= 0) {
                if (priceError) priceError.innerText = 'Enter a valid price greater than 0.';
                valid = false;
            } else if (priceError) {
                priceError.innerText = '';
            }

            if (!valid) e.preventDefault();
        });
    }

    // Delegated click handler for edit and delete actions (works for table buttons or dropdown items)
    document.body.addEventListener('click', function(e) {
        const target = e.target.closest('.editProductBtn, .deleteProductItem');
        if (!target) return;
        e.preventDefault();

        // --- Edit action ---
        if (target.classList.contains('editProductBtn')) {
            // Prefer dataset, fall back to attributes
            const id = target.dataset.id || target.getAttribute('data-id') || '';
            const name = target.dataset.name || target.getAttribute('data-name') || '';
            let priceVal = target.dataset.price || target.getAttribute('data-price') || '';
            const type = target.dataset.type || target.getAttribute('data-type') || '';

            // sanitize price: strip any non-numeric except dot and minus
            if (typeof priceVal === 'string') {
                priceVal = priceVal.replace(/[^0-9.\-]/g, '').trim();
            }

            safeSetValue('editProductId', id);
            safeSetValue('editProductName', name);
            safeSetValue('editProductPrice', priceVal);
            // If editProductType is a select, set its value; otherwise set as input
            const editTypeEl = document.getElementById('editProductType');
            if (editTypeEl) editTypeEl.value = type || editTypeEl.value || '';

            // Clear any previous validation messages in edit modal if present
            const editNameErr = document.getElementById('editProductNameError');
            const editPriceErr = document.getElementById('editProductPriceError');
            if (editNameErr) editNameErr.innerText = '';
            if (editPriceErr) editPriceErr.innerText = '';

            // Show the modal via Bootstrap API if available
            const editModalEl = document.getElementById('editProductModal');
            try { if (window.bootstrap && editModalEl) new bootstrap.Modal(editModalEl).show(); } catch (err) { /* ignore */ }
            // focus the name input for convenience
            const nameInput = document.getElementById('editProductName');
            if (nameInput) nameInput.focus();
            return;
        }

        // --- Delete action ---
        if (target.classList.contains('deleteProductItem')) {
            const url = target.dataset.deleteUrl || target.getAttribute('data-delete-url') || '#';
            const confirmBtn = document.getElementById('confirmDeleteBtn');
            if (confirmBtn) confirmBtn.setAttribute('href', url);
            // Let Bootstrap show the modal via data-bs attributes or show it defensively
            const delModalEl = document.getElementById('deleteConfirmModal');
            try { if (window.bootstrap && delModalEl) new bootstrap.Modal(delModalEl).show(); } catch (err) { /* ignore */ }
            return;
        }
    });
});