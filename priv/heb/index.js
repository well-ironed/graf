// https://observablehq.com/@d3/hierarchical-edge-bundling

var jsdom = require('jsdom');
const { JSDOM } = jsdom;

const d3 = require('d3');
const getStdin = require('get-stdin');
const parseArgs = require('minimist');

const dom = new JSDOM(`<!DOCTYPE html><body></body>`);

const args = parseArgs(
    process.argv.slice(2),
    {string: ["color"], default: {"color": "#ccc"}});

const color = args.color;
const width = 954;
const radius = width / 2;

var line = d3.lineRadial()
    .curve(d3.curveBundle.beta(0.85))
    .radius(d => d.y)
    .angle(d => d.x);

var tree = d3.cluster()
    .size([2 * Math.PI, radius - 100]);

function id(node) {
  return `${node.parent ? id(node.parent) + "." : ""}${node.data.name}`;
}

function idWithoutRoot(node) {
    return id(node).split(".").slice(1);
}

function bilink(root) {
  const map = new Map(root.leaves().map(d => [id(d), d]));
  for (const d of root.leaves()) {
      d.incoming = [];
      d.outgoing = d.data.imports.map(i => [d, map.get(i)]);
  }

  for (const d of root.leaves()) {
      for (const o of d.outgoing) {
          o[1].incoming.push(o);
      }
  }
  return root;
}

function hierarchy(data, delimiter = ".") {
    let root;
    const map = new Map;
    data.forEach(function(d) {
        d.name = 'root.' + d.name;
        d.imports = d.imports.map(i => 'root.' + i);
    });
    data.forEach(function find(data) {
        const {name} = data;
        if (map.has(name)) return map.get(name);
        const i = name.lastIndexOf(delimiter);
        map.set(name, data);
        find({name: name.substring(0, i), children: []}).children.push(data);
        data.name = name.substring(i + 1);
        return data;
    });
    return {name: 'root', children: data, imports: []};
}

function hebChart(data) {
    let body = d3.select(dom.window.document.querySelector("body"));

    const root = tree(bilink(d3.hierarchy(data)
        .sort((a, b) => d3.ascending(a.height, b.height) || d3.ascending(a.data.name, b.data.name))));

    const svg = body.append("div").attr("class", "container")
        .append("svg")
        .attr("viewBox", [-width / 2, -width / 2, width, width])
        .attr("xmlns", "http://www.w3.org/2000/svg");

    const node = svg.append("g")
        .attr("font-family", "sans-serif")
        .attr("font-size", 10)
        .selectAll("g")
        .data(root.leaves())
        .join("g")
        .attr("transform", d => `rotate(${d.x * 180 / Math.PI - 90}) translate(${d.y},0)`)
        .append("text")
        .attr("dy", "0.31em")
        .attr("x", d => d.x < Math.PI ? 6 : -6)
        .attr("text-anchor", d => d.x < Math.PI ? "start" : "end")
        .attr("transform", d => d.x >= Math.PI ? "rotate(180)" : null)
        .text(d => d.data.name)
        .each(function(d) { d.text = this; })
        .call(text => text.append("title").text(d => `${idWithoutRoot(d)}
            ${d.outgoing.length} outgoing
            ${d.incoming.length} incoming`));

    const link = svg.append("g")
        .attr("stroke", color)
        .attr("fill", "none")
        .selectAll("path")
        .data(root.leaves().flatMap(leaf => leaf.outgoing))
        .join("path")
        .style("mix-blend-mode", "multiply")
        .attr("d", ([i, o]) => line(i.path(o)))
        .each(function(d) { d.path = this; });

    return body.select(".container").html();
}

(async() => {
    var input = await getStdin();
    var data = hierarchy(JSON.parse(input));
    var chart = hebChart(data);
    process.stdout.write(chart + "\n");
})();
