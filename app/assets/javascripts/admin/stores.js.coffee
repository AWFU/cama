$ ->
  #fetch_from_country
  $(document).on 'change', '#countries_select', (evt) ->
    $.ajax 'fetch_from_country',
      type: 'GET'
      dataType: 'script'
      data: {
        country_id: $("#countries_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        #console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        #console.log("Dynamic country select OK!")

  #fetch_from_city
  $(document).on 'change', '#cities_select', (evt) ->
    $.ajax 'fetch_from_city',
      type: 'GET'
      dataType: 'script'
      data: {
        city_id: $("#cities_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        #console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        #console.log("Dynamic country select OK!")

 