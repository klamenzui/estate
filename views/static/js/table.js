var loadTable = function (id) {
  let api, filter, me = document.getElementById(id);
  api = $(me).attr('api');
  filter = me.dataset;
  console.log('me:',me)
  console.log('filter:',filter)
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
      var data_filter = [];
      for(var i in columns.all){
        /*if(columns[i] != 'id')
          var col = [i, columns[i]];
        if(columns[i].indexOf('date') > -1 && xhr.response[0][columns[i]].match('[0-9]{4}-[0-9]{2}-[0-9]{2}') != null){
          col.push('date');
        }
        editable.push([i, columns[i]]);*/
        thead += '<th>'+columns.all[i]+'</th>';
        tfoot += '<th>'+columns.all[i]+'</th>';
        if(typeof filter[columns.all[i]] !== 'undefined'){
            data_filter.push(`data-${columns.all[i]}="${filter[columns.all[i]]}"`);
        }
      }
      data_filter = data_filter.join(' ');
      let primary_key = columns.primary_key;
      let filter_str = JSON.stringify(filter);
      let modal = `type="button" callback="loadTable('${id}')" data-toggle="modal" data-target="#modal_window" url="/parts/window/${api}"`;
      let addBtn = `<span action="set" ${data_filter + modal} class="fa fa-plus btn-sm btn-success"> </span></th></tr>`;
      thead += `<th>${addBtn}</thead>`;
      tfoot += `<th>${addBtn}</th></tr></tfoot>`;
      for(var i in rows){
        tbody += '<tr></td>';
        for(var j in columns.all){
          let t_field = columns.all[j];
          tbody += '<td>'+(typeof rows[i][t_field] !== 'undefined'? rows[i][t_field]: '')+'</td>';
        }
        let attr = `${data_filter + modal} data-${primary_key}="${rows[i][primary_key]}"`;
        tbody += `<td>
            <span action="set" ${attr} class="fa fa-pencil-alt btn-sm btn-primary"> </span>
            <span action="del" readonly="true" ${attr} class="fa fa-trash btn-sm btn-danger"> </span>
        </td>`;
        tbody += '</tr><br/>';
      }
      $('#dataTable').html(thead + tbody + ((rows.length)?tfoot:'')).attr('url', '/api/' + api + '/set');
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
