$(document).ready(function () {
    const emailForm = $('#emailForm');
    const otpModal = $('#otpModal');
    const modalEmailInput = $('#modalOtpEmail');
    const loginButton = $('#otpModalForm button[type="submit"]');

    // Add timer element inside modal
    if ($('#otpTimer').length === 0) {
        $('<div id="otpTimer" class="text-center my-2 fw-bold"></div>')
            .insertBefore(loginButton);
    }
    const otpTimer = $('#otpTimer');

    let timerInterval;
    const OTP_DURATION_SECONDS = 5 * 60; // 5 minutes

    function startOtpCountdown() {
        let remaining = OTP_DURATION_SECONDS;
        loginButton.prop('disabled', false);
        otpTimer.css('color', 'green');

        timerInterval = setInterval(function () {
            const minutes = Math.floor(remaining / 60);
            const seconds = remaining % 60;
            otpTimer.text(`OTP expires in ${minutes}:${seconds < 10 ? '0' + seconds : seconds}`);

            // Color change
            if (remaining <= 60) otpTimer.css('color', 'red');
            else if (remaining <= 120) otpTimer.css('color', 'orange');

            remaining--;

            if (remaining < 0) {
                clearInterval(timerInterval);
                otpTimer.text('OTP expired! Please resend OTP.');
                loginButton.prop('disabled', true);

                if ($('#resendOtpBtn').length === 0) {
                    $('<button id="resendOtpBtn" class="btn btn-secondary mt-2 w-100">Resend OTP</button>')
                        .insertAfter(loginButton)
                        .on('click', function () {
                            otpModal.modal('hide');
                            location.reload();
                        });
                }
            }
        }, 1000);
    }

    // Email form submit — now let it actually submit to backend
    emailForm.on('submit', function () {
        const email = $('#supplierEmail').val();
        if (!email) return false;

        // Set hidden email in modal
        modalEmailInput.val(email);

        // The form will submit normally to /supplierLogin
        // After Spring controller responds, the modal can be triggered on page load if needed
    });
});
