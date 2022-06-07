const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const bodyParser = require('body-parser');

const router = require('./Routes/HandlerRoutes').router;



const app = express();
const reqOptions = {
    inflate: true,
    limit: '50mb',
    type: ['text/plain', 'application/json']
};

async function config() {
    app.set('port', process.env.PORT || 3001);
    app.use(morgan('dev'));
    app.use(cors());
    app.use(bodyParser.raw(reqOptions));
    app.use(express.urlencoded({ extended: false }));
}

function routesConfig() {
    app.use('/api', router);
}

async function start() {
    config();
    routesConfig();

    app.listen(app.get('port'), () => {
        console.log('Server on Port: ' + app.get('port'));
    });
}

start();
