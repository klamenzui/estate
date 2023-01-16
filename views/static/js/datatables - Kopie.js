var autocomplete = function (me) {
	me = $(me.target);
	var elements = $('input.tabledit-input[name="'+me.attr('name')+'"]:hidden');
	console.log(me);
	var list = {};
	for(var i = 0; i < elements.length; i++){
		console.log(elements.eq(i));
		var val = elements.eq(i).val();
		list[val] = typeof list[val] != 'undefined' ? list[val] + 1: 1;
	}
	console.log(list);
	me.autocomplete({
		source: Object.keys(list)
	});
}

var loadTable = function (action, accommodation_id) {
	$.ajax({
		type: "POST",
		url: "/api/" + action,
		data: {"accommodation_id":accommodation_id },
		//dataType: "jsonp",
		crossDomain: true,
		cache: false
	}).always(function( xhr, status ) {
		$('#apartments_list div[accommodation_id]').toggleClass( 'alert-secondary', false);
		$('#apartments_list div[accommodation_id="'+accommodation_id+'"]').toggleClass( 'alert-secondary', true);
		console.log(xhr.data,status);
		if(typeof xhr.data[0] != 'undefined'){
			var editable = [];
			var columns = Object.keys(xhr.data[0]);
			var thead = '<thead><tr>';
			var tfoot = '<tfoot><tr>';
			var tbody = '';
			for(var i in columns){
				if(columns[i] != 'id')
					var col = [i, columns[i]];
					if(columns[i].indexOf('date') > -1 && xhr.data[0][columns[i]].match('[0-9]{4}-[0-9]{2}-[0-9]{2}') != null){
						col.push('date');
					}
					editable.push([i, columns[i]]);
				thead += '<th>'+columns[i]+'</th>';
				tfoot += '<th>'+columns[i]+'</th>';
			}
			for(var i in xhr.data){
				tbody += '<tr>';
				for(var j in columns){
					tbody += '<td>'+xhr.data[i][columns[j]]+'</td>';
				}
				tbody += '</tr><br/>';
			}
			thead += '</tr></thead>';
			tfoot += '</tr></tfoot>';
			$('#dataTable').html(thead + tbody + tfoot).attr('url', 'api/' + action);
			console.log(columns, editable);
			$('#dataTable').Tabledit({
				columns: {
					identifier: [0, 'id'],
					editable: editable //[[1, 'First'],[2, 'Last'],[3, 'Nickname', '{"1": "@mdo", "2": "@fat", "3": "@twitter"}']]
				},
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
				rowIdentifier: 'id',
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
						html: '<span class="glyphicon glyphicon-pencil"></span>',
						action: 'edit'
					},
					delete: {
						class: 'btn btn-sm btn-default',
						html: '<span class="glyphicon glyphicon-trash"></span>',
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
					var tr = $('#dataTable').find('tr[row="new"]').attr('id', data.data.insertId).attr('row', '');
					tr.find('span.tabledit-identifier').html(data.data.insertId);
					tr.find('input.tabledit-identifier').val(data.data.insertId);
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
			$('#dataTable > thead .tabledit-toolbar-column').html('<button type="button" id="addbutton">Add Row</button>');
			$('#addbutton').click(function() {
				var table = $('#dataTable');
				if(table.find('tr[row="new"]').length == 0) {
					table.find('tbody > tr:first').before('<tr row="new"><td>'+('</td><td>'.repeat(editable.length))+'</td></tr>');
					table.data('Tabledit').reload();
					$('input.tabledit-input').on( 'input', function(me){autocomplete(me)});
				}
			});
			
		} else {
			$('#dataTable').html('no data');
		}
	});
}
$(document).ready(function() {
	$.ajax({
		type: "POST",
		url: "/api/acc",
		//data: '{"userId":"'+userId+'"}',
		//dataType: "jsonp",
		crossDomain: true,
		cache: false
	}).always(function( xhr, status ) {
		console.log(xhr.data,status);
		let temp1 = xhr.data;
		let tpl = '';
		let menuItems = [];
		for(let i in temp1){
			console.log(temp1[i], typeof temp1[i]['photos_list']);
			menuItems.push('<a class="collapse-item" href="/acc/?id='+temp1[i]['accommodation_id']+'">#'+temp1[i]['accommodation_id']+'. '+temp1[i]['street']+' '+temp1[i]['house_number']+'</a>');
			let images = [];
			if(typeof temp1[i]['photos_list'] == 'object') {
				for(let img_index in temp1[i]['photos_list']){
					let style = 'style="width: 200px;height: 200px;';
					if(img_index != 0) style += 'display:none;';
					style += '"';
					images.push('<img '+style+' class="lightboxed img-thumbnail bd-placeholder-img img-fluid rounded-start" rel="'+temp1[i]['images_dir']+'" src="'+temp1[i]['images_dir']+'/'+temp1[i]['photos_list'][img_index]+'" class="card-img-top" alt="...">');
				}
			} else {
				images.push('<svg class="bd-placeholder-img img-thumbnail" width="200" height="200" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="No photos" preserveAspectRatio="xMidYMid slice" focusable="false"><title>No photos</title><rect width="100%" height="100%" fill="#868e96"></rect><text x="50%" y="50%" fill="#dee2e6" dy=".3em"></text></svg>');
			}
			
			tpl += `<div class="card shadow mb-4" accommodation_id="`+temp1[i]['accommodation_id']+`">
				<div class="card-body">
					<div class="col p-5 d-flex flex-column position-static">
						<strong class="d-inline-block mb-2 text-primary">#`+temp1[i]['accommodation_id']+'. '+temp1[i]['street']+' '+temp1[i]['house_number']+`</strong>
						<div class="mb-1 text-muted">Площадь: `+temp1[i]['square']+`, profit_total: `+temp1[i]['profit_total']+`.</div>
						<p class="card-text">Договор #`+temp1[i]['contract_id']+`</p>
						<p class="card-text">Имя: `+temp1[i]['first_name']+`</p>
						<p class="card-text">Цена: `+temp1[i]['price']+`</p>
						<p class="card-text">Дата начала: `+(temp1[i]['date_start']+'').substr(0,10)+`</p>
						<p class="card-text">Период: `+temp1[i]['period_type']+`</p>
						<a href="`+temp1[i]['url']+`" target="_blank">Map</a>
					</div>
					<div class="col-md-5">
					`+images.join('')+`
						<div class="btn-group" role="group">
							<button type="button" class="btn btn-outline-primary" onclick="loadTable('expense',`+temp1[i]['accommodation_id']+`)">Расход</button>
							<button type="button" class="btn btn-outline-primary" onclick="loadTable('payment',`+temp1[i]['accommodation_id']+`)">Доход</button>
						</div>
					</div>
				</div>
			</div>`;
		}
		//$('#apartments_list').html(tpl);
		$('#accPages > div').html(menuItems.join('<br/>'));

		//$( '.lightboxed' ).lightboxed();
	});
/*	
	accommodation_id: 2
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

	
	
});
