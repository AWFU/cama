$("#districts_select").empty()
  .append("<option value=''>-- 請選擇 --</option>")
  .append("<%= escape_javascript(render(:partial => @districts)) %>")