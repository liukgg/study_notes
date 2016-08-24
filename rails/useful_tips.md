开发注意事项
------------------------------------------


1，异常处理，不影响主流程的一些异常应该捕获，日志记录异常信息时，最好纪录下 backtrace.
2，日志记录
3，考虑边界情况；空指针处理 nil;try
4，经常关注newrelic；NewRelic::Agent.notice_error("test error", user_uuid: uuid)
5，调试工具 pry

