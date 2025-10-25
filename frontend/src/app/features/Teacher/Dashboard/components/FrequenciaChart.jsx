
import React from 'react';
import Highcharts from 'highcharts';
import HighchartsReact from 'highcharts-react-official';

const FrequenciaChart = ({ title, series }) => {
    const chartOptions = {
        chart: { type: 'column', height: 400 },
        title: { text: null },
        xAxis: {
            categories: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
            title: { text: null }
        },
        yAxis: { title: { text: 'Últimos 30 dias' } },
        plotOptions: { column: { dataLabels: { enabled: false } } },
        legend: { enabled: true },
        colors: ['#FF6B35', '#FF8C42', '#FFA94D'],
        accessibility: { enabled: false },
        series,
        credits: { enabled: false }
    };

    return (
        <div className="chart-container">
            <div className="chart-header">
                <h3>{title}</h3>
            </div>
            <div className="chart-body">
                <HighchartsReact highcharts={Highcharts} options={chartOptions} />
            </div>
        </div>
    );
};

export default FrequenciaChart;
