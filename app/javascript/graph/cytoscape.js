import cytoscape from "cytoscape";
import { FetchRequest } from '@rails/request.js'

export function initializeGraph(data) {
    return cytoscape({
        container: document.getElementById("cy"),
        elements: {
            nodes: data.points.map(point => ({
              data: { id: `Z${point.id}` },
              position: { x: point.x, y: point.y }
            })),
            edges: data.lines.map(line => ({
              data: {
                id: line.id,
                source: `Z${line.source.id}`,
                target: `Z${line.target.id}`
              }
            }))
          },

        style: [
            {
                selector: 'node',
                style: {
                    'label': 'data(id)',
                    'color': '#008b8d' 
                }
            },
            {
                selector: 'edge',
                style: {
                    'label': 'data(id)',
                    'color': '#008b8d',
                // 'target-arrow-shape': 'triangle', 	有効グラフになる
				'curve-style': 'bezier', //線を曲線にする
                }
            },
        ],
        layout: {
            name: 'preset',
        }
    });
}

export async function createPoint(point_x, point_y) {
    const request = new FetchRequest('post', '/points', {
        body: JSON.stringify({ point: { x: point_x, y: point_y} }),
        contentType: 'application/json',
    });
    const response = await request.perform()
     if (response.ok) {
        const body = await response.text
    }
    window.location.reload();
};

export async function createLine(line_source, line_target) {
    const request = new FetchRequest('post', '/lines', {
        body: JSON.stringify({ line: { source_id: line_source, target_id: line_target} }),
        contentType: 'application/json',
    });
    const response = await request.perform()
     if (response.ok) {
        const body = await response.text
    }
};

export async function deletePoint(point_delete) {
    const request = new FetchRequest('delete', '/points/' + point_delete, {
        // contentType: 'application/json',
    });
    const response = await request.perform()
    if (response.ok) {
        console.log('delete success');
    }
};

export function addNode(cy, id, x, y) {
    cy.add({
        group: 'nodes',
        data: { id: id },
        position: {
            x: x,
            y: y
        }
    });
};

export function addLine(cy, id, source, target) {
    cy.add({
        group: 'edges',
        data: { id: id, source: source, target: target}
    });
};