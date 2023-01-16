var autocomplete = function (me) {
    me = $(me.target);
    var elements = $('input.tabledit-input[name="' + me.attr('name') + '"]:hidden');
    console.log(me);
    var list = {};
    for (var i = 0; i < elements.length; i++) {
        console.log(elements.eq(i));
        var val = elements.eq(i).val();
        list[val] = typeof list[val] != 'undefined' ? list[val] + 1 : 1;
    }
    console.log(list);
    me.autocomplete({
        source: Object.keys(list)
    });
}

var processModal = function () {
    let body = $('#modal_window .modal-body');
    console.log('processModal:', body);
    let baseurl = body.attr('baseurl');
    let action = body.attr('action');
    console.log('baseurl:', baseurl, action);
    let els = body.find('.form-control');
    let fields = {};
    for (let k = 0; k < els.length; k++) {
        //console.log('k:', k);
        let el = els.eq(k);
        console.log('el:', el);
        fields[el.attr('name')] = typeof el.val == 'function' ? el.val() : el.text();
    }
    console.log('data:', fields);
    $.ajax({
        type: "POST",
        url: baseurl + action,
        data: fields,
        //dataType: "jsonp",
        crossDomain: true,
        cache: false
    }).always(function (xhr, status) {
        console.log(xhr, status);
        //$('.toast-container')
        $('#modal_window').modal('toggle');
        //me.html(xhr);
    });
}

$(document).ready(function () {
    "use strict"; // Start of use strict
    /*$("[action='modalOpen']").on('click', function (e) {
        modalOpen(this);
    });*/

    $('#modal_window').on('show.bs.modal', function (e) {
        let target = $(e.target);
        let relatedTarget = $(e.relatedTarget);
        let action = relatedTarget.attr('action');
        let readonly = relatedTarget.attr('readonly');
        let callback = relatedTarget.attr('callback');
        let url = relatedTarget.attr('url');
        let dataset = e.relatedTarget.dataset;
        console.log(e.relatedTarget, relatedTarget, target);
        console.log(dataset, target);
        console.log(action, readonly, url);
        let data = {};
        for (let k in dataset) {
            data[k] = dataset[k];
        }
        $.ajax({
            type: "POST",
            url: url,
            data: {callback:callback, action:action,readonly:readonly,data:data},
            //dataType: "jsonp",
            crossDomain: true,
            cache: false
        }).always(function (xhr, status) {
            //console.log(xhr, status);
            target.html(xhr);
        });
    });

    $('#modal_window').on('hidden.bs.modal', function (e) {
        let body = $('#modal_window .modal-body');
        let callback = body.attr('callback');
        console.log(body.attr('callback'));
        if(callback){
            eval(callback);
        }

    });

    $.ajax({
        type: "POST",
        url: "/api/estate/getAddress",
        //data: '{"userId":"'+userId+'"}',
        //dataType: "jsonp",
        crossDomain: true,
        cache: false
    }).always(function (xhr, status) {
        console.log(xhr.response, status);
        let rows = xhr.response.rows;
        let menuItems = [];
        for (let i in rows) {
            let r = rows[i];
            menuItems.push(`<a class="collapse-item" href="/estate/get?id=${r['estate_id']}">#${r['estate_id']}. ${r['street']} ${r['house_number']}</a>`);
        }
        //$('#apartments_list').html(tpl);
        $('#accPages > div').html(menuItems.join('\n'));

        //$( '.lightboxed' ).lightboxed();
    });


    // Toggle the side navigation
    $("#sidebarToggle, #sidebarToggleTop").on('click', function (e) {
        $("body").toggleClass("sidebar-toggled");
        $(".sidebar").toggleClass("toggled");
        if ($(".sidebar").hasClass("toggled")) {
            $('.sidebar .collapse').collapse('hide');
        }
        ;
    });

    // Close any open menu accordions when window is resized below 768px
    $(window).resize(function () {
        if ($(window).width() < 768) {
            $('.sidebar .collapse').collapse('hide');
        }
        ;

        // Toggle the side navigation when window is resized below 480px
        if ($(window).width() < 480 && !$(".sidebar").hasClass("toggled")) {
            $("body").addClass("sidebar-toggled");
            $(".sidebar").addClass("toggled");
            $('.sidebar .collapse').collapse('hide');
        }
    });

    // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
    $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function (e) {
        if ($(window).width() > 768) {
            var e0 = e.originalEvent,
                delta = e0.wheelDelta || -e0.detail;
            this.scrollTop += (delta < 0 ? 1 : -1) * 30;
            e.preventDefault();
        }
    });

    // Scroll to top button appear
    $(document).on('scroll', function () {
        var scrollDistance = $(this).scrollTop();
        if (scrollDistance > 100) {
            $('.scroll-to-top').fadeIn();
        } else {
            $('.scroll-to-top').fadeOut();
        }
    });

    // Smooth scrolling using jQuery easing
    $(document).on('click', 'a.scroll-to-top', function (e) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: ($($anchor.attr('href')).offset().top)
        }, 1000, 'easeInOutExpo');
        e.preventDefault();
    });

}); // End of use strict
