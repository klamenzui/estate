var loadTable = function (api, filter) {
  $.ajax({
    type: "POST",
    url: "/api/" + api + '/get',
    data: filter,
    //dataType: "jsonp",
    crossDomain: true,
    cache: false
  }).always(function( xhr, status ) {
    //$('#accPages a').toggleClass( 'alert-secondary', false);
    //$('#accPages a['+estate_id+']').toggleClass( 'alert-secondary', true);
    console.log(xhr.response,status);
    if(typeof xhr.response.rows != 'undefined'){
      var rows = xhr.response.rows;
      var columns = xhr.response.columns;//Object.keys(xhr.response.rows[0]);
      var thead = '<thead><tr>';
      var tfoot = '<tfoot><tr>';
      var tbody = '';
      for(var i in columns.all){
        /*if(columns[i] != 'id')
          var col = [i, columns[i]];
        if(columns[i].indexOf('date') > -1 && xhr.response[0][columns[i]].match('[0-9]{4}-[0-9]{2}-[0-9]{2}') != null){
          col.push('date');
        }
        editable.push([i, columns[i]]);*/
        thead += '<th>'+columns.all[i]+'</th>';
        tfoot += '<th>'+columns.all[i]+'</th>';
      }
      thead += '</tr></thead>';
      tfoot += '</tr></tfoot>';
      for(var i in rows){
        tbody += '<tr></td>';
        for(var j in columns.all){
          let t_field = columns.all[j];
          console.log(t_field);
          tbody += '<td>'+rows[i][t_field]+'</td>';
        }
        tbody += '</tr><br/>';
      }
      $('#dataTable').html(thead + tbody + tfoot).attr('url', '/api/' + api + '/set');
      //console.log(columns, editable);
      $('#dataTable').Tabledit({
        //[[1, 'First'],[2, 'Last'],[3, 'Nickname', '{"1": "@mdo", "2": "@fat", "3": "@twitter"}']]
        columns: columns,
        // class for form inputs
        inputClass: 'form-control input-sm',
        // // class for toolbar
        toolbarClass: 'btn-toolbar',
        // class for buttons group
        groupClass: 'btn-group btn-group-sm',
        // class for row when ajax request fails
        dangerClass: 'danger',
        // class for row when save changes
        warningClass: 'warning',
        // class for row when is removed
        mutedClass: 'text-muted',
        // trigger to change for edit mode.
        // e.g. 'dblclick'
        eventType: 'click',
        // change the name of attribute in td element for the row identifier
        //rowIdentifier: 'id',
        // activate focus on first input of a row when click in save button
        autoFocus: true,
        // hide the column that has the identifier
        hideIdentifier: false,
        // activate edit button instead of spreadsheet style
        editButton: true,
        // activate delete button
        deleteButton: true,
        // activate save button when click on edit button
        saveButton: true,
        // activate restore button to undo delete action
        restoreButton: true,
        // custom action buttons
        buttons: {
          edit: {
            class: 'btn btn-sm btn-default',
            html: '<span class="fa fa-pencil-alt" data-toggle="modal" data-target="#modal_window" data-url="/parts/message/payment"></span>',
            action: 'edit'
          },
          delete: {
            class: 'btn btn-sm btn-default',
            html: '<span class="fa fa-trash"></span>',
            action: 'delete'
          },
          save: {
            class: 'btn btn-sm btn-success',
            html: 'Save'
          },
          restore: {
            class: 'btn btn-sm btn-warning',
            html: 'Restore',
            action: 'restore'
          },
          confirm: {
            class: 'btn btn-sm btn-danger',
            html: 'Confirm'
          }
        },
        // executed after draw the structure
        onDraw: function() { return; },
        // executed when the ajax request is completed
        // onSuccess(data, textStatus, jqXHR)
        onSuccess: function(data, textStatus, jqXHR) {
          console.log('onSuccess(data, textStatus, jqXHR)');
          console.log(data);
          var tr = $('#dataTable').find('tr[row="new"]').attr('id', data.response.insertId).attr('row', '');
          tr.find('span.tabledit-identifier').html(data.response.insertId);
          tr.find('input.tabledit-identifier').val(data.response.insertId);
          console.log(textStatus);
          console.log(jqXHR);
        },
        // executed when occurred an error on ajax request
        // onFail(jqXHR, textStatus, errorThrown)
        onFail: function(jqXHR, textStatus, errorThrown) { console.log(jqXHR, textStatus, errorThrown); },
        // executed whenever there is an ajax request
        onAlways: function() { return; },
        // executed before the ajax request
        // onAjax(action, serialize)
        onAjax: function(action, serialize) { console.log(action, serialize); }
      });
      $('#dataTable').data('Tabledit').reload();
      $('input.tabledit-input').on( 'input', function(me){autocomplete(me)});
      //<a class="dropdown-item" href="#" >aaa</a>
      $('#dataTable > thead .tabledit-toolbar-column').html('<button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#modal_window" data-url="/parts/message/payment">Add Row</button>');
      /*
      $('#addbutton').click(function() {
        var table = $('#dataTable');
        if(table.find('tr[row="new"]').length == 0) {
          table.find('tbody > tr:first').before('<tr row="new"><td>'+('</td><td>'.repeat(editable.length-1))+'</td></tr>');
          table.data('Tabledit').reload();
          $('input.tabledit-input').on( 'input', function(me){autocomplete(me)});
        }
      });*/

    } else {
      $('#dataTable').html('no data');
    }
  });
}

$(document).ready(function() {
  "use strict"; // Start of use strict


/*
    $.ajax({
      type: "POST",
      url: "/api/estate/getAddress",
      //data: '{"userId":"'+userId+'"}',
      //dataType: "jsonp",
      crossDomain: true,
      cache: false
    }).always(function( xhr, status ) {
      console.log(xhr.response,status);
      let temp1 = xhr.response;
      let tpl = '';
      let menuItems = [];
      for(let i in temp1){
        menuItems.push('<a class="collapse-item" href="/estate/get?id='+temp1[i]['estate_id']+'">#'+temp1[i]['estate_id']+'. '+temp1[i]['street']+' '+temp1[i]['house_number']+'</a>');
      }
      //$('#apartments_list').html(tpl);
      $('#accPages > div').html(menuItems.join('<br/>'));

      //$( '.lightboxed' ).lightboxed();
    });
	*/
    /*
        estate_id: 2
    ​apartment_number: 3
    ​city: "Кропивницкий"
    ​contract_id: 6
    ​country: "Украина"
    ​date_start: "2019-07-15T19:48:44.000Z"
    ​first_name: "Алексей"
    ​house_number: "19"
    ​images_dir: "img/002"
    ​latitude: "0"
    ​longitude: "0"
    ​period_type: "monthly"
    ​photos: "002"
    ​photos_list: Array(4) [ "20190130_161601.jpg", "20190130_161544.jpg", "1.jpeg", … ]
    ​price: 3000
    ​profit_total: 101900
    ​square: 24
    ​state: "Кировоградская"
    ​street: "Жадова"
    ​url: "https://www.google.de/maps/@0,0,200m/data=!3m1!1e3"
    */



}); // End of use strict
