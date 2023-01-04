const assert = require('chai').assert;

const inLogs = async (logs, eventname) => {
    const event = logs.find(e => event === eventname);
    assert.exists(event);
}