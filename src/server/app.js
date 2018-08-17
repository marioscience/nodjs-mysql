const express = require('express');
const mysql = require('mysql');
const app = express();

// root password used for now. need custom user
const db_connection = mysql.createConnection({
    host: '0.0.0.0',
    user: 'ibanuser',
    password: 'ibanpassword',
    database: 'ibanonline'
});

app.get('/', (req, res) => {
    let result = db_connection.query('SELECT * FROM transactions', (error, results, fields) => {
        // Create object to have metadata with payload. validation errors, payload and any other information the
        // user needs go here
        let metadata = {
            validation_errors: []
        };

        if (error) throw error;
        let resultJsonString = JSON.stringify(result);
        metadata.data = JSON.parse(resultJsonString);

        res.json(metadata);
    });
});

app.listen(3000, () => console.log('Application listening on port 3000.'));