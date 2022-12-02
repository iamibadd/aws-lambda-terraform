const axios = require('axios');

module.exports.handler = async (event) => {
    console.log('Event: ', event);
    return (await axios.get('https://jsonplaceholder.typicode.com/users')).data;
}