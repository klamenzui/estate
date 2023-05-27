const $table = {
    'current': {},
    'obj': {},
    'new': function (element, callback) {
        //$table.obj[element_id] = ;
        console.log('element',element);
        $table.current = new Table(element, callback);
        $table.obj[$table.current.id] = $table.current;
        console.log('new',$table);
    },
    'load': function (id) {
        console.log('load',$table);
        if (id) {
            $table.current = $table.obj[id];
        }
        $table.current.load();
    },
    'on': function (name, func) {
        console.log('on',name,$table);
        $table.obj[$table.current.id].event[name] = func;
        $table.current = $table.obj[$table.current.id];
    }
};

class Table {
    constructor(element, callback) {
        this.event = {
            'callback': callback,
        }
        element = typeof element == 'string'? '#' + element: element;
        this.init($(element));
        console.log('me:', this);
        this.load();
    }

    hideCol(index) {
        let me = this;
        console.log(index);
        $('#'+me.id+' tr > *:nth-child(' + index + ')').hide();
        me.hide_col.push(index);
        localStorage.setItem(me.id,JSON.stringify(me.hide_col));
    }

    init(set_element) {
        console.log(set_element);
        this.api = set_element.attr('api');
        //this.id = set_element.attr('id');
        this.id = set_element.attr('table_id')? set_element.attr('table_id'):set_element.attr('id');
        this.ajax = {
            type: "POST",
            data: {},
            //dataType: "jsonp",
            crossDomain: true,
            cache: false
        };
        this.ajax.data = set_element.data();
        console.log('data', this.ajax.data);
        this.limit = [];
        this.hide_col = [];
        let cols = localStorage.getItem(this.id);
        this.hide_col = JSON.parse(cols?cols:'[]');

        let funcName = set_element.attr('callback');
        if(!this.event['callback'] && funcName){
            this.event['callback'] = window[funcName]? window[funcName]: funcName;
        }
    }

    on(name, func) {
        this.event[name] = func;
    }

    load() {
        let me = this;
        let opt = {};
        console.log('me:', me);
        console.log('filter:', me.ajax.data);
        for (let key in me.ajax) {
            opt[key] = me.ajax[key];
        }
        opt['url'] = '/api/' + me.api + '/get';
        console.log('options:', opt);
        $.ajax(opt).always(function (xhr, status) {
            //$('#accPages a').toggleClass( 'alert-secondary', false);
            //$('#accPages a['+estate_id+']').toggleClass( 'alert-secondary', true);
            console.log(xhr.response, status);
            if (typeof xhr.response.rows != 'undefined') {
                var rows = xhr.response.rows;
                var columns = xhr.response.columns;//Object.keys(xhr.response.rows[0]);
                var thead = '<thead><tr>';
                var tfoot = '<tfoot><tr>';
                var tbody = '';
                var data_filter = [];
                console.log('rows',columns);
                for (var i in columns.all) {
                    /*if(columns[i] != 'id')
                      var col = [i, columns[i]];
                    if(columns[i].indexOf('date') > -1 && xhr.response[0][columns[i]].match('[0-9]{4}-[0-9]{2}-[0-9]{2}') != null){
                      col.push('date');
                    }
                    editable.push([i, columns[i]]);*/
                    let field = columns.all[i];
                    thead += `<th><input name="${field}" type="text" value="${me.ajax.data[field] ? me.ajax.data[field] : ''}"/>
                    <div><span class="fa fa-toggle-off" role="button"></span><span class="m-3">${field}</span></div></th>`;
                    tfoot += '<th>' + field + '</th>';
                    if (typeof me.ajax.data[field] !== 'undefined') {
                        data_filter.push(`data-${field}="${me.ajax.data[field]}"`);
                    }
                }
                data_filter = data_filter.join(' ');
                let primary_key = columns.primary_key;
                // let filter_str = JSON.stringify(table_data.data);
                let modal = `type="button" callback="$table.load()" data-toggle="modal" data-target="#modal_window" url="/parts/window/${me.api}"`;
                let addBtn = `<span action="set" ${data_filter + modal} class="fa fa-plus btn-sm btn-success"> </span><span class="fa fa-toggle-on" role="button"></span></th></tr>`;
                thead += `<th>${addBtn}</thead>`;
                tfoot += `<th>${addBtn}</th></tr></tfoot>`;
                console.log('rows',rows);
                for (var i in rows) {
                    tbody += '<tr></td>';
                    for (var j in columns.all) {
                        let t_field = columns.all[j];
                        tbody += `<td name="${t_field}">` + (typeof rows[i][t_field] !== 'undefined' ? rows[i][t_field] : '') + '</td>';
                    }
                    let attr = `${data_filter + modal} data-${primary_key}="${rows[i][primary_key]}"`;
                    tbody += `<td>
            <span action="set" ${attr} class="fa fa-pencil-alt btn-sm btn-primary"> </span>
            <span action="del" readonly="true" ${attr} class="fa fa-trash btn-sm btn-danger"> </span>
        </td>`;
                    tbody += '</tr><br/>';
                }
                $('#dataTable').html(thead + tbody + ((rows.length) ? tfoot : '')).attr('url', '/api/' + me.api + '/set');
                $('#dataTable th input').on('change', function (e) {
                    console.log(e);
                    let input = e.currentTarget;
                    if (input && input.name) {
                        if (input.value === '') {
                            delete me.ajax.data[input.name];
                        } else {
                            me.ajax.data[input.name] = input.value;
                        }
                        $table.load();
                    }
                });
                $('#'+me.id+' th span.fa-toggle-off').on('click', function (e) {
                    let index = (e.currentTarget.parentElement.parentElement.cellIndex + 1);
                    me.hideCol(index);
                });
                $('#'+me.id+' th span.fa-toggle-on').on('click', function (e) {
                    me.hide_col = [];
                    $('#'+me.id+' tr > *').show();
                    localStorage.clear();
                });
                for (let i in me.hide_col) {
                    $('#'+me.id+' tr > *:nth-child(' + me.hide_col[i] + ')').hide();
                }
                for(let e_name in me.event){
                    console.log(e_name);
                    if(/*e_name.indexOf('click') > -1 &&*/ typeof me.event[e_name] == 'function'){
                        $('#'+me.id+' tr').on(e_name, function (e) {
                            me.event[e_name](e);
                        });
                    }else{
                        console.log(e_name);
                    }
                }
            } else {
                $('#'+me.id).html('no data');
            }
            if (typeof me.event['callback'] == 'function') {
                me.event['callback'](me.ajax.data);
            }
        });
    }
}



$(document).ready(function () {
    "use strict"; // Start of use strict

    $('table[auto-render="true"]').each(function(a,b){
        $table.new(b);
    });
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
