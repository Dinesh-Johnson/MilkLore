document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("collectMilkForm");
  const emailInput = document.getElementById("email");
  const nameInput = document.getElementById("name");
  const phoneInput = document.getElementById("phone");
  const typeSelect = document.getElementById("typeOfMilk");
  const priceInput = document.getElementById("price");
  const quantityInput = document.getElementById("quantity");
  const totalAmountInput = document.getElementById("totalAmount");
  const phoneError = document.getElementById("phoneError");
  const typeError = document.getElementById("typeOfMilkError");
  const submitBtn = document.querySelector('button[type="submit"]');

  const startScanBtn = document.getElementById("startScanBtn");
  const qrScannerContainer = document.getElementById("qrScannerContainer");
  const readerDiv = document.getElementById("reader");
  const stopScanBtn = document.getElementById("stopScanBtn");

  let html5QrCode = null;

  // Utility
  function setButtonState(enabled) {
    if (submitBtn) submitBtn.disabled = !enabled;
  }

  // === Load Milk Types ===
  function loadMilkTypes() {
    fetch("/MilkLore/productList")
      .then(r => r.json())
      .then(data => {
        typeSelect.innerHTML = '<option value="">Select milk type</option>';
        data.forEach(t => {
          const opt = document.createElement("option");
          opt.value = t;
          opt.textContent = t;
          typeSelect.appendChild(opt);
        });
        typeError.textContent = "";
      })
      .catch(() => {
        typeError.textContent = "Unable to load milk types.";
        setButtonState(false);
      });
  }
  loadMilkTypes();

  // === Supplier Fetch by Phone ===
  function fetchSupplierByPhone(phone) {
    if (!phone) return;
    phoneError.textContent = "Checking phone number...";
    phoneError.style.color = "black";
    setButtonState(false);

    fetch(`checkPhone?phoneNumber=${encodeURIComponent(phone)}`)
      .then(r => r.json())
      .then(result => {
        if (result === "true" || result === true) {
          phoneError.textContent = "Phone number found";
          phoneError.style.color = "green";

          fetch(`getSupplierByPhone?phone=${encodeURIComponent(phone)}`)
            .then(r => (r.ok ? r.json() : null))
            .then(data => {
              if (data && data.firstName && data.lastName && data.email) {
                nameInput.value = data.firstName + " " + data.lastName;
                emailInput.value = data.email;
                setButtonState(true);
              } else {
                nameInput.value = "";
                emailInput.value = "";
                phoneError.textContent = "Incomplete supplier details.";
                phoneError.style.color = "red";
                setButtonState(false);
              }
            });
        } else {
          nameInput.value = "";
          emailInput.value = "";
          phoneError.textContent = "Supplier not found. Register first.";
          phoneError.style.color = "red";
          setButtonState(false);
        }
      })
      .catch(() => {
        phoneError.textContent = "Error checking phone number.";
        phoneError.style.color = "red";
      });
  }

  if (phoneInput) {
    phoneInput.addEventListener("blur", () => {
      const p = phoneInput.value.trim();
      if (p) fetchSupplierByPhone(p);
    });
  }

  // === Type & Price Logic ===
  typeSelect.addEventListener("change", function () {
    const type = typeSelect.value;
    if (!type) {
      priceInput.value = "";
      totalAmountInput.value = "";
      setButtonState(false);
      return;
    }

    fetch(`/MilkLore/getMilkPrice?type=${encodeURIComponent(type)}`)
      .then(r => r.json())
      .then(price => {
        if (price !== null) {
          priceInput.value = price.toFixed(2);
          if (quantityInput.value) {
            totalAmountInput.value = (price * quantityInput.value).toFixed(2);
          }
          setButtonState(true);
        } else {
          priceInput.value = "";
          typeError.textContent = "Price not found for type.";
          setButtonState(false);
        }
      })
      .catch(() => {
        priceInput.value = "";
        totalAmountInput.value = "";
        typeError.textContent = "Error fetching price.";
        setButtonState(false);
      });
  });

  quantityInput.addEventListener("input", function () {
    const price = parseFloat(priceInput.value);
    const qty = parseFloat(quantityInput.value);
    if (!isNaN(price) && !isNaN(qty)) {
      totalAmountInput.value = (price * qty).toFixed(2);
      setButtonState(true);
    } else {
      totalAmountInput.value = "";
      setButtonState(false);
    }
  });

  // === QR SCANNER ===
  if (startScanBtn && readerDiv) {
    startScanBtn.addEventListener("click", () => {
      qrScannerContainer.style.display = "block";
      startScanBtn.style.display = "none";


if (typeof Html5Qrcode === "undefined") {
    alert("QR scanner library not loaded. Check script order or internet connection.");
    qrScannerContainer.style.display = "none";
    startScanBtn.style.display = "inline-block";
    return;
  }
      html5QrCode = new Html5Qrcode("reader");

      html5QrCode
        .start(
          { facingMode: "environment" },
          { fps: 10, qrbox: { width: 250, height: 250 } },
          (decodedText) => {
            console.log("Scanned:", decodedText);
            html5QrCode.stop().then(() => {
              qrScannerContainer.style.display = "none";
              startScanBtn.style.display = "inline-block";
            });

            const match = decodedText.match(/ID:(\d+);EMAIL:([^;]+);PHONE:(\d+)/);
            if (match) {
              const supplierId = match[1];
              const supplierEmail = match[2];
              const supplierPhone = match[3];

              document.getElementById("qrId").textContent = supplierId;
              document.getElementById("qrEmail").textContent = supplierEmail;
              document.getElementById("qrPhone").textContent = supplierPhone;

              const qrModal = new bootstrap.Modal(
                document.getElementById("qrResultModal")
              );
              qrModal.show();

              document.getElementById("fillFormBtn").onclick = function () {
                phoneInput.value = supplierPhone;
                emailInput.value = supplierEmail;
                fetchSupplierByPhone(supplierPhone);
              };
            } else {
              alert("Invalid QR format!");
            }
          },
          (errorMessage) => {
            console.warn("QR scan error:", errorMessage);
          }
        )
        .catch((err) => {
          console.error("Camera start failed:", err);
          alert("Camera access failed. Allow camera and use HTTPS/localhost.");
          qrScannerContainer.style.display = "none";
          startScanBtn.style.display = "inline-block";
        });
    });

    stopScanBtn.addEventListener("click", () => {
      if (html5QrCode) {
        html5QrCode.stop().then(() => {
          qrScannerContainer.style.display = "none";
          startScanBtn.style.display = "inline-block";
        });
      }
    });
  }
});
