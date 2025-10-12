document.addEventListener('DOMContentLoaded', function() {
    const bankName = document.getElementById('bankName');
    const branchName = document.getElementById('branchName');
    const accountNumber = document.getElementById('accountNumber');
    const confirmAccountNumber = document.getElementById('confirmAccountNumber');
    const IFSCCode = document.getElementById('IFSCCode');
    const accountType = document.getElementById('accountType');
    const form = document.getElementById('bankDetailsForm');

    const bankNameError = document.getElementById('bankNameError');
    const branchNameError = document.getElementById('branchNameError');
    const accountNumberError = document.getElementById('accountNumberError');
    const confirmAccountNumberError = document.getElementById('confirmAccountNumberError');
    const IFSCCodeError = document.getElementById('IFSCCodeError');
    const accountTypeError = document.getElementById('accountTypeError');

    // Show toast notification
    function showToast(message, type = 'success') {
        const toastContainer = document.createElement('div');
        toastContainer.className = `toast-container position-fixed bottom-0 end-0 p-3`;

        const toast = document.createElement('div');
        toast.className = `toast show align-items-center text-white bg-${type} border-0`;
        toast.role = 'alert';
        toast.setAttribute('aria-live', 'assertive');
        toast.setAttribute('aria-atomic', 'true');

        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        `;

        toastContainer.appendChild(toast);
        document.body.appendChild(toastContainer);

        // Auto remove toast after 5 seconds
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => {
                document.body.removeChild(toastContainer);
            }, 300);
        }, 5000);
    }

    // Bank Name validation
    bankName.addEventListener('input', () => {
        const value = bankName.value.trim();
        if (value === '') {
            bankNameError.textContent = 'Bank name is required';
            bankName.classList.add('is-invalid');
        } else if (value.length < 3) {
            bankNameError.textContent = 'Bank name should be at least 3 characters';
            bankName.classList.add('is-invalid');
        } else {
            bankNameError.textContent = '';
            bankName.classList.remove('is-invalid');
            bankName.classList.add('is-valid');
        }
    });

    // Branch Name validation
    branchName.addEventListener('input', () => {
        const value = branchName.value.trim();
        if (value.length > 0 && value.length < 3) {
            branchNameError.textContent = 'Branch name should be at least 3 characters';
            branchName.classList.add('is-invalid');
        } else if (value.length >= 3) {
            branchNameError.textContent = '';
            branchName.classList.remove('is-invalid');
            branchName.classList.add('is-valid');
        } else {
            branchNameError.textContent = '';
            branchName.classList.remove('is-invalid');
            branchName.classList.remove('is-valid');
        }
    });

    // Account Number validation
    accountNumber.addEventListener('input', () => {
        const accVal = accountNumber.value.trim();
        if (!/^\d{0,18}$/.test(accVal)) {
            accountNumberError.textContent = 'Only digits allowed (max 18)';
            accountNumber.classList.add('is-invalid');
        } else if (accVal.length < 9 && accVal.length > 0) {
            accountNumberError.textContent = 'Account number should be at least 9 digits';
            accountNumber.classList.add('is-invalid');
        } else if (accVal.length >= 9) {
            accountNumberError.textContent = '';
            accountNumber.classList.remove('is-invalid');
            accountNumber.classList.add('is-valid');
        } else {
            accountNumberError.textContent = '';
            accountNumber.classList.remove('is-invalid');
            accountNumber.classList.remove('is-valid');
        }

        // Match confirm account number dynamically
        if (confirmAccountNumber.value && accVal !== confirmAccountNumber.value) {
            confirmAccountNumberError.textContent = 'Account numbers do not match';
            confirmAccountNumber.classList.add('is-invalid');
        } else if (confirmAccountNumber.value) {
            confirmAccountNumberError.textContent = '';
            confirmAccountNumber.classList.remove('is-invalid');
            confirmAccountNumber.classList.add('is-valid');
        }
    });

    // Confirm Account Number validation
    confirmAccountNumber.addEventListener('input', () => {
        const confirmVal = confirmAccountNumber.value.trim();
        if (confirmVal !== accountNumber.value) {
            confirmAccountNumberError.textContent = 'Account numbers do not match';
            confirmAccountNumber.classList.add('is-invalid');
        } else if (confirmVal) {
            confirmAccountNumberError.textContent = '';
            confirmAccountNumber.classList.remove('is-invalid');
            confirmAccountNumber.classList.add('is-valid');
        } else {
            confirmAccountNumberError.textContent = '';
            confirmAccountNumber.classList.remove('is-invalid');
            confirmAccountNumber.classList.remove('is-valid');
        }
    });

    // IFSC Code validation
    IFSCCode.addEventListener('input', () => {
        const ifscValue = IFSCCode.value.trim().toUpperCase();
        const ifscPattern = /^[A-Z]{4}0[A-Z0-9]{6}$/;

        if (ifscValue.length === 0) {
            IFSCCodeError.textContent = '';
            IFSCCode.classList.remove('is-invalid');
            IFSCCode.classList.remove('is-valid');
        } else if (!ifscPattern.test(ifscValue)) {
            IFSCCodeError.textContent = 'Invalid IFSC format (e.g., HDFC0001234)';
            IFSCCode.classList.add('is-invalid');
        } else {
            IFSCCodeError.textContent = '';
            IFSCCode.classList.remove('is-invalid');
            IFSCCode.classList.add('is-valid');
        }
    });

    // Account Type validation
    accountType.addEventListener('change', () => {
        if (accountType.value === '') {
            accountTypeError.textContent = 'Please select account type';
            accountType.classList.add('is-invalid');
        } else {
            accountTypeError.textContent = '';
            accountType.classList.remove('is-invalid');
            accountType.classList.add('is-valid');
        }
    });

    // Form submission
    form.addEventListener('submit', function(event) {
        event.preventDefault();

        let isValid = true;

        // Validate Bank Name
        if (bankName.value.trim() === '') {
            bankNameError.textContent = 'Bank name is required';
            bankName.classList.add('is-invalid');
            isValid = false;
        }

        // Validate Account Number
        const accVal = accountNumber.value.trim();
        if (accVal === '' || accVal.length < 9 || accVal.length > 18) {
            accountNumberError.textContent = 'Account number must be 9-18 digits';
            accountNumber.classList.add('is-invalid');
            isValid = false;
        }

        // Validate Confirm Account Number
        if (confirmAccountNumber.value !== accountNumber.value) {
            confirmAccountNumberError.textContent = 'Account numbers do not match';
            confirmAccountNumber.classList.add('is-invalid');
            isValid = false;
        }

        // Validate IFSC Code
        const ifscPattern = /^[A-Z]{4}0[A-Z0-9]{6}$/;
        if (!ifscPattern.test(IFSCCode.value.trim().toUpperCase())) {
            IFSCCodeError.textContent = 'Invalid IFSC code format';
            IFSCCode.classList.add('is-invalid');
            isValid = false;
        }

        // Validate Account Type
        if (accountType.value === '') {
            accountTypeError.textContent = 'Please select account type';
            accountType.classList.add('is-invalid');
            isValid = false;
        }

        if (isValid) {
            // Show loading state
            const submitBtn = document.getElementById('submitBtn');
            const originalBtnText = submitBtn.innerHTML;
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...';

            // Simulate form submission (replace with actual form submission)
            setTimeout(() => {
                // Reset button state
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalBtnText;

                // Show success message
                showToast('Bank details updated successfully!', 'success');

                // Submit the form after a short delay
                setTimeout(() => {
                    form.submit();
                }, 1500);

            }, 1000);
        } else {
            // Scroll to the first error
            const firstError = form.querySelector('.is-invalid');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstError.focus();
            }
        }
    });

    // Auto-format IFSC code to uppercase
    IFSCCode.addEventListener('input', function() {
        this.value = this.value.toUpperCase();
    });
});
