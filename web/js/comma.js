/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
            $('#rate1').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate1').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total1');
                divobj.value = total.toLocaleString("hi-IN");
            });            
            $('#rate2').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate2').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total2');
                divobj.value = total.toLocaleString("hi-IN");
            }); 
            $('#rate3').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate3').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total3');
                divobj.value = total.toLocaleString("hi-IN");
            });  
            $('#rate4').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate4').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total4');
                divobj.value = total.toLocaleString("hi-IN");
            }); 
            $('#rate5').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate5').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total5');
                divobj.value = total.toLocaleString("hi-IN");
            }); 
            $('#rate6').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate6').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total6');
                divobj.value = total.toLocaleString("hi-IN");
            }); 
            $('#rate7').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate7').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total7');
                divobj.value = total.toLocaleString("hi-IN");
            });  
            $('#rate8').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate8').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total8');
                divobj.value = total.toLocaleString("hi-IN");
            });
            $('#rate9').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate9').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total9');
                divobj.value = total.toLocaleString("hi-IN");
            });
            $('#rate10').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate10').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total10');
                divobj.value = total.toLocaleString("hi-IN");
            }); 
            $('#rate11').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate11').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total11');
                divobj.value = total.toLocaleString("hi-IN");
            });  
            $('#rate12').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate12').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total12');
                divobj.value = total.toLocaleString("hi-IN");
            });  
            $('#rate111').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#rate111').val();
                var total = qty * slrate;
                var divobj = document.getElementById('total1l');
                divobj.value = total.toLocaleString("hi-IN");
            });  
            $('#cmprate').keyup(function (ev) {
                var qty = 1;
                var slrate = $('#cmprate').val();
                var total = qty * slrate;
                var divobj = document.getElementById('cmptotal');
                divobj.value = total.toLocaleString("hi-IN");
            });  
            
            $(document).ready(function () {
            $("#convyarea").hide();
            $("#chek").on('change', (function () {
                $("#convyarea").toggle();
            }));
        });
        $(document).ready(function () {
            $('#bankitem').hide();
            $('input[type=radio]').change(function () {
                if ($('#facbnk').is(':checked')) {
                    $('#bankitem').show();
                } else {
                    $('#bankitem').hide();
                }
            });
      });
       $(document).ready(function () {
            $('#bankrow').hide();
            $('input[type=radio]').change(function () {
                if ($('#bnk').is(':checked')) {
                    $('#bankrow').show();
                     document.getElementById("bank").required = true;
                } else {
                    $('#bankrow').hide();
                     document.getElementById("bank").required = false;
                }
            });
        });
        $(document).ready(function () {
            $('#adjustrow').hide();
            $('input[type=radio]').change(function () {
                if ($('#adjust').is(':checked')) {
                    $('#adjustrow').show();
                    document.getElementById("adjst").required = true;
                    document.getElementById("company").required = true;
                } else {
                    $('#adjustrow').hide();
                    document.getElementById("adjst").required = false;
                     document.getElementById("company").required = false;
                }
            });
          
        });
      
        $(document).ready(function () {
            $("#lout").click(function () {

                if (confirm("Are you sure to logout?"))
                    document.forms[0].submit();
                else
                    return false;
            });
        });
        
   });  
