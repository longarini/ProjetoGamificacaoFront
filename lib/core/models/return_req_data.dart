class ReturnReq {
   int status;
   String msg;
   dynamic data;

   ReturnReq({
    required this.status,
    required this.msg,
    required this.data,
  });
}
