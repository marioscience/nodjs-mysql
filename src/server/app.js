const express = require('express');
const mysql = require('mysql');
const app = express();

// root password used for now. need custom user

// As the app grows the project needs folders/files ie. for configuration, controllers, models.
// for the current project this is adequate.

// also the configuration for the database connection can be added in environemnt variables in the Dockerfile.
// the actual credentials need to be hidden
const dbConnection = mysql.createConnection({
    host: 'mysql_db',
    user: 'ibanuser',
    password: 'ibanpassword',
    database: 'ibanonline'
});

// Simulating logged in user id. This should come from session data in the database. but I hope you didn't expect me to
// implement a login system.  ideally, there would be middleware authenticating the user and putting the current userid
// in the request object. or other more complex mechanism for user management. This is also purposely a global variable.
let currentUserId = 1;


// Return all transactions by default. use query params to get date ranges, amount ranges or ordering
app.get('/transactions', (req, res) => {
    let baseQuery = 'SELECT * FROM transactions';
    let filterQuery = determineFilterQuery(req.query);

    let authCondition = ' WHERE';

    if (filterQuery) {
        baseQuery = baseQuery + ' WHERE';
        authCondition = ' AND';
    }

    // Authentication could be done in a middleware where the user_id could be retreived from current session and
    // appended to query
    dbConnection.query(baseQuery + filterQuery + authCondition + ' user_id = ' + currentUserId + ';', (error, results) => {
        // Create object to have metadata with payload. validation errors, payload and any other information the
        // user needs go here
        let metadata = {
            validationErrors: []
        };

        if (error) {
            console.log(error);
            throw error;
        }

        let resultJsonString = JSON.stringify(results);
        metadata.data = JSON.parse(resultJsonString);
        metadata.count = results.length;

        res.json(metadata);
    });
});

function determineFilterQuery (params) {
    let filterQuery = '';

    // if dateRange option is passed filter by date
    switch (params.dateRange) {
        case 'lastDay':
            filterQuery = ' transaction_date >= ( CURDATE() - INTERVAL 1 DAY )';
            break;
        case 'lastThreeDays':
            filterQuery = ' transaction_date >= ( CURDATE() - INTERVAL 3 DAY )';
            break;
        case 'lastWeek':
            filterQuery = ' transaction_date >= ( CURDATE() - INTERVAL 1 WEEK )';
            break;
        case 'lastMonth':
            filterQuery = ' transaction_date >= ( CURDATE() - INTERVAL 1 MONTH )';
            break;
    }

    if (params.amountGt) {
        if (filterQuery) {
            filterQuery = filterQuery + ' AND';
        }

        filterQuery = filterQuery + ' amount > ' + params.amountGt;
    } else if (params.amoutLt) {
        if (filterQuery) {
            filterQuery = filterQuery + ' AND';
        }

        filterQuery = filterQuery + ' amount < ' + params.amountLt;
    } else if (params.amountEq) {
        if (filterQuery) {
            filterQuery = filterQuery + ' AND';
        }

        filterQuery = filterQuery + ' amount =' + params.amountEq;
    }

    return filterQuery;
}

app.listen(3000, () => console.log('Application listening on port 3000.'));