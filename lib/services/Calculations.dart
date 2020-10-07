String convertDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

getJsonOfArr(var arrOfObj) {
  var jsn = {};
  for (var obj in arrOfObj) {
    jsn[obj.getKey()] = obj.getJson();
  }
  return jsn;
}
