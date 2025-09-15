console.log("✅ Script loaded");

const stateSelect = document.getElementById("state");
const districtSelect = document.getElementById("district");

// Load States & Districts from GitHub JSON
fetch(
  "https://raw.githubusercontent.com/Yash-Gaglani/List-of-States-and-Districts-in-India/main/States%20and%20Districts.json"
)
  .then((res) => res.json())
  .then((data) => {
    // Populate states
    data.forEach((item) => {
      const opt = document.createElement("option");
      opt.value = item.stateName;
      opt.text = item.stateName;
      stateSelect.appendChild(opt);
    });

    // When state changes → load districts from JSON
    stateSelect.addEventListener("change", function () {
      const selectedState = this.value;
      districtSelect.innerHTML = '<option value="">Select District</option>';

      const stateObj = data.find((item) => item.stateName === selectedState);
      if (stateObj) {
        stateObj.districts.forEach((district) => {
          const opt = document.createElement("option");
          // If district is an object, use district.name; if string, use district
          opt.value = typeof district === "string" ? district : district.name;
          opt.text = typeof district === "string" ? district : district.name;
          districtSelect.appendChild(opt);
        });
      }
    });
  })
  .catch((err) => console.error("Error loading state-district data:", err));
