String convertDate(DateTime date) {
  return "${date.year}-${date.month}-${date.day}";
}

getJsonOfArr(var arrOfObj) {
  var jsn = {};
  for (var obj in arrOfObj) {
    jsn[obj.getKey()] = obj.getJson();
  }
  return jsn;
}
