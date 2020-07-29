
module.exports = {
  myFunction: function(event, context) {
    console.log(event);
    return event['data'];
  }
};
