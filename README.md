<!DOCTYPE html>
<html lang="so">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Maalbaari Exchange - USDT to MoneyGo</title>
<style>
  body { font-family: Arial, sans-serif; max-width: 480px; margin: 20px auto; padding: 0 15px; background:#f9fff9; color:#1b4d1b;}
  h1,h2 { color:#0b3d0b;}
  label { display:block; margin:15px 0 5px;}
  input, select { width:100%; padding:10px; border-radius:5px; border:1.5px solid #2b7a2b; font-size:1rem;}
  button { background-color:#2b7a2b; color:#fff; font-weight:bold; margin-top:20px; cursor:pointer; padding:10px; border:none; border-radius:5px; }
  button:hover { background-color:#1a4d1a;}
  .result { margin-top:20px; padding:15px; background:#d9f2d9; border-radius:6px; border:1px solid #1a4d1a; font-weight:bold;}
</style>
</head>
<body>

<h1>Maalbaari Exchange</h1>
<p>Bedel USDT lacag kale (Zaad, eDahab, MoneyGo)</p>

<form id="exchange-form">
  <label for="send-currency">Lacagta aad direyso (Send):</label>
  <select id="send-currency" name="send-currency" required>
    <option value="usdt" selected>USDT</option>
    <!-- Halkan waxaad ku dari kartaa lacag kale haddii rabto -->
  </select>

  <label for="receive-currency">Lacagta aad rabto (Receive):</label>
  <select id="receive-currency" name="receive-currency" required>
    <option value="" disabled selected>Dooro</option>
    <option value="zaad">Zaad</option>
    <option value="edahab">eDahab</option>
    <option value="moneygo">MoneyGo</option>
  </select>

  <label for="send-amount">Qaddarka lacagta aad direyso:</label>
  <input type="number" id="send-amount" name="send-amount" placeholder="1000" min="1" required />

  <button type="submit">Xisaabi Lacagta La Helayo</button>
</form>

<div class="result" id="result" style="display:none;"></div>

<script>
  const form = document.getElementById('exchange-form');
  const resultDiv = document.getElementById('result');

  // Heerarka sarrifka tusaale ahaan
  const rates = {
    'usdt-zaad': 1,       // 1 USDT = 1 Zaad (tusaale)
    'usdt-edahab': 1,     // 1 USDT = 1 eDahab (tusaale)
    'usdt-moneygo': 1     // 1 USDT = 1 MoneyGo (tusaale)
  };

  form.addEventListener('submit', function(e) {
    e.preventDefault();

    const sendCurrency = form['send-currency'].value;
    const receiveCurrency = form['receive-currency'].value;
    const sendAmount = parseFloat(form['send-amount'].value);

    if(!sendCurrency || !receiveCurrency || !sendAmount || sendAmount <= 0) {
      alert('Fadlan buuxi xogta saxda ah');
      return;
    }

    const key = sendCurrency + '-' + receiveCurrency;
    const rate = rates[key];

    if(rate === undefined) {
      alert('Isbedelka lacagtaan lama heli karo');
      return;
    }

    const receiveAmount = sendAmount * rate;

    resultDiv.style.display = 'block';
    resultDiv.innerHTML = `
      Waxaad direysaa: <strong>${sendAmount.toLocaleString()}</strong> ${sendCurrency.toUpperCase()}<br>
      Waxaad heli doontaa: <strong>${receiveAmount.toLocaleString()}</strong> ${receiveCurrency.charAt(0).toUpperCase() + receiveCurrency.slice(1)}<br>
      Heerka sarrifka: 1 ${sendCurrency.toUpperCase()} = ${rate} ${receiveCurrency.charAt(0).toUpperCase() + receiveCurrency.slice(1)}
    `;
  });
</script>

</body>
</html>
