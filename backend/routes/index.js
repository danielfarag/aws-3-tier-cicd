var express = require('express');
var router = express.Router();


router.get('/health', async (req, res) => {
  res.status(200).json({}); 
});


router.get('/new', async (req, res) => {
  res.status(200).json({
    res: "message test 2"
  }); 
});
module.exports = router;
