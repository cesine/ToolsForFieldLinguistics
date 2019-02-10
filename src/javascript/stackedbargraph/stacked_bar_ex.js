$(function () {
    var css_id = "#placeholder";
    var data = [
        {label: 'null', data: [[1,300], [2,300], [3,300], [4,300], [5,300]]},
        {label: 'ing', data: [[1,800], [2,600], [3,400], [4,200], [5,0]]},
        {label: 'en/ed', data: [[1,100], [2,200], [3,300], [4,400], [5,500]]},
    ];
    var options = {
        series: {stack: 0,
                 lines: {show: false, steps: false },
                 bars: {show: true, barWidth: 0.9, align: 'center',},},
        xaxis: {ticks: [[1,'Punctual Event'], [2,'Iterative Event'], [3,'Process+Result'], [4,'Result'], [5,'Result State']]},
    };

    $.plot($(css_id), data, options);
});
