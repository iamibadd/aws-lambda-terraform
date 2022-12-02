const AWS = require('aws-sdk');
const uuid = require('uuid');

const sqs = new AWS.SQS({
    apiVersion: '2012-11-05',
});


module.exports.handler = async (event) => {
    for (let i = 0; i < 50; i++) {
        const uniqueId = uuid.v4();
        const data = {
            MessageBody: JSON.stringify({name: 'Ibad Shah', age: 69}),
            MessageDeduplicationId: uniqueId,
            MessageGroupId: uniqueId,
            QueueUrl: "https://sqs.us-east-2.amazonaws.com/041321879400/terraform-example-queue.fifo"
        };
        const sendSqsMessage = await sqs.sendMessage(data).promise();
        console.log(`Count: ${i + 1}`, sendSqsMessage.MessageId);
    }
}