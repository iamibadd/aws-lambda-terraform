const AWS = require('aws-sdk');
const uuid = require('uuid');
const {
    AWS_REGION,
    AWS_ACCESS_KEY_ID,
    AWS_SECRET_ACCESS_KEY,
    trigger_function_name
} = process.env;

AWS.config.update({region: AWS_REGION, accessKeyId: AWS_ACCESS_KEY_ID, secretAccessKey: AWS_SECRET_ACCESS_KEY});
const sqs = new AWS.SQS({apiVersion: '2012-11-05'});

module.exports.handler = async (event) => {
    const uniqueId = uuid.v4();
    console.log(trigger_function_name);
    console.log(AWS_REGION);
    console.log(AWS_ACCESS_KEY_ID);
    console.log(AWS_SECRET_ACCESS_KEY);
    const data = {
        MessageBody: JSON.stringify({name: 'Ibad Shah', age: 69}),
        MessageDeduplicationId: uniqueId,
        MessageGroupId: uniqueId,
        QueueUrl: "https://sqs.us-east-2.amazonaws.com/041321879400/terraform-example-queue.fifo"
    };
    for (let i = 0; i < 50; i++) {
        let sendSqsMessage = await sqs.sendMessage(data).promise();
        console.log(sendSqsMessage.MessageId);
    }
}

// (async () => {
//     const uniqueId = uuid.v4();
//     console.log(trigger_function_name);
//     console.log(AWS_REGION);
//     console.log(AWS_ACCESS_KEY);
//     console.log(AWS_SECRET_KEY);
//     const data = {
//         MessageBody: JSON.stringify({name: 'Ibad Shah', age: 69}),
//         MessageDeduplicationId: uniqueId,
//         MessageGroupId: uniqueId,
//         QueueUrl: "https://sqs.us-east-2.amazonaws.com/041321879400/terraform-example-queue.fifo"
//     };
//     for (let i = 0; i < 50; i++) {
//         const sendSqsMessage = await sqs.sendMessage(data).promise();
//         console.log(sendSqsMessage.MessageId);
//     }
// })()