1. 整体结构
- https://izualzhy.cn/glog-source-reading-notes

2. 从LOG(INFO)到写入日志的代码分析
- https://izualzhy.cn/glog-source-reading-notes-whole-process

3. glong 功能扩展 自定义日输出 日志切割
- https://izualzhy.cn/glog-source-reading-notes-extension

4. glog 函数堆栈
- https://izualzhy.cn/glog-source-how-to-get-stack-trace


### 1. 整体结构
- [整体结构](/source/glog-uml.png)
1. LogMessage:日志库的接口部分，在前面已经见到过了。提供了多个构造函数，在析构时调用Flush写入日志数据。也就是每次LOG(xxx)的调用都会生成一个LogMessage对象。同时对象记录了写入日志数据的函数指针：send_method，其中数据的存储和写入日志都委托给LogMessageData完成。

2. LogMessageData：记录日志数据例如文件名、日志消息、日志级别、行号、时间等,同时调用LogDestination的静态方法组织数据的写入。

3. LogStream继承自std::ostream，glog使用时<<流式输入日志的奥秘就来源于LogStream。
4. LogStreamBuf继承自std::streambuf，LogStream使用rdbuf接口设置使用该streambuffer，其中缓冲区buffer为messagetext，由LogMessageData管理。关于std::streambuf可以参考[这篇笔记](https://izualzhy.cn/stream-buffer)

5. LogDestination管理了输出对象，包括两类：默认输出和用户自定义输出，其中默认输出方式的对象为LogDestination本身，对每种日志级别都有一个全局的LogDestination对象负责日志的写入。用户自定义输出对象为LogSink。

6. LogFileObject 通过write方法完成数据真正写入到具体文件，也就是将INFO WARNING等日志真正写入文件的类。

7. LogSink 虚基类，用户可以继承该类并且override send方法，就可以实现自定义的日志输出方式了。
8. Logger LogFileObject的基类，通过继承该类可以修改默认的日志输出方式。


### 2. logfile 流程
1. 日志接收
```
LogMessage::LogMessage(const char* file, int line, LogSeverity severity)
    : allocated_(NULL) {
  Init(file, line, severity, &LogMessage::SendToLog);
}
```


2. Init
```
void LogMessage::Init(const char* file,
                      int line,
                      LogSeverity severity,
                      void (LogMessage::*send_method)()) {
    //堆上分配空间并初始化LogMessageData* data_;
    //初始化内容包括severity, ts, line, filename等
    //日志数据增加logprefix，即severity，ts，线程id(syscall(__NR_gettid))，文件basename
}
成员变量
// Buffer space; contains complete message text.
  char message_text_[LogMessage::kMaxLogMessageLen+1];
  LogStream stream_;
  char severity_;      // What level is this LogMessage logged at?
  int line_;                 // line number where logging call is.
```

3. LogMessage::SendToLog
```
// global flag: never log to file if set.  Also -- don't log to a
  // file if we haven't parsed the command line flags to get the
  // program name.
  if (FLAGS_logtostderr || !IsGoogleLoggingInitialized()) {
    ColoredWriteToStderr(data_->severity_,
                         data_->message_text_, data_->num_chars_to_log_);

    // this could be protected by a flag if necessary.
    LogDestination::LogToSinks(data_->severity_,
                               data_->fullname_, data_->basename_,
                               data_->line_, &data_->tm_time_,
                               data_->message_text_ + data_->num_prefix_chars_,
                               (data_->num_chars_to_log_ -
                                data_->num_prefix_chars_ - 1));
  } else {

    // log this message to all log files of severity <= severity_
    // 写日志到各级别的日志文件
    LogDestination::LogToAllLogfiles(data_->severity_, data_->timestamp_,
                                     data_->message_text_,
                                     data_->num_chars_to_log_);

    LogDestination::MaybeLogToStderr(data_->severity_, data_->message_text_,
                                     data_->num_chars_to_log_);
    LogDestination::MaybeLogToEmail(data_->severity_, data_->message_text_,
                                    data_->num_chars_to_log_);
    //写到用户自定义的sink输出，message_text_去掉了默认添加的logprefix，即severity，ts，线程id，文件basename等
    LogDestination::LogToSinks(data_->severity_,
                               data_->fullname_, data_->basename_,
                               data_->line_, &data_->tm_time_,
                               data_->message_text_ + data_->num_prefix_chars_,
                               (data_->num_chars_to_log_
                                - data_->num_prefix_chars_ - 1));
    // NOTE: -1 removes trailing \n
  }
```

4. LogToAllLogfiles -- LogDestination 
```
// if 走这里
在logging.cc里定义了一个全局的数组LogDestination* LogDestination::log_destinations_[NUM_SEVERITIES];，每种日志级别对应其中一个元素，通过静态函数LogDestination::log_destination访问。

inline LogDestination* LogDestination::log_destination(LogSeverity severity) {
  assert(severity >=0 && severity < NUM_SEVERITIES);
  if (!log_destinations_[severity]) {
    //创建对象
    log_destinations_[severity] = new LogDestination(severity, NULL);
  }
  return log_destinations_[severity];
}
//else 走这里
inline void LogDestination::LogToAllLogfiles(LogSeverity severity,
                                             time_t timestamp,
                                             const char* message,
                                             size_t len) {

  if ( FLAGS_logtostderr ) {           // global flag: never log to file
    ColoredWriteToStderr(severity, message, len);
  } else {
    //从[severity, 0]全部输出，因此我们可以看到warning日志会出现在info日志里。
    for (int i = severity; i >= 0; --i)
      LogDestination::MaybeLogToLogfile(i, timestamp, message, len);
  }
}
```


5. MaybeLogToLogfile
```
inline void LogDestination::MaybeLogToLogfile(LogSeverity severity,
        time_t timestamp,
        const char* message,
        size_t len) {
    //判断是立即flush还是先缓存，logbuflevel默认值=0，
    //各日志级别的定义：const int GLOG_INFO = 0, GLOG_WARNING = 1, GLOG_ERROR = 2, GLOG_FATAL = 3
    //可以看到默认只会对INFO级别缓存,should_flush = false
    const bool should_flush = severity > FLAGS_logbuflevel;
    //从log_destinations_数组获取到该级别对应的LogDestination*
    LogDestination* destination = log_destination(severity);
    //完成日志的写入
    destination->logger_->Write(should_flush, timestamp, message, len);
} 
```

6. logger write 日志写入
```
//加锁，避免同时操作同一文件
  MutexLock l(&lock_);
  //是否需要重新创建日志文件
  if (static_cast<int>(file_length_ >> 20) >= MaxLogSize() ||
      PidHasChanged()) {
  //调用fwrite写入日志
  //判断是否需要fflush落盘
  // See important msgs *now*.  Also, flush logs at least every 10^6 chars,
  // or every "FLAGS_logbufsecs" seconds.
  if ( force_flush ||
       (bytes_since_flush_ >= 1000000) ||
       (CycleClock_Now() >= next_flush_time_) ) {
    FlushUnlocked();
```
