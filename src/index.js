const axios = require('axios');
const hello = require('./hello');

module.exports.handler = async (event) => {
    console.log('Event: ', event);
    hello();
    return (await axios.get('https://jsonplaceholder.typicode.com/users')).data;
}