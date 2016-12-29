




var AdminLTEOptions = {
    //Enable sidebar expand on hover effect for sidebar mini
    //This option is forced to true if both the fixed layout and sidebar mini
    //are used together
    sidebarExpandOnHover: true,
    //BoxRefresh Plugin
    enableBoxRefresh: true,
    //Bootstrap.js tooltip
    enableBSToppltip: true
    };



/**
 * Created by cyril on 07/09/15.
 */



'use strict';




//Make sure jQuery has been loaded before app.js
if (typeof jQuery === "undefined") {
    throw new Error("The console script requires jQuery");
}


$('span[rel="popover"]').popover({
    container: 'body',
    html: true

}    );



$('.dataTable').DataTable({
});

$('#dataTableJs').DataTable({
    "order": [[1, "asc"]],
    "paging": false
});


$('#dataProperties').DataTable({
    "order": [[0, "asc"]],
    "paging": false
});



$(".buttonFilter").click(function () {
    $('#dataTableJs').dataTable().fnFilter($(this).val());
});




$("#notifyMultiple").click(function () {
    var url;
    $(".checkBoxes").each(function( index ) {
        if(this.checked) {
            url = '/notify/' + $(this).val();
            window.open(url, 'Notify the view', 'menubar=no, scrollbars=no, top=100, left=100, width=300, height=200');
        }
    });

});



$(".checkBoxes").change(function () {

    var cpt=0;
    $(".checkBoxes").each(function( index ) {
        if (this.checked)
            cpt = cpt + 1;
    });
    if (cpt)
        $("#notifyMultiple").show();
    else
        $("#notifyMultiple").hide();
});

$( "#sidebar" ).load( "/lavoisier/sidebar?accept=html");

$(".dataTableStyle").dataTable( {
    paging: false,
    "columnDefs": [
        { "width": "200px", "targets": 0 },
        { "width": "100px", "targets": 1 },
        { "width": "200px", "targets": 2 },
        { "width": "90px", "targets": 3 },
        { "width": "90px", "targets": 4 },
        { "width": "90px", "targets": 5 },
        { "width": "190px", "targets": 6 }
    ]
} );

$(".dataTableStyle2").dataTable({
    paging:false,
    filter:false
});

    /**
     * Fonction qui ajoute la class label correcte (success , warning..) au span de class label en fonction de la valeur du title
     *
     * @param percent
     * @returns {string}
     */
    var getColorClass = function(percent,treshold1,treshold2){

        var classname="label-info";



        if (percent > 80)
            classname="label-success";

        if (percent < 80)
            classname="label-danger";


        if (percent < 0)
            classname ="label-info";

        if (percent=='NaN')
            classname="label-default";


        if (percent=='N.A')
            classname="label-default";





        return classname;
    }



    var getColorClass2 = function(percent){

        var classname;

        if (percent > 5)
            classname="badge-important";

        if (percent <= 5)
            classname="badge-warning";

        if (percent <= 1)
            classname="badge-success";


        if (percent == 'Nan')
            classname="badge-success";


        if (percent=='NaN')
            classname="badge-default";


        if (percent=='N.A')
            classname="badge-default";
        

        return classname;
    }








function getHeatMapChart(xmlUrl,Title,containerId)
    {

        var options2 =
        {

            chart: {
                type: 'heatmap',
                marginTop: 40,
                marginBottom: 40,
                renderTo: containerId,
                backgroundColor: 'white'
            },


            title: {
                text: Title
            },

            scrollbar: {
                enabled: true
            },

            legend: {
                align: 'right',
                layout: 'vertical',
                margin: 0,
                verticalAlign: 'top',
                y: 25,
                symbolHeight: 320
            },




            yAxis: {
                categories: [],
                title: null,
                labels: {
                    format: '{value}'
                }

            },



            xAxis: {
                categories: [],
                title: null,
                labels: {
                    format: '{value}',
                    style: {
                        fontSize: '16px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }

            },

            colorAxis: {
                min: 0,
                max: 100,
                minColor: '#FF0000',
                maxColor: '#00FF00'
            },


            series: [     ]


        };


    $.get( xmlUrl, function(xml) {
        // Split the lines
        var $xml2=$(xml);



        // push series - Avv
        $xml2.find('series').each(function(i, series) {
            options2.yAxis.categories.push($(series).find('name').text());
            // push categories
            $xml2.find('categories item').each(function(i, category) {
                options2.xAxis.categories.push($(category).text());
            });



            var seriesOptions2 = {
                data: [[]],
                name: [],
                tooltip: {

                    backgroundColor: null,
                    borderWidth: 1,
                    borderColor : 'black',
                    distance: 10,
                    shadow: false,
                    useHTML: true,
                    style: {
                        padding: 10,
                        color: 'black'
                    },
                    headerFormat : '',
                    pointFormat : '{point.value} %'

                },

                dataLabels: {
                    enabled: true,
                    color: 'black',
                    style: {
                        textShadow: 'none',
                        HcTextStroke: null
                    }
                }




            };





            // push data points
            $(series).find('data point').each(function(j, point) {
                seriesOptions2.data.push([j,i, parseInt($(point).text() )]);

            });

            // add it to the options
            options2.series.push(seriesOptions2);
            new Highcharts.Chart(options2);


        });
    });
    }


    function add_location(extension){
        var currentLocation =  location.href;

        window.location = currentLocation.split('#')[0] + '&' + extension;
    };

    function  change_url(needle,haystack,options){
        options = options || '';
        var currentLocation =  document.location.href + options;
        window.location = currentLocation.split('#')[0].replace(needle,haystack);
    };


var newText = $(".output").text().replace('\n','<br/>')
$(".output").text(newText);
















