var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require('cors');

var indexRouter = require('./routes/index');
const teamRouter = require('./routes/team');
const projectRouter = require('./routes/project');
const user =require('./routes/user');
const commentRouter = require('./routes/comment');
const issueRouter = require('./routes/issue');
const scoreRouter = require('./routes/score');
const issueStatuRouter = require('./routes/issueState');
const fileRouter = require('./routes/file');
const listRouter = require('./routes/list');



var app = express();
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/team', teamRouter);
app.use('/project', projectRouter);
app.use('/user',user);
app.use('/comment',commentRouter);
app.use('/issue',issueRouter);
app.use('/score',scoreRouter);
app.use('/issuestatu',issueStatuRouter);
app.use('/list',listRouter);
app.use('/file',fileRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
