//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap
//= require chosen-jquery
//= require meiomask
//= require_tree .


@atualizar_chosen = () ->
  $('.chosen-select').chosen('destroy').chosen
    placeholder_text_single: 'Selecione'
    no_results_text: 'Nenhum resultado encontrado'

@do_on_load = () ->
  $.mask.masks.date = { mask : '39/19/9999' };
  $.mask.masks.currency = { mask : '99,999.999.999.999', type : 'reverse', defaultValue: '000'};
  $(".dateinput").setMask("date")
  $(".currency").setMask("currency")


$ ->
  do_on_load()
  $(window).bind('page:change', do_on_load)
  