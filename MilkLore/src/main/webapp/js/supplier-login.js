document.addEventListener("DOMContentLoaded", function () {
    // Auto-open OTP modal if JSP set showOtpModal = true
    var otpModalEl = document.getElementById("otpModal");
    if (otpModalEl) {
        var otpModal = new bootstrap.Modal(otpModalEl);

        // If modal is already present in JSP, open it automatically
        if (otpModalEl.dataset.show === "true") {
            otpModal.show();
            startOtpCountdown();
        }

        // Countdown timer element inside modal
        var otpTimer = document.getElementById("otpTimer");
        var countdown;

        function startOtpCountdown() {
            if (!otpTimer) {
                otpTimer = document.createElement("div");
                otpTimer.id = "otpTimer";
                otpTimer.className = "text-muted mt-2 text-center";
                otpModalEl.querySelector(".modal-body").appendChild(otpTimer);
            }

            var timeLeft = 60; // 60 seconds countdown
            otpTimer.textContent = `You can resend OTP in ${timeLeft}s`;

            countdown = setInterval(function () {
                timeLeft--;
                if (timeLeft > 0) {
                    otpTimer.textContent = `You can resend OTP in ${timeLeft}s`;
                } else {
                    clearInterval(countdown);
                    otpTimer.textContent = "You can now resend OTP.";
                }
            }, 1000);
        }

        // Optional: restart countdown when modal is shown manually
        otpModalEl.addEventListener("shown.bs.modal", function () {
            startOtpCountdown();
        });
    }
});
