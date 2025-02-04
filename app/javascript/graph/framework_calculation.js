export function calculation(data) {
    let p = [];
    data.points.forEach(point => {
        let i = [point.x, point.y];
        p.push(i);
        console.log(p)
    });
    
}