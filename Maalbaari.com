<!DOCTYPE html>
<html lang="so">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Maalbaari Exchange</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 480px;
      margin: 20px auto;
      padding: 0 15px;
      background-color: #f9fff9;
      color: #1b4d1b;
    }
    h1, h2 {
      color: #0b3d0b;
    }
    .form-section {
      background: #e6f0e6;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 25px;
      box-shadow: 0 0 10px rgba(27, 77, 27, 0.15);
    }
    label {
      display: block;
      margin: 15px 0 5px;
    }
    input, select, button {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: 1.5px solid #2b7a2b;
      font-size: 1rem;
    }
    button {
      background-color: #2b7a2b;
      color: white;
      font-weight: bold;
      margin-top: 20px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #1a4d1a;
    }
    #confirmation {
      background: #d9f2d9;
      border: 1px solid #1a4d1a;
      padding: 15px;
      border-radius: 6px;
      margin-top: 20px;
      font-weight: bold;
    }
    ul {
      padding-left: 20px;
    }
    details {
      background: #f0f9f0;
      margin: 10px 0;
      padding: 10px;
      border-radius: 6px;
      border: 1px solid #c5e0c5;
    }
  </style>
</head>
<body>

<header>
  <h1>Maalbaari Exchange</h1>
  <p>Bedel lacagaha MoneyGo, Zaad, iyo eDahab si toos ah</p>
</header>

<main>
  <section class="form-section" id="step1">
    <h2>Foomka Bedelka</h2>
    <form id="exchange-form">
      <label for="service">Dooro Adeeg:</label>
      <select id="service" name="service" required>
        <option value="" disabled selected>-- Doorasho --</option>
        <option value="moneygo-zaad">MoneyGo ➔ Zaad</option>
        <option value="moneygo-edahab">MoneyGo ➔ eDahab</option>
      </select>

      <label for="number">Lambarka:</label>
      <input type="tel" id="number" name="number" placeholder="0634500408" pattern="[0-9]{8,15}" required />

      <label for="amount">Lacagta:</label>
      <input type="number" id="amount" name="amount" placeholder="1000" min="1" required />

      <button type="submit">Xaqiiji Lacagta</button>
    </form>
  </section>

  <section class="form-section" id="step2" style="display:none;">
    <h2>Faahfaahinta & Xaqiijinta</h2>
    <p id="details"></p>
    <p id="code-text"></p>
    <button id="confirm-btn">Soo Saar Habka Dirista</button>
    <button id="edit-btn" style="background:#bbb; color:#333; margin-top:10px;">Wax Ka Bedel</button>
  </section>

  <section class="form-section" id="rates">
    <h2>Heerarka Sarrifka</h2>
    <ul>
      <li>1 MoneyGo ➔ Zaad = 880 dolor</li>
      <li>1 MoneyGo ➔ eDahab = 110 dolor</li>
    </ul>
  </section>

  <section class="form-section faq">
    <h2>FAQ - Su'aalaha Badan La Isweydiiyo</h2>
    <details>
      <summary>Sidee lacagta loo diraa?</summary>
      <p>Waxaad geli lambarka, xulashada adeegga, iyo lacagta. Foomka ayaa ku siin doona code si aad u dirto.</p>
    </details>
    <details>
      <summary>Imisa wakhti ayuu qaataa?</summary>
      <p>Lacagta si toos ah ayaa u dhacda, haddii network-ka uusan jirin cilad.</p>
    </details>
  </section>
</main>

<footer style="text-align:center; margin: 30px 0;">
  <p>&copy; 2025 Maalbaari Exchange | <a href="mailto:support@maalbaari.com">support@maalbaari.com</a></p>
</footer>

<script>
  const form = document.getElementById("exchange-form");
  const step1 = document.getElementById("step1");
  const step2 = document.getElementById("step2");
  const detailsP = document.getElementById("details");
  const codeText = document.getElementById("code-text");
  const confirmBtn = document.getElementById("confirm-btn");
  const editBtn = document.getElementById("edit-btn");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const service = form.service.value;
    const number = form.number.value.trim();
    const amount = parseFloat(form.amount.value);

    if (!service || !number || !amount || amount <= 0) {
      alert("Fadlan buuxi xogta saxda ah.");
      return;
    }

    let serviceName = "";
    let code = "";
    let rate = 0;

    if(service === "moneygo-zaad") {
      serviceName = "MoneyGo ➔ Zaad";
      rate = 880;
      code = `*110*638888305*${amount}#`;
    } else if(service === "moneygo-edahab") {
      serviceName = "MoneyGo ➔ eDahab";
      rate = 110;
      code = `*110*658836754*${amount}#`;
    }

    const convertedAmount = amount * rate;

    detailsP.innerHTML = `
      Adeeg: <strong>${serviceName}</strong><br />
      Lambarka: <strong>${number}</strong><br />
      Lacagta aad dooneysid inaad beddesho: <strong>${amount.toLocaleString()}</strong> MoneyGo<br />
      Lacagta aad heli doontid: <strong>${convertedAmount.toLocaleString()}</strong> SOS
    `;

    codeText.innerHTML = `Fadlan wac codekan: <strong>${code}</strong>`;

    step1.style.display = "none";
    step2.style.display = "block";
  });

  confirmBtn.addEventListener("click", () => {
    alert("Waad xaqiijisay codsigaaga. Fadlan wac code-ka la bixiyay si aad u dirto lacagta.");
  });

  editBtn.addEventListener("click", () => {
    step2.style.display = "none";
    step1.style.display = "block";
  });
</script>

</body>
</html>
