export function calculation_point(data){
    const cal_ob = {};
    console.log(data.lines[0].source.x);
    data.lines.forEach(line => {
        const cal_x = (line.source.x-line.target.x) ** 2;
        const cal_y = (line.source.y-line.target.y) ** 2;
        const cal = Math.sqrt( cal_x + cal_y ).toFixed(2);
        cal_ob[line.id] = cal;
    });
    return cal_ob;
};

export function initialize_cal(lines, cal, select){
    lines.forEach(line => {
    select.innerText +=  ` id: ${line.id}=>距離: ${cal[line.id]}, `;
    })
};

export function calculation_point_line(cy){
    const inner_array =[];
    cy.edges().forEach(line => {
        console.log(line);
        const source = line.source();
        const target = line.target();

        const dx = (target.position('x') - source.position('x')) ** 2;
        const dy = (target.position('y') - source.position('y')) ** 2;
        const length = Math.sqrt(dx + dy).toFixed(2); // 距離を計算
        
        inner_array.push(` id: ${line._private.data.id}=>距離: ${length}`);
    });
        console.log(inner_array);
        const inner = inner_array.join(",");
        return inner;
        // line.data('length', `距離: ${length}`); // エッジのラベルを更新
};

