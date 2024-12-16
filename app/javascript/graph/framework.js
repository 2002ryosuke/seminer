function degree(data) { //次数の表示
    const degree = {};
    let count = 0;
    data.points.forEach(point => {
        count = 0;
        data.lines.forEach(line => {
            if ( point.id == line.source.id ){
                count++;
            } else if ( point.id == line.target.id ){
                count++;
            };
        });
        degree[point.id] = count;
    });
    return degree;
};

export function simple_graph(data, select_work) { //単純グラフの判定
    const lines_array = [];
    let line_array = [];
    data.lines.forEach(line => {
        line_array = [];
        line_array.push(line.source.id);
        line_array.push(line.target.id);
        lines_array.push(line_array);
    });
    console.log(lines_array);

    for (let i = 0; i < data.points.length ; i++ ){
        if (lines_array[i][0] == lines_array[i][1]){
            select_work.innerHTML = 'ループが存在しており、単純グラフではない';
            return false;
        };
        for (let n = 0; n < data.lines.length; n++){
            if ( i == n ){    
            } else if ((lines_array[i][0] == lines_array[n][0] && lines_array[i][1] == lines_array[n][1]) || (lines_array[i][0] == lines_array[n][1] && lines_array[i][1] == lines_array[n][0])){
                select_work.innerHTML = '多重辺が存在しており、単純グラフとは、言えない';
                return false;
            };
        };
    };
    return true;
}

export function jug_end_isolated(data, select_work) { //端点と孤立点の判定
    const degree_point = Object.values(degree(data));
    for (let i= 0; i < degree_point.length; i++){
        if (degree_point[i] == 1){
            select_work.innerHTML = "端点が存在するため、定形フレームワークではない！";
            return false;
        } else if (degree_point[i] == 0){
            select_work.innerHTML = "孤立点が存在するため、定形フレームワークではない！";
            return false;
        };
    };
    return true;
}


export function judgment_fixed(data, select_work) { //頂点数3, 4, 5の時の判定
    const degree_point = Object.values(degree(data));
    console.log(data);
    // TODO:３頂点から5頂点の場合, forEach文はbreakが使えないため、for文
    
    if (data.points.length == 3){ //3頂点の場合
        select_work.innerHTML = '定形フレームワーク！';
        return true;
    } else if (data.points.length == 4){ //4頂点の場合
        for (let i= 0; i < degree_point.length; i++){
            if (degree_point[i] == 3){
                select_work.innerHTML = '定形フレームワーク！';
                return true;
            };    
        };
        select_work.innerHTML = '定形フレームワークではない'
        return false;

        // if (jug_anser >= 1){
        //     select_work.innerHTML = '定形フレームワーク！';
        //     return true;
        // } else if (jug_anser == 0){
        //     select_work.innerHTML = '定形フレームワークではない';
        //     return false;
        // } else {
        //     select_work.innerHTML = '判定出来ませんでした';
        //     return false;
        // };
        
    } else if (data.points.length == 5) { //5頂点の場合
        let count_degree = 0;
        degree_point.forEach(degree => {
            if (degree >= 3){
                count_degree++;
            };
        });
        if (count_degree >= 3){
            select_work.innerHTML = '定形フレームワーク！'
            return true;
        } else {
            select_work.innerHTML = '定形フレームワークではない';
            return false;
        };
    } else {
        select_work.innerHTML = '6頂点以上のグラフは判定出来ません';
        return false;
    };
};