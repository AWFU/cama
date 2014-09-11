$("#result").empty()
  .append("<%= escape_javascript(render 'stores/search_result', stores: @stores) %>")