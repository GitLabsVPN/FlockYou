const express = require('express');
const app = express();
const PORT = 3000;

// Fake server for MAC list (replace with actual database)
app.get('/update', (req, res) => {
    const macs = [
        "78:8D:71", "3E:4F:0C", "DC:A6:0D", "00:1B:44", "B8:27:39"
    ];
    
    res.json(macs);
});

app.listen(PORT, () => {
    console.log(`FlockYou server running at http://localhost:$PORT`);
});
