



    /**
     * Fonction qui ajoute la class label correcte (success , warning..) au span de class label en fonction de la valeur du title
     *
     * @param percent
     * @returns {string}
     */
    var getColorClass = function(percent,treshold1,treshold2){

        classname="";



        if (percent > 80)
            classname="label-success";

        if (percent < 80)
            classname="label-danger";


        if (percent == '-1')
            classname ="label-inverse";






        return classname;
    }



    var getColorClass2 = function(percent){

       

        if (percent > 5)
            classname="badge-important";

        if (percent <= 5)
            classname="badge-warning";

        if (percent <= 1)
            classname="badge-success";


        if (percent == 'Nan')
            classname="badge-success";

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

            legend: {
                align: 'right',
                layout: 'vertical',
                margin: 0,
                verticalAlign: 'top'


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






















