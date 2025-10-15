// supplier-validation.js
document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("supplierForm");
    const submitButton = document.getElementById("submitButton"); // optional in template

    const firstNameInput = document.getElementById("firstName");
    const lastNameInput = document.getElementById("lastName");
    const emailInput = document.getElementById("email");
    const phoneInput = document.getElementById("phoneNumber");
    const addressInput = document.getElementById("address");
    const milkSelect = document.getElementById("typeOfMilk");

    const firstNameError = document.getElementById("firstNameError");
    const lastNameError = document.getElementById("lastNameError");
    const emailError = document.getElementById("emailError");
    const phoneError = document.getElementById("phoneNumberError");
    const addressError = document.getElementById("addressError");
    const milkError = document.getElementById("typeOfMilkError");

    let emailAvailable = false;
    let phoneAvailable = false;

    function safeAddListener(el, event, fn) {
        if (el) el.addEventListener(event, fn);
    }

    // Validate first name
    safeAddListener(firstNameInput, "input", function() {
        if (firstNameInput.value.trim().length < 3) {
            if (firstNameError) { firstNameError.innerText = "First name must be at least 3 characters."; firstNameError.style.color = "red"; }
        } else {
            if (firstNameError) firstNameError.innerText = "";
        }
        updateSubmitButton();
    });

    // Validate last name
    safeAddListener(lastNameInput, "input", function() {
        if (lastNameInput.value.trim().length < 1) {
            if (lastNameError) { lastNameError.innerText = "Last name must be at least 1 character."; lastNameError.style.color = "red"; }
        } else {
            if (lastNameError) lastNameError.innerText = "";
        }
        updateSubmitButton();
    });

    // Email availability check
    safeAddListener(emailInput, "input", function() {
        const email = emailInput.value.trim();
        if (!email) {
            if (emailError) { emailError.innerText = "Email is required"; emailError.style.color = "red"; }
            emailAvailable = false;
            updateSubmitButton();
            return;
        }
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            if (emailError) { emailError.innerText = "Enter a valid email"; emailError.style.color = "red"; }
            emailAvailable = false;
            updateSubmitButton();
            return;
        }

        fetch('/MilkLore/checkSupplierEmail?email=' + encodeURIComponent(email))
            .then(response => response.json())
            .then(isTaken => {
                const taken = (typeof isTaken === "string") ? (isTaken === "true") : isTaken;
                if (taken) {
                    emailAvailable = false;
                    if (emailError) { emailError.innerText = "Email already exists"; emailError.style.color = "red"; }
                } else {
                    emailAvailable = true;
                    if (emailError) emailError.innerText = "";
                }
                updateSubmitButton();
            })
            .catch(() => {
                emailAvailable = false;
                if (emailError) { emailError.innerText = "Unable to check email now"; emailError.style.color = "orange"; }
                updateSubmitButton();
            });
    });

    // Phone availability check
    safeAddListener(phoneInput, "input", function() {
        const phone = phoneInput.value.trim();
        if (!phone) {
            if (phoneError) { phoneError.innerText = "Phone number is required"; phoneError.style.color = "red"; }
            phoneAvailable = false;
            updateSubmitButton();
            return;
        }
        if (!/^[6-9]\d{9}$/.test(phone)) {
            if (phoneError) { phoneError.innerText = "Phone must be 10 digits and start with 6-9"; phoneError.style.color = "red"; }
            phoneAvailable = false;
            updateSubmitButton();
            return;
        }

        fetch('/MilkLore/checkPhone?phoneNumber=' + encodeURIComponent(phone))
            .then(response => response.json())
            .then(isTaken => {
                const taken = (typeof isTaken === "string") ? (isTaken === "true") : isTaken;
                if (taken) {
                    phoneAvailable = false;
                    if (phoneError) { phoneError.innerText = "Phone number already exists"; phoneError.style.color = "red"; }
                } else {
                    phoneAvailable = true;
                    if (phoneError) phoneError.innerText = "";
                }
                updateSubmitButton();
            })
            .catch(() => {
                phoneAvailable = false;
                if (phoneError) { phoneError.innerText = "Unable to check phone now"; phoneError.style.color = "orange"; }
                updateSubmitButton();
            });
    });

    // Validate address
    safeAddListener(addressInput, "input", function() {
        if (addressInput.value.trim().length < 5) {
            if (addressError) { addressError.innerText = "Address must be at least 5 characters."; addressError.style.color = "red"; }
        } else {
            if (addressError) addressError.innerText = "";
        }
        updateSubmitButton();
    });

    // Load milk types dynamically from backend (simple loader)
    function loadMilkTypes(selectElement, selectedValue = "") {
        if (!selectElement) return;
        fetch('/MilkLore/productList')
            .then(response => response.json())
            .then(data => {
                selectElement.innerHTML = '<option value="">Select milk type</option>';
                data.forEach(type => {
                    const option = document.createElement("option");
                    option.value = type;
                    option.textContent = type;
                    if (type === selectedValue) option.selected = true;
                    selectElement.appendChild(option);
                });
            })
            .catch(() => {
                const errEl = document.getElementById(selectElement.id + 'Error') || document.getElementById('typeOfMilkError');
                if (errEl) { errEl.innerText = 'Unable to load milk types'; errEl.style.color = 'orange'; }
            });
    }

    // Validate milk select
    if (milkSelect) {
        milkSelect.addEventListener('change', function() {
            if (milkSelect.value === "") {
                if (milkError) { milkError.innerText = 'Please select milk type.'; milkError.style.color = 'red'; }
            } else {
                if (milkError) milkError.innerText = '';
            }
            updateSubmitButton();
        });
    }

    // Enable/disable submit button based on all checks
    function updateSubmitButton() {
        if (!submitButton) return; // nothing to toggle

        const isValid =
            firstNameInput && firstNameInput.value.trim().length >= 3 &&
            lastNameInput && lastNameInput.value.trim().length >= 1 &&
            emailInput && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value.trim()) && emailAvailable &&
            phoneInput && /^[6-9]\d{9}$/.test(phoneInput.value.trim()) && phoneAvailable &&
            addressInput && addressInput.value.trim().length >= 5 &&
            milkSelect && milkSelect.value !== "";

        submitButton.disabled = !isValid;
    }

    // Initial load
    updateSubmitButton();

    // Load milk types for Add form
    const typeOfMilkSelect = document.getElementById('typeOfMilk');
    if (typeOfMilkSelect) loadMilkTypes(typeOfMilkSelect, "");

    // View supplier buttons
    document.querySelectorAll('.viewSupplierBtn').forEach(button => {
        button.addEventListener('click', function () {
            const get = (id) => document.getElementById(id);
            if (get('modalFirstName')) get('modalFirstName').innerText = this.dataset.firstname || '';
            if (get('modalLastName')) get('modalLastName').innerText = this.dataset.lastname || '';
            if (get('modalEmail')) get('modalEmail').innerText = this.dataset.email || '';
            if (get('modalPhone')) get('modalPhone').innerText = this.dataset.phone || '';
            if (get('modalAddress')) get('modalAddress').innerText = this.dataset.address || '';
            if (get('modalMilk')) get('modalMilk').innerText = this.dataset.milk || '';
        });
    });

    // Delete buttons: show confirm modal and set URL
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const deleteModalEl = document.getElementById('deleteConfirmModal');
    let bsDeleteModal = null;
    if (deleteModalEl && window.bootstrap) bsDeleteModal = new bootstrap.Modal(deleteModalEl);
    document.querySelectorAll('.delete-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            const email = btn.getAttribute('data-email') || '';
            const admin = btn.getAttribute('data-admin') || '';
            const deleteUrl = 'deleteSupplier?email=' + encodeURIComponent(email) + '&admin=' + encodeURIComponent(admin);
            if (confirmDeleteBtn) confirmDeleteBtn.setAttribute('href', deleteUrl);
            if (bsDeleteModal) bsDeleteModal.show();
        });
    });

    // Edit supplier (card edit buttons use .edit-btn)
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function() {
            const id = this.getAttribute('data-id') || '';
            const firstname = this.getAttribute('data-firstname') || '';
            const lastname = this.getAttribute('data-lastname') || '';
            const email = this.getAttribute('data-email') || '';
            const phone = this.getAttribute('data-phone') || '';
            const address = this.getAttribute('data-address') || '';
            const milk = this.getAttribute('data-type') || '';

            const setIf = (id, val) => { const el = document.getElementById(id); if (el) el.value = val; };
            setIf('editSupplierId', id);
            setIf('editFirstName', firstname);
            setIf('editLastName', lastname);
            setIf('editEmail', email);
            setIf('editPhoneNumber', phone);
            setIf('editAddress', address);
            // load milk types into edit select
            loadMilkTypes(document.getElementById('editTypeOfMilk'), milk);
            // show edit modal via bootstrap (modal has id editSupplierModal)
            if (window.bootstrap && document.getElementById('editSupplierModal')) {
                const m = new bootstrap.Modal(document.getElementById('editSupplierModal'));
                m.show();
            }
        });
    });

    // View Bank details
    document.querySelectorAll('.viewSupplierBankBtn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            const setText = (id, val) => { const el = document.getElementById(id); if (el) el.textContent = val || ''; };
            setText('supplierName', btn.getAttribute('data-supplier-name'));
            setText('supplierEmail', btn.getAttribute('data-supplier-email'));
            setText('bankName', btn.getAttribute('data-bank-name'));
            setText('branch', btn.getAttribute('data-bank-branch'));
            setText('accountNumber', btn.getAttribute('data-account-number'));
            setText('ifscCode', btn.getAttribute('data-ifsc-code'));
            setText('accountType', btn.getAttribute('data-account-type'));
        });
    });

    // Edit Bank details (populate form and show modal)
    document.querySelectorAll('.editSupplierBankBtn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            const setIf = (id, val) => { const el = document.getElementById(id); if (el) el.value = val || ''; };
            setIf('editBankSupplierId', btn.getAttribute('data-supplier-id'));
            setIf('editBankSupplierName', btn.getAttribute('data-supplier-name'));
            setIf('editBankSupplierEmail', btn.getAttribute('data-supplier-email'));
            setIf('editBankName', btn.getAttribute('data-bank-name'));
            setIf('editBankBranch', btn.getAttribute('data-bank-branch'));
            setIf('editAccountNumber', btn.getAttribute('data-account-number'));
            setIf('editIfscCode', btn.getAttribute('data-ifsc-code'));
            setIf('editAccountType', btn.getAttribute('data-account-type'));
            if (window.bootstrap && document.getElementById('editSupplierBankDetailsModal')) {
                const m = new bootstrap.Modal(document.getElementById('editSupplierBankDetailsModal'));
                m.show();
            }
        });
    });

    // Edit Bank Details Form Validation
    const editBankForm = document.getElementById('editBankDetailsForm');
    if (editBankForm) {
        editBankForm.addEventListener('input', function (e) {
            let valid = true;
            const setErr = (id, msg) => { const el = document.getElementById(id); if (el) el.textContent = msg; };

            setErr('bankNameError', ''); setErr('bankBranchError', ''); setErr('accountNumberError', ''); setErr('ifscCodeError', ''); setErr('accountTypeError', '');

            const bankName = (document.getElementById('editBankName') || {}).value || '';
            if (!bankName.trim()) { setErr('bankNameError','Bank name is required'); valid = false; }
            else if (bankName.trim().length < 3) { setErr('bankNameError','Bank name should be at least 3 characters'); valid = false; }

            const bankBranch = (document.getElementById('editBankBranch') || {}).value || '';
            if (!bankBranch.trim()) { setErr('bankBranchError','Branch is required'); valid = false; }
            else if (bankBranch.trim().length < 3) { setErr('bankBranchError','Branch name should be at least 3 characters'); valid = false; }

            const accountNumber = (document.getElementById('editAccountNumber') || {}).value || '';
            if (!/^\d{9,18}$/.test(accountNumber.trim())) { setErr('accountNumberError','Enter a valid account number (9-18 digits)'); valid = false; }

            const ifscCode = (document.getElementById('editIfscCode') || {}).value || '';
            if (!/^[A-Z]{4}0[A-Z0-9]{6}$/.test(ifscCode.trim())) { setErr('ifscCodeError','Invalid IFSC code format'); valid = false; }

            const accountType = (document.getElementById('editAccountType') || {}).value || '';
            if (!accountType) { setErr('accountTypeError','Please select an account type.'); valid = false; }

            if (!valid) e.preventDefault();
        });
    }
});