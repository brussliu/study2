function showTestInfoChatByBook(){

    var bookList = $("#bookList").val();
    var perList = $("#perList").val();


    const labels = ["A.勉強","B.中日訳英","C.音訳英","D.英訳中"];

    const semesters = bookList.split(",");

    // const semesters = [
    //     '01.三級単語<br/>2935個', '02.三級熟語', '03.キクタン', '04.キクジュク',
    //     '11.二級単語', '12.二級熟語', '13.キクタン準２級', '14.キクタンBasic', '15.キクタン２級',
    //     '90.新概念単語2'
    // ];

    // 示例分数数据（可替换为真实成绩）
    const scores = new Array();
    const perListArray = perList.split(",");
    for(var i = 0;i < perListArray.length; i ++){
        var perArray = perListArray[i].split("-");

        scores.push(perArray);
    }

    // const scores = [
    //     [100, 80, 0, 0], [50, 60, 0, 0],[0, 50, 0, 0], [0, 50, 0, 0],
    //     [90, 94, 85, 91], [89, 93, 84, 90],[91, 95, 86, 92], [90, 94, 87, 91],[92, 96, 88, 93], 
    //     [91, 95, 89, 92]
    // ];

    const container = document.getElementById('charts');

    semesters.forEach((term, index) => {
        
        const box = document.createElement('div');
        box.className = 'chart-box';
        box.innerHTML = '<h3>' + term + '</h3><canvas id="chart' + index + '" width="220" height="220"></canvas>';
        container.appendChild(box);

        const ctx = document.getElementById("chart" + index).getContext('2d');
        new Chart(ctx, {
            type: 'polarArea',
            data: {
            labels: labels,
            datasets: [{
                data: scores[index],
                backgroundColor: [
                'rgba(255, 99, 132, 0.5)',
                'rgba(54, 162, 235, 0.5)',
                'rgba(255, 206, 86, 0.5)',
                'rgba(75, 192, 192, 0.5)'
                ],
                borderColor: [
                'rgba(255, 99, 132, 0.5)',
                'rgba(54, 162, 235, 0.5)',
                'rgba(255, 206, 86, 0.5)',
                'rgba(75, 192, 192, 0.5)'
                ],
                borderWidth: 0,
                hoverBackgroundColor: [
                'rgba(255, 99, 132, 0.8)',
                'rgba(54, 162, 235, 0.8)',
                'rgba(255, 206, 86, 0.8)',
                'rgba(75, 192, 192, 0.8)'
                ]
            }]
            },
            options: {
                plugins: {
                    legend: { display: false },
                    datalabels: {
                    color: 'rgb(50, 50, 50)',
                    font: { weight: 'bold', size: 10 },
                    formatter: (value, context) => context.chart.data.labels[context.dataIndex]
                    },
                    tooltip: {
                    callbacks: {
                        label: context => context.label + ': ' + context.formattedValue + '%'
                    }
                    }
                },
                scales: {
                    r: {
                        beginAtZero: true,
                        max: 100,
                        backgroundColor: 'rgb(225, 255, 255)',
                        ticks: { 
                            stepSize: 20,
                            backdropColor: 'transparent'
                        },
                        grid: {
                        }

                    }
                },
                
            },
            plugins: [ChartDataLabels]
        });

    });

}


function showTestTimeInfoChat(){

    var dList = $("#dList").val();

    var tkList = $("#tkList").val();
    var tkArray = tkList.split(",");

    var tmList = $("#tmList").val();
    var tmArray = tmList.split(",");

    var ptList = $("#ptList").val();
    var pmArray = ptList.split(",");


    const ctx = document.getElementById('myChart1').getContext('2d');

    const labels = dList.split(",");

    // const labels = [
    //     "10/5\n金","10/6","10/7","10/8","10/9","10/10","10/11",
    //     "10/12","10/13","10/14","10/15","10/16","10/17","10/18"
    // ]

    const backgroundColors = [];
    for(var i = 0;i < labels.length;i ++){

        if(labels[i].includes("土") || labels[i].includes("日")){
            backgroundColors.push("rgba(150,150,150, 0.5)");
        }else{
            backgroundColors.push("rgba(0, 128, 255, 0.4)");
        }
    }


    const datasets1 = {
            type: "bar",
            label: '単語数',
            // data: [234, 350, 541, 935, 666, 723, 444, 444, 812, 555, 0, 1200, 777, 0],
            data: tkArray,
            backgroundColor: backgroundColors,
            //borderColor: " rgba(0, 128, 255, 1)",
            // backgroundColor: [
            //     'rgba(255, 0, 0, 0.5)',      // | 1    | 红色           | 
            //     'rgba(255, 40, 0, 0.5)',     // | 2    | 深橙红色       | 
            //     'rgba(255, 128, 0, 0.5)',    // | 3    | 橙色           | 
            //     'rgba(255, 180, 0, 0.5)',    // | 4    | 金橙色         | 
            //     'rgba(255, 255, 0, 0.5)',    // | 5    | 黄色           | 
            //     'rgba(180, 255, 0, 0.5)',    // | 6    | 黄绿色         | 
            //     'rgba(0, 200, 0, 0.5)',      // | 7    | 草绿色         | 
            //     'rgba(0, 255, 128, 0.5)',    // | 8    | 青绿色         | 
            //     'rgba(0, 255, 255, 0.5)',    // | 9    | 青色           | 
            //     'rgba(0, 128, 255, 0.5)',    // | 10   | 天蓝色         | 
            //     'rgba(0, 0, 255, 0.5)',      // | 11   | 蓝色           | 
            //     'rgba(75, 0, 130, 0.5)',     // | 12   | 靛蓝色         | 
            //     'rgba(148, 0, 211, 0.5)',    // | 13   | 紫色           | 
            //     'rgba(255, 20, 147, 0.5)'    // | 14   | 荧光粉红（最显眼）
            // ],
            // borderColor: [
            //     'rgba(255, 0, 0, 0.5)',      // | 1    | 红色           | 
            //     'rgba(255, 40, 0, 0.5)',     // | 2    | 深橙红色       | 
            //     'rgba(255, 128, 0, 0.5)',    // | 3    | 橙色           | 
            //     'rgba(255, 180, 0, 0.5)',    // | 4    | 金橙色         | 
            //     'rgba(255, 255, 0, 0.5)',    // | 5    | 黄色           | 
            //     'rgba(180, 255, 0, 0.5)',    // | 6    | 黄绿色         | 
            //     'rgba(0, 200, 0, 0.5)',      // | 7    | 草绿色         | 
            //     'rgba(0, 255, 128, 0.5)',    // | 8    | 青绿色         | 
            //     'rgba(0, 255, 255, 0.5)',    // | 9    | 青色           | 
            //     'rgba(0, 128, 255, 0.5)',    // | 10   | 天蓝色         | 
            //     'rgba(0, 0, 255, 0.5)',      // | 11   | 蓝色           | 
            //     'rgba(75, 0, 130, 0.5)',     // | 12   | 靛蓝色         | 
            //     'rgba(148, 0, 211, 0.5)',    // | 13   | 紫色           | 
            //     'rgba(255, 20, 147, 0.5)'    // | 14   | 荧光粉红（最显眼）
            // ],
            borderWidth: 1,
            yAxisID: 'y1'
    };

    const datasets2 = {
            type: "line",
            label: '時間(分)',
            // data: [20, 35, 54, 93, 6, 7, 44, 0, 8, 55, 30, 42, 37, 10],
            data: tmArray,
            borderColor: 'rgba(0, 0, 255, 1)',
            backgroundColor: 'rgba(0, 0, 255, 0)',
            borderWidth: 1.5,
            borderDash: [3],
            yAxisID: 'y2'
    };

    const datasets3 = {
            type: "bubble",
            label: '中断回数',
            data: [
                {x: labels[0],   y: tmArray[0],   r: pmArray[0] },
                {x: labels[1],   y: tmArray[1],   r: pmArray[1] },
                {x: labels[2],   y: tmArray[2],   r: pmArray[2] },
                {x: labels[3],   y: tmArray[3],   r: pmArray[3] },
                {x: labels[4],   y: tmArray[4],   r: pmArray[4] },
                {x: labels[5],   y: tmArray[5],   r: pmArray[5] },
                {x: labels[6],   y: tmArray[6],   r: pmArray[6] },
                {x: labels[7],   y: tmArray[7],   r: pmArray[7] },
                {x: labels[8],   y: tmArray[8],   r: pmArray[8] },
                {x: labels[9],   y: tmArray[9],   r: pmArray[9] },
                {x: labels[10],  y: tmArray[10],  r: pmArray[10] },
                {x: labels[11],  y: tmArray[11],  r: pmArray[11] },
                {x: labels[12],  y: tmArray[12],  r: pmArray[12] },
                {x: labels[13],  y: tmArray[13],  r: pmArray[13] }
            ],
            yAxisID: 'y2',
            backgroundColor: 'rgba(255, 0, 255, 0.5)',

    };

    const datasets4 = {
            type: "line",
            label: '最低時間',
            // data: [20, 35, 54, 93, 6, 7, 44, 0, 8, 55, 30, 42, 37, 10],
            data: [25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25],
            borderColor: 'red',
            borderWidth: 2,
            borderDash: [6, 4],
            pointRadius: 0,
            fill: false,
            yAxisID: 'y2'
    };

    new Chart(ctx, {

        data: {
            labels: labels,
            datasets: [datasets1, datasets2, datasets3, datasets4],
        },

        options: {

            scales: {
                y1: {
                    position: 'left',
                    ticks: {
                        font: {
                            size: 12
                        }
                    }
                },
                y2: {
                    position: 'right',
                    grid: {
                    drawOnChartArea: false
                    },
                    ticks: {
                        font: {
                            size: 12
                        }
                    }
                },
                x: {
                    ticks: {
                        callback: function(value) {
                            return this.getLabelForValue(value).split('\n');
                        },
                        font: {
                            size: 12
                        }
                    }
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: '直近単語テスト情報統計表',
                    color: 'rgb(0, 0, 0)',
                    font: {
                        size: 20 
                    }
                },
                legend: {
                    display: true,

                }
            }
        }
    });

}



function showWordInfoChat(){

    const ctx = document.getElementById('myChart2').getContext('2d');

    var ddList = $("#ddList").val();
    var ddArray = ddList.split(",");

    const labels = addElementsToEdgesInPlace(ddArray, "");

    var studed_aList = $("#studed_aList").val();
    var studed_aArray = studed_aList.split(",");
    const data1 = addElementsToEdgesInPlace(studed_aArray, 0);

    var studed_bList = $("#studed_bList").val();
    var studed_bArray = studed_bList.split(",");
    const data2 = extendArrayInPlace(studed_bArray);

    var studed_cList = $("#studed_cList").val();
    var studed_cArray = studed_cList.split(",");
    const data3 = extendArrayInPlace(studed_cArray);

    var studed_dList = $("#studed_dList").val();
    var studed_dArray = studed_dList.split(",");
    const data4 = addElementsToEdgesInPlace(studed_dArray, 0);


    // const data1_1 = [0,
    //             500, 500, 500, 500, 500, 500, 
    //             500, 500, 500, 500, 500, 500,0];
    // const data1_2 = [0,
    //             600, 600, 600, 600, 600, 600, 
    //             600, 600, 600, 600, 600, 600,0];
    // const data1_3 = [0,
    //             700, 700, 700, 700, 700, 700, 
    //             700, 700, 700, 700, 700, 700,0];
    // const data2 = [0,100, 300, 350, 500, 700, 800, 900, 1400, 1400, 1350, 1500, 1800,0];

    // const data3 = [0,95, 190, 280, 400, 550, 670, 860, 1300, 1250, 1300, 1350, 1600, 0];

    // const data4 = [0,195, 290, 380, 500, 650, 870, 960, 2300, 2250, 3300, 5350, 5600,0];

    // const datasets1_1 = {
    //         type: "bar",
    //         label: '01.三級単語',
    //         data: data1_1,
    //         backgroundColor: 'rgba(216, 191, 216, 0.7)',
    //         stack: 'A.勉強'
    //         // borderWidth: 1.5,
    //         // borderDash: [3],
    //         // yAxisID: 'y2'
    // };

    // const datasets1_2 = {
    //         type: "bar",
    //         label: '11.二級単語',
    //         data: data1_2,
    //         backgroundColor: 'rgba(147, 112, 219, 0.7)',
    //         stack: 'A.勉強'
    //         // borderWidth: 1.5,
    //         // borderDash: [3],
    //         // yAxisID: 'y2'
    // };

    // const datasets1_3 = {
    //         type: "bar",
    //         label: '90.新概念単語2',
    //         data: data1_3,
    //         backgroundColor: 'rgba(138, 43, 226, 0.8)',
    //         stack: 'A.勉強'
    //         // borderWidth: 1.5,
    //         // borderDash: [3],
    //         // yAxisID: 'y2'
    // };

    const datasets1 = {
            type: "bar",
            label: 'A.勉強',
            data: data1,
            backgroundColor: 'rgba(138, 43, 226, 0.8)',
            stack: 'A.勉強'
            // borderWidth: 1.5,
            // borderDash: [3],
            // yAxisID: 'y2'
    };

    const datasets2 = {
            type: "line",
            label: 'B.中日訳英',
            data: data2,
            borderColor: 'rgba(0, 0, 255, 1)',
            backgroundColor: 'rgba(0, 0, 255, 0)',
            stack: 'B.中日訳英'
            // borderWidth: 1.5,
            // borderDash: [3],
            // yAxisID: 'y2'
    };

    const datasets3 = {
            type: "line",
            label: 'C.音訳英',
            data: data3,
            borderColor: 'rgba(255, 0, 0, 1)',
            backgroundColor: 'rgba(255, 0, 0, 0)',
            stack: 'C.音訳英'
            // borderWidth: 1.5,
            // borderDash: [3],
            // yAxisID: 'y2'
    };

    const datasets4 = {
            type: "bar",
            label: 'D.中訳英',
            data: data4,
            backgroundColor: 'rgba(50, 200, 50, 0.8)',
            stack: 'D.中訳英'
            // borderWidth: 1.5,
            // borderDash: [3],
            // yAxisID: 'y2'
    };

    // 未勉強
    var allwordcountList = $("#allwordcountList").val();
    var allwordcountArray = allwordcountList.split(",");
    const totalUsed5_1 = extendArrayInPlace(allwordcountArray);
    const datasets5_1 = {
            order: 0,
            type: 'line',
            fill: '-1',
            label: '未勉強',
            data: totalUsed5_1,
            backgroundColor: 'rgba(255, 0, 255, 0.2)',
            borderColor: 'rgba(255, 0, 255, 1)',
            borderWidth: 0.5,
            stack: '未勉強',
            tension: 0,
            pointRadius: 0,
    };

    // 勉強済
    var studedList = $("#studedList").val();
    var studedArray = studedList.split(",");
    const totalUsed5_3 = extendArrayInPlace(studedArray);
    const datasets5_3 = {
            order: 2,
            type: 'line',
            fill: true,
            label: '勉強済',
            data: totalUsed5_3,
            backgroundColor: 'rgba(180, 200, 230, 0.2)',
            borderColor: 'rgba(180, 200, 230, 1)',
            borderWidth: 0.5,
            stack: '勉強済',
            tension: 0,
            pointRadius: 0,
    };

    // 勉強中
    
    var studyingList = $("#studyingList").val();
    var studyingArray = studyingList.split(",");

    const totalUsed5_2 = extendArrayInPlace(studyingArray);
    const datasets5_2 = {
            order: 1,
            type: 'line',
            fill: '-1',
            label: '勉強中',
            data: totalUsed5_2,
            backgroundColor: 'rgba(255, 255, 0, 0.2)',
            borderColor: 'rgba(255, 255, 0, 1)',
            borderWidth: 0.5,
            stack: '勉強中',
            tension: 0,
            pointRadius: 0,
    };




    new Chart(ctx, {

        data: {
            labels: labels,
            datasets: [
                // datasets1_3, datasets1_2,datasets1_1,
                datasets1, datasets2, datasets3, datasets4,
                datasets5_3, datasets5_2, datasets5_1
            ],
        },

        options: {
            scales: {
                x: {
                    //stacked: true,
                    offset: false,
                },
                y: {
                    stacked: true,
                    beginAtZero: true,
                    max: 12000,
                },
            },
            spanGaps: true,
            plugins: {
                title: {
                    display: true,
                    text: '単語勉強状況遷移図',
                    color: 'rgb(0, 0, 0)',
                    font: {
                        size: 20 
                    }
                },
                // legend: {
                //     display: true,
                //     labels: {
                //     generateLabels: chart => {
                //         const stack = {};
                //         chart.data.datasets.forEach(ds => {
                //         const cat = ds.stack;
                //         if (!stack[cat]) {
                //             stack[cat] = {
                //             text: cat,
                //             fillStyle: ds.backgroundColor,
                //             strokeStyle: ds.borderColor || ds.backgroundColor,
                //             hidden: false,
                //             datasetIndex: ds.stack
                //             };
                //         }
                //         });
                //         return Object.values(stack);
                //     }
                //     }
                // },
                // tooltip: {
                //     mode: 'index',
                //     intersect: false,
                //     filter: context => context.dataset.stack === 'A.勉強',
                //     callbacks: {
                //     label: context => `${context.dataset.label}: ${context.parsed.y} `
                //     }
                // }
            }
        }
    });

}


function extendArrayInPlace(arr) {
  if (!Array.isArray(arr) || arr.length === 0) {
    throw new Error("请输入一个非空数组");
  }

  arr.unshift(arr[0]);
  arr.push(arr[arr.length - 1]);
  return arr;
}
function addElementsToEdgesInPlace(arr, element) {
  if (!Array.isArray(arr)) {
    throw new Error("请输入一个有效的数组");
  }

  arr.unshift(element);
  arr.push(element);
  return arr;
}
