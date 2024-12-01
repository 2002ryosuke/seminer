export function addElement(nodes) {
    const select = document.getElementById('select_node');
    select.innerHTML = nodes;
}

export function changeElement(nodes) {
    const display = document.getElementById('select_node');
    display.innerHTML = `{${nodes[0]},${nodes[1]}}の辺を作成！`;
}